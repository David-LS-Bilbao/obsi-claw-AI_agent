# AUDITORIA_EGRESS_ALLOWLIST_SPRINT_1.md

## Resumen ejecutivo

La auditoría readonly específica de `egress/allowlist` confirma que el boundary OpenClaw tiene aislamiento topológico básico y una ruta explícitamente habilitada hacia el `inference-gateway` host-side, pero no tiene una allowlist real de egress ni un `deny-by-default` efectivo en las reglas observadas de Docker/iptables.

`openclaw-gateway` sigue en la red dedicada `agents_net`, no aparece unido a `verity_network` y solo publica `127.0.0.1:18789` en host. A la vez, el host escucha en `172.22.0.1:11440` y `UFW` mantiene una regla de entrada específica para `172.22.0.0/16 -> 172.22.0.1:11440/tcp`.

El gap principal aparece en la postura efectiva de salida: `DOCKER-USER` está vacía, `DOCKER-FORWARD` acepta tráfico desde `br-0759beecc34d` hacia cualquier destino y `POSTROUTING` aplica `MASQUERADE` a `172.22.0.0/16` fuera del bridge. Con esa evidencia no es defendible afirmar que `agents_net` opere ya bajo allowlist o `deny-by-default`.

Conclusión operativa del sprint:

- el gap deja de ser una incógnita host-side;
- queda caracterizado como deuda real de hardening;
- sigue `ROJO` como cierre de seguridad, aunque ya no queda `pendiente de verificación en host` en su postura base.

## Modelo esperado vs estado observado

### Modelo esperado

Según [README.md](/opt/control-plane/README.md#L57), [docs/AGENT_ZONE_EGRESS_ALLOWLIST_MVP.md](/opt/control-plane/docs/AGENT_ZONE_EGRESS_ALLOWLIST_MVP.md#L1) y [docs/OPENCLAW_SECURITY_BOOTSTRAP_MVP.md](/opt/control-plane/docs/OPENCLAW_SECURITY_BOOTSTRAP_MVP.md#L32), OpenClaw debería:

- alcanzar su propio gateway local en `127.0.0.1:18789`;
- alcanzar el boundary de inferencia aprobado en `172.22.0.1:11440`;
- permanecer separado de `verity_network`;
- no tener Internet libre ni acceso implícito al host completo como postura final deseada.

### Qué admite ya la documentación

La propia documentación de `control-plane` reconoce que:

- la allowlist real de egress sigue pendiente;
- el hardening final de egress no debe darse por cerrado;
- existe drift entre intención documental y reglas runtime en firewall/UFW.

### Estado observado

La evidencia host-side confirma:

- aislamiento topológico básico entre bridges Docker;
- ruta aprobada y visible hacia `172.22.0.1:11440`;
- ausencia de una allowlist real de salida materializada;
- ausencia de evidencia suficiente para afirmar bloqueo final hacia todo destino no aprobado.

## Alcance y límites

- Solo se usaron comandos readonly de inspección.
- No se modificó `UFW`, `iptables`, Docker, `systemd` ni el runtime.
- No se lanzaron probes a Internet pública desde el contenedor.
- La conclusión se apoya en reglas efectivas observadas, listeners visibles, contadores y contrato runtime/documental.

## Semáforo de hallazgos

| Checkpoint | Semáforo | Estado | Evidencia |
| --- | --- | --- | --- |
| Aislamiento topológico de `agents_net` | Verde | Confirmado | `openclaw-gateway` es el único contenedor en `agents_net` y Docker mantiene aislamiento entre bridges |
| Exposición host-side del gateway | Verde | Confirmado | publicación limitada a `127.0.0.1:18789` |
| Ruta aprobada hacia `172.22.0.1:11440` | Verde | Confirmada a nivel de listener/rule path | listener host-side visible y regla `UFW` específica para `11440/tcp` desde `172.22.0.0/16` |
| Allowlist real de egress | Rojo | No aplicada | `DOCKER-USER` vacía, `DOCKER-FORWARD` permisiva y `MASQUERADE` para `172.22.0.0/16` |
| Bloqueo específico de salida arbitraria | Rojo | No demostrado | no se observa regla efectiva equivalente a `deny-by-default` para `agents_net` |
| Bloqueo específico hacia otros servicios host-side | Ámbar | No demostrado como cierre | el host expone `22/80/443` en `0.0.0.0` y no se observa una exclusión específica de `172.22.0.0/16` en esas reglas genéricas |

## Evidencia por bloques

### 1. Contrato runtime observado

Confirmado:

- `compose/docker-compose.yaml` une `openclaw-gateway` solo a `agents_net`;
- la publicación del gateway es `127.0.0.1:18789:18789`;
- no se observan `DNS` custom ni `ExtraHosts` en `docker inspect`;
- `openclaw.json` sigue apuntando a `http://172.22.0.1:11440/v1` como upstream aprobado.

Interpretación:

- el contrato del runtime sigue alineado con una topología local-first;
- la ruta aprobada para inferencia es host-side y no pública;
- el contenedor no muestra una ruta documental explícita de egress restringida más allá de esa intención de diseño.

### 2. Listeners host-side y reglas UFW visibles

Confirmado:

- `ss -lntp` muestra `python3` escuchando en `172.22.0.1:11440` y `127.0.0.1:11440`;
- `ss -lntp` muestra `docker-proxy` escuchando en `127.0.0.1:18789`;
- `ss -lntp` también muestra servicios host-side generales en `0.0.0.0:22`, `0.0.0.0:80` y `0.0.0.0:443`;
- `ufw status numbered` confirma `Status: active`;
- `UFW` conserva reglas específicas para `172.22.0.0/16` hacia `172.22.0.1:11434/tcp` y `11440/tcp` sobre `br-0759beecc34d`;
- no se observan reglas `ufw-user-output` que implementen una allowlist de salida.

Interpretación:

- la reachability aprobada a `11440/tcp` está cableada de forma explícita;
- también existe una vía explícita hacia `11434/tcp`, coherente con el backend local/Ollama;
- la activación de `UFW` no equivale por sí sola a cierre de egress: aquí actúa sobre permisos concretos de entrada/forward hacia el host, no como denylist/allowlist exhaustiva de salida del bridge.

### 3. Reglas Docker/iptables efectivas

Confirmado:

- la política base de `FORWARD` es `DROP`;
- antes de cualquier cadena `ufw-*`, `FORWARD` salta a `DOCKER-USER` y `DOCKER-FORWARD`;
- `DOCKER-USER` está vacía;
- `DOCKER-FORWARD` contiene `ACCEPT` para tráfico originado en `br-0759beecc34d` hacia cualquier interfaz;
- `DOCKER-ISOLATION-STAGE-1/2` sí mantiene separación entre bridges Docker;
- en `nat`, `POSTROUTING` aplica `MASQUERADE` a `172.22.0.0/16` cuando el tráfico sale fuera de `br-0759beecc34d`;
- en `nat`, existe `DNAT` de `127.0.0.1:18789` hacia `172.22.0.2:18789`.

Interpretación:

- la separación entre `agents_net` y otras bridges está bien soportada a nivel Docker;
- el published port del gateway sigue limitado a loopback;
- pero la combinación `DOCKER-USER` vacía + `DOCKER-FORWARD` permisiva + `MASQUERADE` es incompatible con declarar una allowlist real de egress.

### 4. Contraste con la documentación de `control-plane`

Claims alineados con la evidencia:

- [README.md](/opt/control-plane/README.md#L57) mantiene `agents_net`, `172.22.0.1:11440/v1`, `127.0.0.1:18789` y además explicita que el hardening final de egress no está cerrado.
- [docs/AGENT_ZONE_EGRESS_ALLOWLIST_MVP.md](/opt/control-plane/docs/AGENT_ZONE_EGRESS_ALLOWLIST_MVP.md#L26) dice que la allowlist real no está aplicada todavía en runtime.
- [docs/reports/OPENCLAW_PHASE_9_TIMEBOXED_HARDENING_2026-04-01.md](/opt/control-plane/docs/reports/OPENCLAW_PHASE_9_TIMEBOXED_HARDENING_2026-04-01.md#L31) afirma que no se aplicó una allowlist real de egress en esa fase.
- [docs/AGENTS.md](/opt/control-plane/docs/AGENTS.md#L1) sigue mezclando parte del checkpoint actual con cautelas históricas sobre broker y Telegram; para egress sí mantiene alineado que la allowlist final sigue pendiente.

Claim que debe leerse como objetivo de diseño, no como cierre confirmado:

- [docs/OPENCLAW_SECURITY_BOOTSTRAP_MVP.md](/opt/control-plane/docs/OPENCLAW_SECURITY_BOOTSTRAP_MVP.md#L41) describe como “prohibido por defecto” el acceso libre a Internet y al host completo;
- la auditoría actual no confirma ese cierre como estado efectivo del runtime;
- lo que sí confirma es aislamiento entre bridges y una ruta aprobada hacia el host de inferencia.

## Pruebas mínimas realizadas o descartadas

### Realizadas

Ninguna prueba activa adicional.

Motivo:

- la inspección estática de Docker, `iptables`, `nat` y `UFW` ya bastó para concluir que no existe allowlist real de egress;
- repetir reachability hacia `172.22.0.1:11440` aportaba poco valor adicional porque esa ruta ya estaba documentada y respaldada por reglas visibles;
- una prueba negativa hacia servicios host-side o destinos externos habría aumentado riesgo y ambigüedad innecesariamente.

### Descartadas por prudencia

- pruebas activas desde el contenedor hacia Internet pública;
- pruebas activas hacia servicios host-side no aprobados como `22`, `80` o `443`;
- cualquier prueba que exigiera tooling nuevo, contenedor nuevo o cambio de reglas.

Estado:

- `pendiente de verificación en host` solo si en el futuro se quisiera demostrar por ejecución real el bloqueo o reachability de destinos concretos adicionales.

## Clasificación final del egress

`ROJO`

Justificación breve:

- no hay evidencia de allowlist real;
- no hay `deny-by-default` materializado para la salida de `agents_net`;
- sí hay aislamiento parcial y rutas aprobadas concretas, pero no cierre final.

## Gap exacto pendiente

El gap exacto no es de topología Docker, sino de control efectivo de salida:

- `agents_net` está separada, pero no tiene una política host-side explícita de egress que limite de forma exhaustiva destinos, puertos y protocolos;
- la cadena `DOCKER-USER` no contiene restricciones;
- `DOCKER-FORWARD` permite salida de la bridge;
- `POSTROUTING` aplica `MASQUERADE`, lo que deja preparada salida fuera de la red del bridge.

Riesgo introducido:

- OpenClaw queda apoyado sobre aislamiento parcial y documentación, no sobre una allowlist final demostrable;
- si el runtime o sus dependencias intentaran alcanzar destinos no previstos, no hay evidencia de un cierre host-side suficientemente estricto que lo impida hoy.

## Conclusión

La postura efectiva de `egress/allowlist` del boundary OpenClaw queda auditada así:

- `agents_net` está separada de otras redes Docker;
- `openclaw-gateway` no expone puerto público y mantiene bind host-side en loopback;
- existe reachability aprobada hacia `172.22.0.1:11440` y también reglas visibles para `11434`;
- no existe, a la vista de las reglas efectivas observadas, una allowlist real de egress ni un `deny-by-default` ya materializado.

Decisión recomendada:

- tratar este punto como `ROJO auditado`, no como `ROJO desconocido`;
- no vender el hardening de egress como cerrado en Sprint 1;
- mover el cierre real de allowlist/deny-by-default al trabajo explícito de Sprint 2.

## Decisión recomendada del sprint

Cerrar Sprint 1 dejando este punto como:

- auditado con evidencia suficiente;
- no resuelto técnicamente;
- formalmente preparado para un cambio mínimo y reversible en Sprint 2.

Cambio mínimo futuro recomendado, pero no implementado aquí:

- introducir una política explícita y reversible en `DOCKER-USER` o capa equivalente que convierta `agents_net` en `deny-by-default` y permita solo los destinos aprobados.

Prerequisitos antes de tocarlo:

- inventario exacto de destinos/puertos permitidos;
- runbook con backup, rollback y validación;
- ventana controlada de verificación host-side;
- contraste previo con `davlos-control-plane` para evitar drift documental adicional.
