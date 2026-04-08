# COHERENCIA_DOCUMENTAL_BOUNDARY.md

## Resumen corto

La validación readonly ya cerrada en `davlos-control-plane` permite tratar hoy el boundary OpenClaw como **baseline prudente validado**. La contradicción crítica que existía entre documentos vivos de ese repo quedó cerrada; lo que queda es sobre todo precedencia documental, lectura temporal de históricos y consumo correcto de la fuente de verdad operativa desde este repo de producto.

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

- La idea de que OpenClaw sigue solo en un “MVP incierto” ya no es suficiente: el repo operativo lo trata como baseline prudente validado.
- La expresión “health correcto en `127.0.0.1:18789`” es ambigua si no se aclara que el check real observado es TCP, no un `/healthz` HTTP del gateway.
- Los documentos que dejan `egress/allowlist` como gap abierto deben leerse como material histórico previo al cierre de Sprint 2.
- Los documentos históricos de sprint que describen una desalineación fuerte con `control-plane/docs/AGENTS.md` ya no representan el estado vivo actual.

## Decisión recomendada de precedencia documental

1. Evidencia de host y artefactos observados.
2. `davlos-control-plane/README.md`, `docs/AGENTS.md` y evidencias recientes cuando coinciden con host.
3. Documentos de `davlos-control-plane` no contradichos por evidencia más reciente.
4. `obsi-claw-AI_agent` como capa de producto, roadmap y consolidación documental del proyecto.

## Cambios recomendados en davlos-control-plane

En esta fase ya no hay un cambio crítico pendiente de coherencia inter-repo.
Lo que queda es un ajuste menor, no bloqueante del baseline:

- sincronizar en host el helper instalado con la mejora menor del repo operativo sobre el tail del audit log;
- mantener el modelo root-only del `state/lock` mientras no aparezcan writers no root;
- seguir tratando `operational_logs_recent` como allowlist cerrada, no como acceso general a `journald`.

## Cambios recomendados en obsi-claw-AI_agent

- tomar la auditoría host-side como baseline operativo de Sprint 1;
- reflejar el cierre de Sprint 2 en `ESTADO_GLOBAL.md`, `ESTADO_SEMAFORICO.md` y documentos de relevo;
- reflejar que el boundary OpenClaw ya parte de una baseline prudente validada y no de un MVP incierto;
- usar `docs/evidence/` como registro canónico de verificaciones de host;
- mantener una postura prudente para Obsidian: diseño sí, sync/automatización no todavía;
- seguir remitiendo la fuente de verdad operativa a `davlos-control-plane`.
