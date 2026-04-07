# SPRINT_4_HEARTBEAT_WRITER_VALIDACION.md

## Propósito

Checklist mínima para validar en host el primer incremento del writer `heartbeat.write`.

Todo punto no demostrado debe quedar marcado como `pendiente de verificación en host`.

## Pre-validación

- [ ] La unidad `openclaw-vault-heartbeat-writer.service` existe como `oneshot`.
- [ ] No existe timer asociado al writer.
- [ ] No existe watcher asociado al writer.
- [ ] La identidad del writer está separada del bot Telegram y de `openclaw-gateway`.
- [ ] La ruta destino efectiva es solo `/opt/data/obsidian/vault-main/Agent/Heartbeat`.
- [ ] La ruta de auditoría efectiva está fuera del vault.

## Aislamiento y no regresión

- [ ] No apareció listener nuevo tras instalar o ejecutar el writer.
- [ ] `openclaw-gateway` sigue sano.
- [ ] `openclaw-telegram-bot.service` no quedó degradado por el cambio.
- [ ] El writer no comparte secretos del bot.
- [ ] El writer no depende de Syncthing para producir el heartbeat.

## Validación funcional inmediata

- [ ] La activación fue manual y `oneshot`.
- [ ] La unidad ejecutó una sola operación `heartbeat.write`.
- [ ] Se creó exactamente un `.md` nuevo en `Agent/Heartbeat/`.
- [ ] No apareció ningún archivo nuevo dentro del vault fuera de `Agent/Heartbeat/`.
- [ ] No hubo modificaciones de archivos previos dentro del vault.
- [ ] No hubo renombrados ni borrados.

## Validación del archivo Markdown

- [ ] El nombre sigue `YYYYMMDDTHHMMSSZ_runtime-status_<run_id>.md`.
- [ ] El sufijo es `.md`.
- [ ] El nombre no contiene espacios, traversal ni segmentos inesperados.
- [ ] El frontmatter contiene `managed_by: openclaw`.
- [ ] El frontmatter contiene `agent_zone: Heartbeat`.
- [ ] El frontmatter contiene `run_id`.
- [ ] El frontmatter contiene `created_at_utc`.
- [ ] El frontmatter contiene `updated_at_utc`.
- [ ] El frontmatter contiene `source_refs`.
- [ ] El frontmatter contiene `human_review_status: not_required`.
- [ ] El frontmatter contiene `heartbeat_type: runtime-status`.
- [ ] El cuerpo contiene `Contexto`.
- [ ] El cuerpo contiene `Resultado`.
- [ ] El cuerpo contiene `Trazabilidad`.

## Validación de seguridad

- [ ] Repetir la ejecución no sobrescribe el archivo ya existente.
- [ ] El writer rechaza destinos fuera de allowlist.
- [ ] El writer rechaza symlinks.
- [ ] El writer rechaza traversal.
- [ ] El writer no necesita lectura amplia del vault.
- [ ] La auditoría host-side quedó registrada fuera del vault.

## Validación de proceso

- [ ] No hubo promoción automática a notas núcleo.
- [ ] No hubo escritura en `Drafts_Agent`.
- [ ] No hubo escritura en `Reports_Agent`.
- [ ] No hubo cambios en `.obsidian/`.
- [ ] Se guardó evidencia de journal, status y before/after del directorio destino.

## Resultado

- [ ] GO para ampliar validación controlada.
- [ ] NO-GO si cualquier punto anterior falla o queda ambiguo.
