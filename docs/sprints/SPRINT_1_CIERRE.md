# SPRINT_1_CIERRE.md

## Resumen ejecutivo

Sprint 1 queda cerrado formalmente como sprint de auditoría, consolidación documental y gobierno técnico del boundary OpenClaw ya existente en DAVLOS.

El cierre no implica que todo el hardening esté resuelto. Implica que el baseline real ya está suficientemente confirmado, que los principales riesgos ya están clasificados con evidencia y que el siguiente tramo de trabajo queda preparado sin falsear el estado operativo.

## Objetivo real del Sprint 1

Auditar lo ya desplegado, consolidar una baseline documental honesta, cerrar los gaps funcionales mínimos del helper readonly y del broker core, caracterizar el gap de `egress/allowlist` y dejar una postura prudente para la futura integración con Obsidian.

## Qué se ha confirmado realmente

- runtime host-side real de OpenClaw en `/opt/automation/agents/openclaw`;
- contenedor `openclaw-gateway` activo en `agents_net`;
- bind local exclusivo en `127.0.0.1:18789`;
- `inference-gateway.service` activo y reachability confirmada en `127.0.0.1:11440` y `172.22.0.1:11440`;
- helper readonly validado funcionalmente como vía verde de observabilidad controlada;
- broker restringido validado en su core de ejecución readonly y clasificado `VERDE`;
- el canal no-Telegram autenticado del broker sigue `pendiente de verificación en host` si se quisiera declararlo operativo;
- Telegram persistente materializado y activo, pero con salud funcional todavía no declarable como verde;
- `egress/allowlist` auditado con evidencia suficiente para concluir que no existe cierre real ni `deny-by-default` materializado;
- precedencia documental fijada: evidencia de host primero, `davlos-control-plane` como checkpoint operativo y este repo como capa de producto y consolidación.

## Qué queda en ámbar

- Telegram persistente:
  - activo y materializado;
  - con warnings de polling visibles;
  - `pendiente de verificación en host` si se quisiera declararlo sano de forma estable.
- contrato final de secretos:
  - existencia confirmada;
  - lifecycle y contrato final todavía no cerrados.
- semántica final de health/readiness:
  - ya no debe confundirse con `/healthz` en `18789`;
  - la política final de liveness/readiness sigue abierta como deuda menor.
- postura inicial de vault/Obsidian:
  - diseño prudente definido;
  - integración operativa real todavía no activada.

## Qué queda en rojo

- `egress/allowlist` real del boundary:
  - auditado;
  - no resuelto;
  - transferido a Sprint 2 como foco principal.
- coherencia documental global con `davlos-control-plane`:
  - `README` reciente y evidencia de host alinean;
  - `docs/AGENTS.md` en `control-plane` sigue parcialmente desfasado.
- cualquier integración operativa de Obsidian más allá de zonas controladas de diseño:
  - sync bidireccional;
  - ownership agresivo del agente;
  - reescritura de notas núcleo del usuario.

## Qué NO se hizo a propósito

- no se tocó producción;
- no se modificó runtime OpenClaw;
- no se tocaron Docker, `systemd`, UFW, `iptables`, secretos ni red;
- no se activó sync bidireccional con Obsidian;
- no se dio por verde Telegram solo porque el servicio estuviera activo;
- no se declaró allowlist real de egress donde la evidencia no la soporta.

## Decisiones tomadas

- cerrar Sprint 1 como sprint de auditoría y consolidación, no como sprint de hardening final;
- tratar helper readonly y broker core como `VERDE` dentro del alcance realmente validado;
- tratar Telegram como `ÁMBAR` y no como blocker de cierre;
- tratar `egress/allowlist` como `ROJO auditado` y transferirlo explícitamente a Sprint 2;
- fijar Obsidian en modo diseño prudente:
  - sin sync bidireccional;
  - sin reescritura de notas núcleo;
  - con escritura del agente solo en zonas controladas y con HITL para promoción;
- usar la evidencia de host como referencia superior cuando haya conflicto documental.

## Deuda técnica abierta

- hardening real de `egress/allowlist` para `agents_net`;
- revisión funcional controlada de Telegram;
- limpieza documental recomendada en `davlos-control-plane`;
- contrato final de secretos y posture final de health/readiness;
- eventual validación de un canal no-Telegram autenticado del broker, que sigue `pendiente de verificación en host` si se quisiera declararlo operativo.

## Criterio de cierre del Sprint 1

Sprint 1 puede cerrarse porque:

- el baseline real del boundary ya está confirmado;
- los principales claims dudosos ya quedaron separados entre confirmados y no confirmados;
- el helper readonly y el broker core ya no son gaps funcionales abiertos;
- el gap de `egress/allowlist` ya no es una incógnita, sino una deuda caracterizada;
- la postura inicial de Obsidian queda encuadrada de forma prudente;
- Sprint 2 puede arrancar con foco claro y sin necesidad de reabrir auditorías básicas ya hechas.

## Siguiente paso lógico: Sprint 2

Abrir Sprint 2 con foco principal en el hardening real de `egress/allowlist` del boundary OpenClaw, mediante cambios pequeños, reversibles y con rollback claro.

Tracks secundarios recomendados:

- revisión funcional de Telegram;
- consolidación menor de health/readiness y contrato de secretos;
- continuidad del diseño de vault/Obsidian sin activar sync ni automatización estructural agresiva.
