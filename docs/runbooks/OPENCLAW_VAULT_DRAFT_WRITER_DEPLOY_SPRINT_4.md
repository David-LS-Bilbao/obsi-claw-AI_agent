# OPENCLAW_VAULT_DRAFT_WRITER_DEPLOY_SPRINT_4.md

## Propósito

Documentar el contrato final de entrada de `draft.write` y dejar trazado el incremento mínimo ya validado en host en Sprint 4.

Este contrato deja fijado que:

- `draft.write` lee exactamente un staged request Markdown en `Agent/Inbox_Agent/`;
- el staged request es la única fuente semántica del draft;
- el writer host-side es determinista;
- la unidad `systemd` no inyecta payload dinámico;
- la auditoría host-side no guarda el body completo;
- `pending_human_review` sigue siendo obligatorio.

La evidencia canónica del resultado validado quedó registrada en:

- `docs/evidence/VALIDACION_DRAFT_WRITER_CONTRATO_NUEVO_SPRINT_4_2026-04-07.md`
- `docs/sprints/SPRINT_4_DRAFT_INCREMENT_CIERRE.md`

La verificación directa pre/post de `.obsidian/` sigue `pendiente de verificación en host`.

## Alcance exacto de la subfase

Incluye solo:

- writer host-side separado del writer de heartbeat;
- operación única `draft.write`;
- staged request único y autocontenido;
- un draft nuevo por ejecución;
- destino único `Agent/Drafts_Agent/`;
- create-only;
- `pending_human_review` obligatorio;
- `proposed_target_path` solo como sugerencia textual;
- auditoría host-side fuera del vault con `input_sha256` y `output_sha256`.

No incluye:

- `report.write`;
- watcher;
- timer;
- promoción automática;
- escritura en `Agent/Inbox_Agent/`;
- escritura en `Agent/Reports_Agent/`;
- lectura transversal del vault;
- actualización de drafts previos;
- generación host-side del contenido del borrador a partir de otras fuentes.

## Selección baseline del input staged

La baseline elegida para Sprint 4 es:

- path canónico único `Agent/Inbox_Agent/STAGED_INPUT.md`.

Racional:

- mínimo privilegio;
- cero ambigüedad sobre selección de input;
- `ExecStart` estable y sin payload dinámico;
- trazabilidad simple entre staged request, `run_id`, draft generado y auditoría.

Quedan fuera de baseline en esta subfase:

- descubrir inputs por watcher;
- seleccionar varios inputs;
- usar nombres variables por ejecución;
- introducir wrapper host-side para resolver el input.

La necesidad futura de un wrapper mínimo o de otra estrategia de selección sigue `pendiente de verificación en host`.

## Contrato del staged request

El staged request debe ser:

- un regular file;
- no symlink;
- `.md` obligatorio;
- ubicado exactamente en `Agent/Inbox_Agent/STAGED_INPUT.md`;
- con frontmatter estricto;
- con body Markdown no vacío.

Campos mínimos de frontmatter:

- `operation: draft.write`
- `schema_version: 1`
- `run_id`
- `draft_title`

Campos opcionales:

- `source_refs`
- `proposed_target_path`

Reglas:

- el body del staged request equivale a `draft_body`;
- `source_refs` usa sintaxis inline JSON array, por ejemplo `[]` o `["docs/runbooks/..."]`;
- `proposed_target_path` sigue siendo solo textual;
- el staged request no autoriza promoción automática;
- en esta fase no se lee nada fuera del staged request para construir el contenido del draft.

## Writer determinista

El helper `scripts/helpers/openclaw_vault_draft_writer.py` queda definido así:

- acepta `--input-staged-file` como path absoluto;
- valida que el path efectivo sea `Agent/Inbox_Agent/STAGED_INPUT.md`;
- rechaza symlinks, traversal y rutas fuera de `Agent/Inbox_Agent/`;
- parsea el frontmatter del staged request;
- valida `operation` y `schema_version`;
- toma `run_id` y `draft_title` desde el frontmatter;
- toma el body Markdown del staged request como `draft_body`;
- escribe create-only un único `.md` en `Agent/Drafts_Agent/`;
- no modifica el staged request;
- no borra ni renombra;
- no guarda el payload completo en auditoría.

## Unidad estable

La unidad template `templates/systemd/openclaw-vault-draft-writer.service` queda establecida con:

- `--vault-root`
- `--audit-root`
- `--input-staged-file`

La unidad no debe incluir:

- `--draft-title`
- `--draft-body`
- `--run-id`
- `--source-ref`

Postura adoptada:

- `run_id` pasa a ser parte del staged request y deja de ser coherente inyectarlo desde `ExecStart`;
- si más adelante se quisiera generar `run_id` mediante wrapper mínimo, eso sigue `pendiente de verificación en host`.

## Estado real observado

Sprint 3 ya dejó validado en host que:

- existe `/opt/data/obsidian/vault-main`;
- existen `Agent/Inbox_Agent/` y `Agent/Drafts_Agent/`;
- OpenClaw sigue separado del vault.

Sprint 4 ya había validado en host para el incremento mecánico de `draft.write` que:

- create-only en `Agent/Drafts_Agent/` es viable;
- el input staged puede quedar intacto;
- la auditoría host-side fuera del vault es viable;
- no hubo cambios fuera de `Drafts_Agent`;
- no hubo listeners nuevos;
- no hubo degradación observable de bot ni contenedor.

La validación host-side del contrato nuevo agregó además que:

- `STAGED_INPUT.md` canónico pudo stagedarse con el frontmatter nuevo;
- la unidad alineada desde `/opt` ejecutó sin payload dinámico en `ExecStart`;
- se generó exactamente un draft nuevo a partir del staged request canónico;
- el staged request quedó intacto;
- la auditoría host-side registró `input_sha256` y `output_sha256`;
- no hubo cambios observables fuera de `Drafts_Agent`, salvo la presencia esperada de `STAGED_INPUT.md` en `Inbox_Agent/`.

Con esto, el incremento mínimo de `draft.write` queda validado.

## Identidad recomendada del writer

La identidad recomendada sigue siendo:

- usuario dedicado `openclaw-vault-draft-writer` con shell `nologin`, grupo primario propio y grupo suplementario `obsidian`.

La creación real del usuario y sus permisos efectivos quedan `pendiente de verificación en host`.

## Archivos implicados

- `docs/runbooks/OPENCLAW_VAULT_DRAFT_WRITER_DEPLOY_SPRINT_4.md`
- `docs/checklists/SPRINT_4_DRAFT_WRITER_VALIDACION.md`
- `docs/runbooks/OPENCLAW_VAULT_HITL_PROMOCION_SPRINT_4.md`
- `docs/architecture/ADR-003-INTEGRACION-CONTROLADA-OPENCLAW-VAULT.md`
- `templates/systemd/openclaw-vault-draft-writer.service`
- `scripts/helpers/openclaw_vault_draft_writer.py`
- `templates/obsidian/STAGED_DRAFT_REQUEST_TEMPLATE.md`
- `templates/obsidian/AGENT_MANAGED_DRAFT_TEMPLATE.md`

## Prechecks

Antes de ejecutar en host:

- confirmar que `/opt/automation/projects/obsi-claw-AI_agent` sigue siendo el clon operativo previsto;
- confirmar que `/opt/data/obsidian/vault-main/Agent/Inbox_Agent` existe y no es symlink;
- confirmar que `/opt/data/obsidian/vault-main/Agent/Drafts_Agent` existe y no es symlink;
- confirmar que existe exactamente un staged request canónico en `Agent/Inbox_Agent/STAGED_INPUT.md`;
- confirmar que el staged request no será modificado por el flujo;
- confirmar que `openclaw-gateway` y `openclaw-telegram-bot.service` siguen sanos antes del cambio;
- confirmar que no existe listener nuevo asociado al writer;
- confirmar la ruta final de auditoría fuera del vault;
- confirmar que el writer de drafts queda separado del writer de heartbeat.

Cada punto sigue `pendiente de verificación en host` hasta validación real.

## Resultado validado

Resultado observado en host durante la validación controlada:

1. se creó `Agent/Inbox_Agent/STAGED_INPUT.md` conforme al contrato nuevo;
2. se alineó la unidad instalada desde la plantilla de `/opt`;
3. se ejecutó exactamente una vez `openclaw-vault-draft-writer.service`;
4. apareció exactamente un `.md` nuevo en `Agent/Drafts_Agent/`;
5. el staged request quedó intacto;
6. la auditoría quedó fuera del vault y registró hashes de input y output;
7. no aparecieron listeners nuevos;
8. no hubo degradación observable de bot ni contenedor.

No se ejecutó timer.
No se habilitó watcher.
No se abrió `report.write`.

## Validación inmediata esperada

La validación host-side mínima ya demostró:

- una ejecución manual de la unidad `oneshot`;
- lectura de un único staged request canónico;
- staged request intacto tras la ejecución;
- un único archivo `.md` nuevo en `Agent/Drafts_Agent/`;
- cero cambios dentro del vault fuera de `Agent/Drafts_Agent/`;
- `human_review_status: pending_human_review` explícito;
- `proposed_target_path` solo textual;
- `input_sha256` y `output_sha256` en auditoría;
- ausencia de payload dinámico en `ExecStart`;
- rechazo explícito de overwrite;
- ausencia de promoción automática.

Usar la checklist `docs/checklists/SPRINT_4_DRAFT_WRITER_VALIDACION.md`.

## Rollback

Rollback mínimo:

1. no volver a disparar la unidad;
2. desinstalar o dejar inhabilitada la unidad si la validación falla;
3. retirar o archivar manualmente el draft generado en `Agent/Drafts_Agent/`;
4. conservar audit log, `run_id` y evidencia mínima;
5. no tocar `Agent/Inbox_Agent/`, `Agent/Reports_Agent/` ni notas núcleo.

Si hubiera impacto mayor fuera de `Agent/Drafts_Agent/`, el fallback mayor sigue siendo el backup del vault validado en Sprint 3.

## Evidencia a guardar

- salida de `systemctl status openclaw-vault-draft-writer.service --no-pager`;
- salida de `journalctl -u openclaw-vault-draft-writer.service --no-pager -n 50`;
- listados before/after de `Agent/Inbox_Agent/` y `Agent/Drafts_Agent/`;
- prueba de ausencia de cambios fuera de `Agent/Drafts_Agent/`;
- contenido del staged request usado;
- contenido del `.md` creado;
- línea JSONL correspondiente del audit log host-side;
- prueba de que el staged request quedó intacto;
- prueba de que no apareció listener nuevo;
- prueba de que bot y contenedor siguieron sanos.

## Criterio de abortar

Abortar si ocurre cualquiera de estos casos:

- no existe exactamente un staged request canónico;
- el staged request resuelve fuera de `Agent/Inbox_Agent/`;
- el staged request no usa `STAGED_INPUT.md`;
- el destino resuelve fuera de `Agent/Drafts_Agent/`;
- el input o el destino contienen symlinks;
- el staged request no cumple el frontmatter mínimo;
- aparece cualquier cambio en el vault fuera de `Agent/Drafts_Agent/`;
- el writer requiere leer más de un input staged;
- el writer requiere reutilizar secretos del bot;
- aparece un listener nuevo;
- `openclaw-gateway` o el bot Telegram muestran degradación atribuible al cambio;
- la auditoría host-side no queda separada del vault;
- el resultado depende de timer, watcher o lógica no documentada.

## Pendiente de verificación en host

- permisos efectivos mínimos para leer `Agent/Inbox_Agent/STAGED_INPUT.md` y escribir en `Agent/Drafts_Agent/`;
- verificación directa pre/post de `.obsidian/`;
- si conviene introducir después un wrapper mínimo para generar `run_id`;
- si el parser documentado cubre adecuadamente el formato real que se quiera stagedar en producción;
- cualquier capacidad posterior, incluyendo `report.write`, watcher o timer.

## Criterio explícito de no ampliar todavía

Este runbook no autoriza todavía:

- abrir `report.write`;
- diseñar watcher;
- introducir timer;
- inferir que el cierre de `draft.write` resuelve la siguiente capacidad.
