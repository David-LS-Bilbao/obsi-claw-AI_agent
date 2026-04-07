# VALIDACION_DRAFT_WRITER_CONTRATO_NUEVO_SPRINT_4_2026-04-07.md

## Propósito

Congelar la evidencia canónica de la validación host-side del incremento mínimo de `draft.write` con el contrato nuevo cerrado en Sprint 4.

## Alcance exacto del incremento validado

Este incremento valida solo:

- staged request canónico en `Agent/Inbox_Agent/STAGED_INPUT.md`;
- helper determinista;
- unidad `systemd oneshot` manual sin payload dinámico en `ExecStart`;
- creación create-only de un único draft nuevo en `Agent/Drafts_Agent/`;
- auditoría host-side fuera del vault con `input_sha256` y `output_sha256`;
- ausencia de promoción automática.

Este incremento no valida:

- `report.write`;
- watcher;
- timer;
- promoción fuera de `Drafts_Agent`;
- lectura transversal del vault;
- observación exhaustiva pre/post de `.obsidian/`.

## Prechecks superados

Se confirmó antes de ejecutar:

- fuente operativa autorizada en `/opt/automation/projects/obsi-claw-AI_agent`;
- artefactos repo-side legibles y alineados para `draft.write`;
- existencia de `Agent/Inbox_Agent/` y `Agent/Drafts_Agent/`;
- runtime base sano para `openclaw-gateway`;
- `openclaw-telegram-bot.service` activa;
- usuario `openclaw-vault-draft-writer` existente y perteneciente a `obsidian`;
- ruta de auditoría `/var/log/openclaw-vault-draft-writer` fuera del vault;
- ausencia de timer asociado al writer de drafts;
- diferencia explícita entre la unidad host instalada y la plantilla nueva del repo, lo que justificó la alineación previa a la ejecución.

## Qué se alineó exactamente en host

Antes de ejecutar la validación controlada se realizó:

- creación de `/opt/data/obsidian/vault-main/Agent/Inbox_Agent/STAGED_INPUT.md`;
- reemplazo de `/etc/systemd/system/openclaw-vault-draft-writer.service` desde `templates/systemd/openclaw-vault-draft-writer.service` en `/opt/automation/projects/obsi-claw-AI_agent`;
- `systemctl daemon-reload`;
- comprobación de que la unidad instalada quedó idéntica a la plantilla del repo;
- ejecución exactamente una vez de `openclaw-vault-draft-writer.service`.

No se creó watcher.
No se creó timer.
No se habilitó ejecución automática al boot.

## Staged request usado

Ruta:

- `/opt/data/obsidian/vault-main/Agent/Inbox_Agent/STAGED_INPUT.md`

Frontmatter usado:

- `operation: draft.write`
- `schema_version: 1`
- `run_id: sprint4-draft-contract-20260407T151122Z`
- `draft_title: "Prueba controlada draft.write contrato nuevo"`
- `source_refs: ["Agent/Inbox_Agent/STAGED_INPUT.md"]`
- `proposed_target_path: ""`

Body usado:

- instrucción breve y segura para producir un borrador pequeño y revisable;
- sin promoción automática.

## Run ID usado

- `sprint4-draft-contract-20260407T151122Z`

## Draft generado

Ruta generada:

- `/opt/data/obsidian/vault-main/Agent/Drafts_Agent/20260407T151220Z_draft_sprint4-draft-contract-20260407T151122Z.md`

Checks funcionales observados:

- nombre con timestamp UTC + `draft` + `run_id`;
- `managed_by: openclaw`;
- `agent_zone: Drafts_Agent`;
- `human_review_status: pending_human_review`;
- `proposed_target_path: ""`;
- `source_refs: ["Agent/Inbox_Agent/STAGED_INPUT.md"]`.

## Hashes de input y output

Input:

- `a6f68c73a610bd57bab7e4730f31bb9bce71b5800c139029a21fce85d4d479a9`

Output:

- `f54f36a96481f800b7aec1125d1248d0c4efca293d8487ff33be3013e31a131e`

## Ruta de auditoría generada

- `/var/log/openclaw-vault-draft-writer/draft-writer-audit.jsonl`

La línea JSONL nueva registró:

- `input_path`;
- `input_sha256`;
- `input_size_bytes`;
- `note_path`;
- `output_sha256`;
- `output_size_bytes`;
- `operation`;
- `schema_version`;
- `run_id`;
- `source_refs`;
- `proposed_target_path`.

## Validación “un staged request canónico, un draft nuevo y nada más”

Juicio:

- validada.

Hechos observados:

- apareció exactamente un staged request canónico nuevo en `Agent/Inbox_Agent/`;
- el `sha256` del staged request permaneció intacto antes y después;
- apareció exactamente un `.md` nuevo en `Agent/Drafts_Agent/`;
- no hubo cambios en `Agent/Reports_Agent/`;
- no hubo cambios en `Agent/Heartbeat/`;
- no hubo cambios observables en `90_Notas_Nucleo_Usuario/`;
- no hubo cambios dentro del vault fuera de `Drafts_Agent`, salvo la presencia esperada de `STAGED_INPUT.md` en `Inbox_Agent/`.

## Estado post-cambio de bot, contenedor y listeners

Se observó tras la ejecución:

- `openclaw-gateway` siguió `healthy`;
- `openclaw-telegram-bot.service` siguió activa;
- no apareció ningún listener nuevo;
- el diff de listeners mostró solo renumeración de file descriptors de sockets ya existentes de `sshd/systemd`, no apertura de puertos nuevos.

## Rollback no necesario

No fue necesario rollback porque:

- la unidad completó con `START_RC=0`;
- el resultado quedó dentro del perímetro esperado;
- el staged request permaneció intacto;
- no hubo degradación observable del bot ni del contenedor.

## Juicio técnico final

El incremento mínimo de `draft.write` queda validado en host con el contrato nuevo.

Eso significa que Sprint 4 ya tiene demostrado para esta capacidad:

- staged request canónico;
- helper determinista;
- unidad estable sin payload dinámico;
- un draft nuevo por ejecución;
- auditoría con hashes;
- ausencia de side effects observables fuera del perímetro previsto.

## Lo que sigue pendiente de verificación en host

- verificación directa pre/post de `.obsidian/`;
- necesidad real o no de un wrapper mínimo para casos futuros de `run_id`;
- cualquier ampliación de permisos o de superficie fuera de este incremento;
- cualquier flujo de promoción posterior al draft.

## Criterio explícito de NO ampliar todavía a `report.write`

Este resultado no autoriza todavía:

- abrir `report.write`;
- introducir watcher;
- introducir timer;
- automatizar promoción;
- ampliar lectura del vault.

El siguiente movimiento debe tratarse como capacidad separada, con prechecks y validación host-side propios.
