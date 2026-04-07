# SPRINT_4_DRAFT_WRITER_VALIDACION.md

## Propósito

Checklist mínima para validar en host el contrato final repo-side de `draft.write`.

Todo punto no demostrado debe quedar marcado como `pendiente de verificación en host`.

## Pre-validación

- [ ] La unidad `openclaw-vault-draft-writer.service` existe como `oneshot`.
- [ ] No existe timer asociado al writer de drafts.
- [ ] No existe watcher asociado al writer de drafts.
- [ ] El writer de drafts está separado del writer de heartbeat.
- [ ] La identidad del writer está separada del bot Telegram y de `openclaw-gateway`.
- [ ] La ruta de lectura efectiva es solo `Agent/Inbox_Agent/STAGED_INPUT.md`.
- [ ] La ruta de escritura efectiva es solo `Agent/Drafts_Agent/`.
- [ ] La ruta de auditoría efectiva está fuera del vault.
- [ ] `ExecStart` no incluye `--draft-title`.
- [ ] `ExecStart` no incluye `--draft-body`.
- [ ] `ExecStart` no incluye `--run-id`.
- [ ] `ExecStart` no incluye `--source-ref`.

## Aislamiento y no regresión

- [ ] No apareció listener nuevo tras instalar o ejecutar el writer.
- [ ] `openclaw-gateway` sigue sano.
- [ ] `openclaw-telegram-bot.service` no quedó degradado por el cambio.
- [ ] El writer no comparte secretos del bot.
- [ ] El writer no depende de Syncthing para producir el draft.

## Validación del staged request

- [ ] Existe exactamente un staged request canónico en `Agent/Inbox_Agent/STAGED_INPUT.md`.
- [ ] El staged request es `.md`, regular file y no symlink.
- [ ] El staged request comienza con frontmatter delimitado por `---`.
- [ ] El frontmatter contiene `operation: draft.write`.
- [ ] El frontmatter contiene `schema_version: 1`.
- [ ] El frontmatter contiene `run_id`.
- [ ] El frontmatter contiene `draft_title`.
- [ ] Si aparece `source_refs`, usa sintaxis inline JSON array.
- [ ] Si aparece `proposed_target_path`, sigue siendo solo textual.
- [ ] El body Markdown del staged request no es vacío.

## Validación funcional inmediata

- [ ] La activación fue manual y `oneshot`.
- [ ] La unidad ejecutó una sola operación `draft.write`.
- [ ] Se leyó exactamente un staged request.
- [ ] El staged request quedó intacto.
- [ ] Se creó exactamente un `.md` nuevo en `Agent/Drafts_Agent/`.
- [ ] No apareció ningún archivo nuevo dentro del vault fuera de `Agent/Drafts_Agent/`.
- [ ] No hubo modificaciones de archivos previos dentro del vault.
- [ ] No hubo renombrados ni borrados.

## Validación del archivo Markdown generado

- [ ] El nombre sigue `YYYYMMDDTHHMMSSZ_draft_<run_id>.md`.
- [ ] El sufijo es `.md`.
- [ ] El frontmatter contiene `managed_by: openclaw`.
- [ ] El frontmatter contiene `agent_zone: Drafts_Agent`.
- [ ] El frontmatter contiene `run_id`.
- [ ] El frontmatter contiene `created_at_utc`.
- [ ] El frontmatter contiene `updated_at_utc`.
- [ ] El frontmatter contiene `source_refs`.
- [ ] El frontmatter contiene `human_review_status: pending_human_review`.
- [ ] El frontmatter contiene `proposed_target_path`.
- [ ] El cuerpo contiene `Contexto`.
- [ ] El cuerpo contiene `Entradas`.
- [ ] El cuerpo contiene `Borrador`.
- [ ] El cuerpo contiene `Riesgos / dudas`.
- [ ] El cuerpo contiene `Estado HITL`.
- [ ] El cuerpo contiene `Trazabilidad`.
- [ ] El contenido de `## Borrador` proviene del body del staged request.

## Validación de seguridad

- [ ] Repetir la ejecución no sobrescribe el draft ya existente.
- [ ] El writer rechaza destinos fuera de allowlist.
- [ ] El writer rechaza symlinks.
- [ ] El writer rechaza traversal.
- [ ] El writer rechaza staged requests sin frontmatter mínimo válido.
- [ ] El writer no necesita lectura amplia del vault.
- [ ] La auditoría host-side quedó registrada fuera del vault.
- [ ] La auditoría contiene `input_sha256`.
- [ ] La auditoría contiene `output_sha256`.
- [ ] La auditoría no vuelca el body completo del staged request ni del draft.

## Validación de proceso

- [ ] No hubo promoción automática a notas núcleo.
- [ ] No hubo escritura en `Agent/Inbox_Agent/`.
- [ ] No hubo escritura en `Agent/Reports_Agent/`.
- [ ] No hubo cambios en `.obsidian/`.
- [ ] Se guardó evidencia de journal, status, before/after del staged request y del draft generado.

## Resultado

- [ ] GO para una segunda validación host-side controlada.
- [ ] NO-GO si cualquier punto anterior falla o queda ambiguo.
