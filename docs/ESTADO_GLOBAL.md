# ESTADO_GLOBAL.md

## Qué está confirmado

- Existe un clon de trabajo del proyecto en `/opt/automation/projects/obsi-claw-AI_agent`.
- Existe un clon local de referencia en `/opt/control-plane`, tratado en esta fase como solo lectura.
- El `README` y la evidencia reciente de `davlos-control-plane` describen un boundary OpenClaw operativo con runtime en `/opt/automation/agents/openclaw`, red `agents_net`, bind local `127.0.0.1:18789`, upstream `http://172.22.0.1:11440/v1` y componentes host-side asociados.
- El repo `obsi-claw-AI_agent` estaba en fase semilla y sin estructura documental mínima para Sprint 1.
- La auditoría host-side readonly confirma runtime real bajo `/opt/automation/agents/openclaw`.
- La auditoría host-side readonly confirma `openclaw-gateway` activo y sano.
- La auditoría host-side readonly confirma `agents_net` separada de `verity_network`.
- La auditoría host-side readonly confirma `inference-gateway.service` activo con `/healthz` correcto en `127.0.0.1:11440` y `172.22.0.1:11440`.
- La auditoría host-side readonly confirma broker, Telegram y helper readonly materializados por evidencia directa de host, con distintos niveles de confianza funcional.
- La validación funcional controlada del helper `davlos-openclaw-readonly` confirma interfaz usable, subcomandos readonly operativos y cableado funcional por la vía `devops -> sudo` al menos para `runtime_summary`.
- La prueba funcional readonly del broker core confirma ejecución real de `action.health.general.v1` fuera de Telegram, con auditoría before/after coherente y sin cambios de estado efectivo.
- La auditoría readonly de `egress/allowlist` confirma `UFW` activo, reglas específicas desde `agents_net` hacia `172.22.0.1:11434/11440`, `DOCKER-USER` vacía y `MASQUERADE` para `172.22.0.0/16`, por lo que no existe todavía una allowlist real de salida.

## Semáforo actual del boundary

### Verde

- runtime host-side;
- `agents_net` y aislamiento visible;
- bind local del gateway;
- `inference-gateway.service`;
- hardening base del contenedor.
- helper readonly validado en modo readonly.
- broker restringido validado en su core de ejecución readonly.

### Ámbar

- Telegram persistente activo pero con warnings de polling;
- contrato final de secretos y semántica final de health/readiness.

### Rojo

- cierre real de egress/allowlist, ahora ya auditado como gap abierto y no como incógnita;
- coherencia documental global entre fuentes de `control-plane`;
- cualquier supuesto de integración operativa con Obsidian más allá del diseño.

## Qué está pendiente de validar en host

- Coincidencia exacta entre toda la documentación de `davlos-control-plane` y el estado actual del runtime real.
- Salud funcional real del canal Telegram, porque el servicio está activo pero el journal visible muestra warnings de polling.
- Si se quisiera declarar operativo un canal no-Telegram autenticado del broker, eso queda `pendiente de verificación en host`.
- Nivel de divergencia entre el árbol operativo real y los documentos del checkpoint.
- Si se quisiera demostrar por prueba funcional reachability o bloqueo hacia destinos host-side adicionales o hacia Internet pública, eso queda `pendiente de verificación en host`; la auditoría actual caracteriza reglas efectivas, no hace probes externos.

## Qué no debe asumirse aún

- Que toda la documentación histórica siga vigente sin contraste con el host.
- Que el hardening final del boundary esté cerrado.
- Que `agents_net` opere ya bajo `deny-by-default` solo por existir `UFW` activo o reglas puntuales hacia `11440`.
- Que exista ya un canal autenticado no-Telegram del broker desplegado y operativo.
- Que el agente tenga ya permiso de escritura sobre una vault Obsidian productiva.
- Que exista una política resuelta para sync bidireccional o resolución de conflictos.

## Divergencias documentales abiertas

- `davlos-control-plane` presenta un checkpoint operativo avanzado.
- `obsi-claw-AI_agent` todavía está en fase semilla y acaba de recibir su baseline documental mínimo.
- `control-plane/README.md` queda alineado con la evidencia reciente de host.
- `control-plane/docs/AGENTS.md` conserva afirmaciones históricas desalineadas sobre broker y Telegram.
- Toda futura implementación debe contrastarse contra el estado real del VPS.

## Nota operativa

Toda incertidumbre relevante debe mantenerse etiquetada como `pendiente de verificación en host`.
