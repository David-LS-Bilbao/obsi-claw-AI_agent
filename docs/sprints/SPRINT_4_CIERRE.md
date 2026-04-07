# SPRINT_4_CIERRE.md

## Resumen ejecutivo

Sprint 4 puede cerrarse formalmente como sprint de integración controlada mínima OpenClaw ↔ vault.

El cierre debe redactarse de forma prudente y honesta:

- `heartbeat.write` queda cerrado y validado en host;
- `draft.write` queda cerrado en su subfase mínima y validado en host con el contrato nuevo;
- Sprint 4 no da GO todavía a `report.write`, watcher, timer ni promoción automática.

## Objetivo real del Sprint 4

El objetivo real del sprint fue:

- habilitar primeros puntos de escritura controlada del agente;
- validar que el agente puede producir heartbeats y borradores sin corromper el vault;
- fijar reglas mínimas de HITL;
- mantener el boundary contenido y sin ampliar superficie innecesaria.

## Alcance realmente ejecutado

Se ejecutó realmente:

- un incremento mínimo de `heartbeat.write`, con writer dedicado, oneshot manual y validación host-side;
- una subfase mínima de `draft.write`, primero mecánica y luego cerrada con el contrato nuevo;
- documentación y cierre repo-side de la postura HITL para el borrador;
- consolidación documental de Sprint 4 alrededor de evidencias, runbooks, checklist y ADRs.

No se ejecutó:

- `report.write`;
- watcher;
- timer;
- promoción automática;
- escritura fuera de `Agent/Heartbeat/` y `Agent/Drafts_Agent/`.

## Qué quedó validado en host

Quedó validado en host para Sprint 4:

- `heartbeat.write` como writer mínimo separado y controlado;
- escritura create-only en `Agent/Heartbeat/` para el incremento mínimo de heartbeat;
- `draft.write` con `STAGED_INPUT.md` canónico como única fuente semántica;
- generación determinista de un único draft nuevo en `Agent/Drafts_Agent/`;
- staged request intacto tras la ejecución;
- auditoría host-side fuera del vault con `input_sha256` y `output_sha256` para `draft.write`;
- ausencia de listeners nuevos en las validaciones ejecutadas;
- ausencia de degradación observable del bot o del contenedor en las validaciones ejecutadas.

## Qué quedó solo documentado

Quedó resuelto solo a nivel documental:

- la política de HITL para promoción posterior al draft;
- el contrato técnico repo-side de `draft.write` más allá de su incremento mínimo ya validado;
- la delimitación explícita de lo que no autoriza Sprint 4;
- la separación entre staging, generación del draft y promoción.

## Estado honesto del checklist maestro de Sprint 4

### Cumplido

- activar un primer `heartbeat.write` seguro;
- validar una primera escritura create-only controlada del agente en el vault;
- cerrar documentalmente reglas mínimas de HITL para el flujo de borradores;
- dejar trazabilidad documental suficiente para continuidad de Sprint 4.

### Cumplido parcialmente

- habilitar carpetas controladas de escritura del agente:
  - validado en host para `Agent/Heartbeat/` y `Agent/Drafts_Agent/`;
  - `Agent/Inbox_Agent/` se usó como staging humano controlado, no como zona de escritura del writer;
  - `Agent/Reports_Agent/` no se abrió.
- validar que el agente no corrompe el vault:
  - validado para los incrementos mínimos ejecutados;
  - la verificación directa pre/post de `.obsidian/` sigue `pendiente de verificación en host`.
- crear primeros flujos útiles:
  - heartbeats mínimos: sí;
  - borradores mínimos: sí;
  - reportes: no;
  - resúmenes periódicos: no.

### No ejecutado / fuera de alcance

- `report.write`;
- watcher;
- timer;
- promoción automática a notas núcleo;
- lectura transversal del vault;
- escritura libre del agente sobre todo el vault;
- validación de una capacidad posterior por arrastre desde este sprint.

## Evidencia canónica de Sprint 4

La evidencia canónica más útil para el cierre queda en:

- `docs/evidence/VALIDACION_HEARTBEAT_WRITER_SPRINT_4_2026-04-07.md`
- `docs/sprints/SPRINT_4_HEARTBEAT_INCREMENT_CIERRE.md`
- `docs/runbooks/OPENCLAW_VAULT_HEARTBEATS_SPRINT_4.md`
- `docs/runbooks/OPENCLAW_VAULT_ROLLBACK_AGENT_ZONE_SPRINT_4.md`
- `docs/evidence/VALIDACION_DRAFT_WRITER_CONTRATO_NUEVO_SPRINT_4_2026-04-07.md`
- `docs/sprints/SPRINT_4_DRAFT_INCREMENT_CIERRE.md`
- `docs/runbooks/OPENCLAW_VAULT_HEARTBEAT_WRITER_DEPLOY_SPRINT_4.md`
- `docs/checklists/SPRINT_4_HEARTBEAT_WRITER_VALIDACION.md`
- `docs/runbooks/OPENCLAW_VAULT_DRAFT_WRITER_DEPLOY_SPRINT_4.md`
- `docs/checklists/SPRINT_4_DRAFT_WRITER_VALIDACION.md`
- `docs/architecture/ADR-003-INTEGRACION-CONTROLADA-OPENCLAW-VAULT.md`

## Qué sigue pendiente de verificación en host

- verificación directa pre/post de `.obsidian/`;
- cualquier wrapper futuro para `run_id`, si llegara a ser necesario;
- cualquier flujo de promoción posterior al draft;
- cualquier validación de `report.write`;
- cualquier validación de watcher o timer;
- cualquier ampliación de lectura o escritura fuera del perímetro ya validado.

## Qué quedó expresamente fuera de alcance

- `report.write`;
- watcher;
- timer;
- promoción automática;
- cambios de taxonomía del vault;
- validación de nuevas capacidades por analogía con `heartbeat.write` o `draft.write`.

## Riesgos residuales

Persisten como riesgos residuales:

- vender Sprint 4 como más amplio de lo que realmente se ejecutó;
- asumir que `draft.write` habilita por sí solo la siguiente capacidad;
- no separar en el próximo paso lo validado en host de lo solo decidido documentalmente;
- dejar implícito que `.obsidian/` ya quedó verificado cuando no es así.

## Criterio de cierre del Sprint 4

Sprint 4 puede cerrarse porque:

- sus dos incrementos realmente ejecutados y prioritarios ya quedaron validados en host;
- el contrato nuevo de `draft.write` ya quedó cerrado y probado;
- el sprint deja evidencia suficiente para continuidad;
- los límites de alcance quedaron escritos sin confundirlos con capacidades ya abiertas.

## Siguiente paso prudente para el proyecto

El siguiente paso prudente no es ejecutar otra capacidad por arrastre.

Lo prudente es:

- tomar Sprint 4 como MVP cerrado y contenido;
- abrir la siguiente capacidad solo como trabajo separado, con contrato, runbook, checklist y gate propios;
- decidir antes si conviene cerrar la verificación directa de `.obsidian/` o preparar documentalmente la siguiente capacidad, sin venderla como validada.

## Juicio final

Sprint 4 queda cerrado en un MVP prudente:

- suficiente para demostrar integración controlada mínima con el vault;
- insuficiente, a propósito, para declarar abiertas capacidades posteriores.
