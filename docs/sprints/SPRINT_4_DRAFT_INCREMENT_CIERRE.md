# SPRINT_4_DRAFT_INCREMENT_CIERRE.md

## Propósito

Cerrar formalmente la subfase mínima de `draft.write` validada en Sprint 4.

## Alcance exacto de la subfase

La subfase cerrada incluye solo:

- staged request canónico en `Agent/Inbox_Agent/STAGED_INPUT.md`;
- contrato nuevo de entrada con frontmatter mínimo;
- helper determinista para `draft.write`;
- unidad `systemd oneshot` manual sin payload dinámico;
- creación create-only de un único draft en `Agent/Drafts_Agent/`;
- auditoría host-side fuera del vault con hashes;
- `pending_human_review` como estado obligatorio.

La subfase no incluye:

- `report.write`;
- watcher;
- timer;
- promoción automática;
- lectura transversal del vault;
- escritura fuera de `Agent/Drafts_Agent/`.

## Qué quedó validado

Quedó validado en host que:

- `STAGED_INPUT.md` canónico puede stagedarse con el contrato nuevo;
- el writer consume ese staged request como única fuente semántica;
- se genera exactamente un draft nuevo por ejecución;
- el staged request queda intacto;
- la auditoría queda fuera del vault e incluye `input_sha256` y `output_sha256`;
- no aparecieron listeners nuevos;
- no hubo degradación observable de bot ni contenedor;
- no hubo cambios observables fuera de `Drafts_Agent`, salvo la presencia esperada de `STAGED_INPUT.md` en `Inbox_Agent`.

## Qué no quedó validado

No quedó validado en esta subfase:

- `report.write`;
- watcher;
- timer;
- promoción posterior al draft;
- comprobación exhaustiva pre/post de `.obsidian/`, que sigue `pendiente de verificación en host`;
- cualquier ampliación de lectura o escritura del vault.

## Evidencia canónica

La evidencia canónica de cierre es:

- `docs/evidence/VALIDACION_DRAFT_WRITER_CONTRATO_NUEVO_SPRINT_4_2026-04-07.md`

Artefactos de referencia:

- `docs/runbooks/OPENCLAW_VAULT_DRAFT_WRITER_DEPLOY_SPRINT_4.md`
- `docs/checklists/SPRINT_4_DRAFT_WRITER_VALIDACION.md`
- `docs/architecture/ADR-003-INTEGRACION-CONTROLADA-OPENCLAW-VAULT.md`

## Riesgos residuales

Persisten como riesgos residuales:

- no haber cerrado todavía la verificación directa pre/post de `.obsidian/`;
- asumir que el éxito de `draft.write` autoriza otras capacidades;
- introducir una siguiente capacidad sin prechecks y evidencia propios;
- sobregeneralizar el alcance de este incremento mínimo.

## Criterio de cierre de esta subfase

La subfase se considera cerrada porque:

- el contrato nuevo quedó cerrado en repo;
- la alineación host-side se ejecutó con la fuente autorizada de `/opt`;
- la validación funcional mínima salió dentro del perímetro esperado;
- la evidencia quedó congelada en `docs/evidence/`.

## Criterio explícito de NO abrir aún `report.write`

El cierre de esta subfase no da GO a `report.write`.

`report.write` sigue bloqueado hasta que exista:

- contrato propio;
- runbook propio;
- checklist propia;
- validación host-side separada;
- criterio explícito de no regresión sobre el vault.
