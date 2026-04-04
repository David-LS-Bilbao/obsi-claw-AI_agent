# RESUMEN_SPRINT_1.md

## Dónde estamos

Sprint 1 queda cerrado como sprint de auditoría, consolidación documental y gobierno técnico del boundary OpenClaw ya existente en DAVLOS.

No se reinstaló nada ni se tocó producción. El trabajo se centró en confirmar baseline real, cerrar gaps funcionales mínimos y dejar clasificados los riesgos abiertos.

## Qué está confirmado

- runtime OpenClaw real en `/opt/automation/agents/openclaw`;
- `openclaw-gateway` activo en `agents_net`;
- bind local `127.0.0.1:18789`;
- `inference-gateway.service` activo en `127.0.0.1:11440` y `172.22.0.1:11440`;
- helper readonly validado como vía verde de observabilidad;
- broker restringido core validado en `VERDE`;
- cualquier canal no-Telegram autenticado del broker sigue `pendiente de verificación en host`;
- Telegram persistente materializado, pero no todavía verde;
- `egress/allowlist` auditado y clasificado `ROJO`;
- precedencia documental fijada: evidencia de host primero.

## Qué queda pendiente

- hardening real de `egress/allowlist`;
- revisión funcional de Telegram;
- limpieza documental recomendada en `davlos-control-plane`;
- contrato final de secretos y de health/readiness;
- cualquier canal no-Telegram autenticado del broker sigue `pendiente de verificación en host`.

## Qué no tocar

- runtime OpenClaw en host sin plan explícito y rollback;
- Docker, `systemd`, UFW, `iptables`, secretos o red sin una tarea específica de Sprint 2;
- sync bidireccional con Obsidian;
- notas núcleo del usuario o estructura principal de la vault sin HITL.

## Postura actual de Obsidian

- solo diseño prudente;
- escritura del agente solo en zonas controladas;
- nada de reescritura de notas núcleo;
- nada de automatización estructural agresiva;
- cualquier integración operativa real sigue diferida.

## Siguiente paso recomendado

Abrir Sprint 2 con foco principal en `egress/allowlist`, usando como base:

- `docs/sprints/SPRINT_1_CIERRE.md`
- `docs/ESTADO_SEMAFORICO.md`
- `docs/sprints/SPRINT_2_BORRADOR.md`
- `docs/prompts/PROMPT_ARRANQUE_SPRINT_2.md`

La regla operativa sigue siendo la misma:

- primero auditar;
- después documentar;
- luego proponer;
- y solo al final ejecutar con rollback.
