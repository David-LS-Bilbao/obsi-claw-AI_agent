# COHERENCIA_DOCUMENTAL_BOUNDARY.md

## Resumen corto

La evidencia de host confirma que el boundary OpenClaw está más avanzado de lo que sugieren algunos documentos históricos de `davlos-control-plane`. El checkpoint reciente del `README` de `control-plane` sí refleja el estado real observado; `docs/AGENTS.md` en ese repo conserva cautelas que hoy ya no son precisas para broker y Telegram.

## Claims documentales confirmados por host

- runtime host-side en `/opt/automation/agents/openclaw`;
- ruta de secretos en `/etc/davlos/secrets/openclaw`;
- contenedor `openclaw-gateway` activo y sano;
- red dedicada `agents_net`;
- bind local exclusivo en `127.0.0.1:18789`;
- `inference-gateway.service` activa y reachability confirmada en `172.22.0.1:11440`;
- materialización de broker restringido en policy, auditoría y state;
- materialización de Telegram persistente como servicio `systemd`;
- helper readonly instalado y cableado en host.

## Claims desactualizados o incompletos

- `control-plane/docs/AGENTS.md` sigue indicando que broker restringido e integración Telegram no deben darse por implementados.
- La idea de que `/etc/davlos/secrets/openclaw` queda solo “reservado” ya no es suficiente: hoy contiene secreto Telegram.
- La expresión “health correcto en `127.0.0.1:18789`” es ambigua si no se aclara que el check real observado es TCP, no un `/healthz` HTTP del gateway.
- El hardening final de egress/allowlist no debe leerse como cerrado.

## Decisión recomendada de precedencia documental

1. Evidencia de host y artefactos observados.
2. `davlos-control-plane/README.md` y evidencias recientes cuando coinciden con host.
3. Documentos de `davlos-control-plane` no contradichos por evidencia más reciente.
4. `obsi-claw-AI_agent` como capa de producto, roadmap y consolidación documental del proyecto.

## Cambios recomendados en davlos-control-plane

Solo recomendados, no ejecutar en este paso:

- actualizar `docs/AGENTS.md` para retirar la idea de que broker y Telegram no están implementados;
- aclarar que el healthcheck de `18789` es TCP y no readiness HTTP estable;
- actualizar el contrato de secretos para reflejar el uso actual de `telegram-bot.env`;
- dejar la allowlist/egress como gap abierto con fecha de última verificación;
- añadir una nota corta de “documento histórico parcialmente superado” donde proceda.

## Cambios recomendados en obsi-claw-AI_agent

- tomar la auditoría host-side como baseline operativo de Sprint 1;
- mantener el semáforo verde/ámbar/rojo explícito en `ESTADO_GLOBAL.md` y `SPRINT_1.md`;
- usar `docs/evidence/` como registro canónico de verificaciones de host;
- mantener una postura prudente para Obsidian: diseño sí, sync/automatización no todavía.
