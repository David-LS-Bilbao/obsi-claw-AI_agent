# RESUMEN_SPRINT_4.md

## Dónde estamos

Sprint 4 queda cerrado como sprint de integración controlada mínima OpenClaw ↔ vault.

El cierre debe leerse con alcance limitado:

- `heartbeat.write` quedó validado en host;
- `draft.write` quedó validado en host en su subfase mínima y con el contrato nuevo;
- el sprint no abre todavía `report.write`, watcher ni timer.

## Qué quedó cerrado

- writer mínimo y seguro de `heartbeat.write`;
- subfase mínima de `draft.write` con `STAGED_INPUT.md` canónico;
- generación de un único draft nuevo por ejecución;
- auditoría host-side fuera del vault con hashes para `draft.write`;
- postura HITL mínima documentada;
- cierre formal de la subfase de `draft.write`.

## Qué no se tocó

- `report.write`;
- watcher;
- timer;
- promoción automática;
- ampliación de lectura del vault;
- escritura fuera del perímetro mínimo validado.

## Qué sigue pendiente

- verificación directa pre/post de `.obsidian/`;
- cualquier flujo posterior a la creación del draft;
- cualquier siguiente capacidad, que deberá abrirse por separado;
- cualquier decisión de ampliar Sprint 4 más allá de su MVP prudente.

## Siguiente paso recomendado

Tomar como base:

- `docs/sprints/SPRINT_4_CIERRE.md`
- `docs/sprints/SPRINT_4_DRAFT_INCREMENT_CIERRE.md`
- `docs/evidence/VALIDACION_DRAFT_WRITER_CONTRATO_NUEVO_SPRINT_4_2026-04-07.md`
- `docs/architecture/ADR-003-INTEGRACION-CONTROLADA-OPENCLAW-VAULT.md`
- `docs/ESTADO_SEMAFORICO.md`

La regla de continuidad queda así:

- Sprint 4 ya demuestra integración mínima controlada;
- no debe abrirse una nueva capacidad por inercia;
- la siguiente capacidad, si se decide, debe arrancar con contrato y validación propios.
