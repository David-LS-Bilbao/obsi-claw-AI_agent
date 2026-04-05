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
- Sprint 2 cerró técnicamente `egress/allowlist` con evidencia suficiente: hoy existe `DOCKER-USER -> OPENCLAW-EGRESS`, allow efectivo a `172.22.0.1:11440/tcp`, `DROP` final y bloqueo funcional probado de `1.1.1.1:443/tcp`.

## Semáforo actual del boundary

### Verde

- runtime host-side;
- `agents_net` y aislamiento visible;
- bind local del gateway;
- `inference-gateway.service`;
- hardening base del contenedor.
- `egress/allowlist` cerrado técnicamente en Sprint 2.
- helper readonly validado en modo readonly.
- broker restringido validado en su core de ejecución readonly.

### Ámbar

- Telegram persistente activo pero con warnings de polling;
- contrato final de secretos y semántica final de health/readiness.

### Rojo

- coherencia documental global entre fuentes de `control-plane`;
- cualquier supuesto de integración operativa con Obsidian más allá del diseño.

## Qué está pendiente de validar en host

- Coincidencia exacta entre toda la documentación de `davlos-control-plane` y el estado actual del runtime real.
- Salud funcional real del canal Telegram, porque el servicio está activo pero el journal visible muestra warnings de polling.
- Si se quisiera declarar operativo un canal no-Telegram autenticado del broker, eso queda `pendiente de verificación en host`.
- Nivel de divergencia entre el árbol operativo real y los documentos del checkpoint.
- Si se quisiera ampliar la allowlist o reabrir `11434/tcp`, eso queda `pendiente de verificación en host`.

## Qué no debe asumirse aún

- Que toda la documentación histórica siga vigente sin contraste con el host.
- Que la cronología exacta de primera activación de la allowlist haya quedado demostrada al minuto.
- Que el cierre de egress autorice por sí solo cambios de vault, Syncthing u Obsidian operativo.
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
