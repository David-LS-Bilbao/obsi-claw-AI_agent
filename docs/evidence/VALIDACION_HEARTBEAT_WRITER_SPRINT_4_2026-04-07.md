# VALIDACION_HEARTBEAT_WRITER_SPRINT_4_2026-04-07.md

## Propósito

Dejar una evidencia documental corta y suficiente del primer incremento host-side validado de Sprint 4:

- writer dedicado;
- `heartbeat.write` only;
- `systemd oneshot` manual;
- create-only en `Agent/Heartbeat/`;
- auditoría host-side fuera del vault.

## Alcance exacto del incremento

Este cierre cubre solo:

- despliegue del writer dedicado `openclaw-vault-writer`;
- instalación de `openclaw-vault-heartbeat-writer.service`;
- una ejecución manual `oneshot`;
- un único heartbeat `runtime-status`;
- validación de "un archivo nuevo y nada más".

No cubre:

- `draft.write`;
- `report.write`;
- watcher;
- timer;
- promoción automática;
- escritura fuera de `Agent/Heartbeat/`.

## Fuente operativa autorizada

La fuente operativa usada para el despliegue fue exclusivamente:

- `/opt/automation/projects/obsi-claw-AI_agent`

No se usó `/root/obsi-claw-AI_agent` como fuente de despliegue.

## Prechecks superados

Antes del despliegue se validó en host que:

- `/opt/automation/projects/obsi-claw-AI_agent` contenía y permitía leer los 4 artefactos aprobados;
- `scripts/helpers/openclaw_vault_heartbeat_writer.py` compilaba con `python3 -m py_compile`;
- `templates/systemd/openclaw-vault-heartbeat-writer.service` pasaba `systemd-analyze verify`;
- existe `/opt/data/obsidian/vault-main/Agent/Heartbeat`;
- `Agent/Heartbeat` no es symlink;
- el vault y `Agent/Heartbeat` estaban bajo `devops:obsidian` con modo `2770`;
- el inventario previo de `Agent/Heartbeat/`, `Agent/` y `90_Notas_Nucleo_Usuario/` era vacío;
- `openclaw-gateway` estaba `running|healthy`;
- `openclaw-telegram-bot.service` estaba `active`;
- no existía una unidad previa `openclaw-vault-heartbeat-writer.service`;
- el grupo `obsidian` existía;
- la ruta de auditoría propuesta `/var/log/openclaw-vault-heartbeat-writer` quedaba fuera del vault.

## Qué se desplegó exactamente

Se materializó en host:

- usuario de sistema `openclaw-vault-writer`;
- grupo suplementario `obsidian` para ese usuario;
- unidad `systemd` `/etc/systemd/system/openclaw-vault-heartbeat-writer.service`;
- uso del script del repo en:
  `/opt/automation/projects/obsi-claw-AI_agent/scripts/helpers/openclaw_vault_heartbeat_writer.py`

La unidad quedó:

- `oneshot`;
- `static`;
- sin timer;
- sin autoarranque;
- sin listener propio.

## Run de validación

`run_id` usado:

- `sprint4-heartbeat-20260407T104945Z`

Archivo Markdown generado:

- `/opt/data/obsidian/vault-main/Agent/Heartbeat/20260407T104946Z_runtime-status_sprint4-heartbeat-20260407T104945Z.md`

Ruta de auditoría generada:

- `/var/log/openclaw-vault-heartbeat-writer/heartbeat-writer-audit.jsonl`

Ruta de evidencia transitoria observada en host:

- `/tmp/openclaw-sprint4-heartbeat-20260407T104945Z`

## Validación: un archivo nuevo y nada más

Resultado observado:

- `Agent/Heartbeat/` pasó de `0` a `1` archivo;
- `Agent/` pasó de `0` a `1` archivo;
- `90_Notas_Nucleo_Usuario/` permaneció en `0` archivos.

El diff observado de `Agent/` contiene solo:

- `Agent/Heartbeat/20260407T104946Z_runtime-status_sprint4-heartbeat-20260407T104945Z.md`

No se observaron cambios en:

- `Agent/Inbox_Agent/`;
- `Agent/Drafts_Agent/`;
- `Agent/Reports_Agent/`;
- `90_Notas_Nucleo_Usuario/`;
- `.obsidian/`, sin ruido relevante observado.

El archivo generado cumple:

- naming `timestamp UTC + heartbeat_type + run_id`;
- suffix `.md`;
- frontmatter mínimo esperado;
- cuerpo Markdown con `Contexto`, `Resultado` y `Trazabilidad`.

## Estado post-cambio de bot, contenedor y listeners

Tras la ejecución validada:

- `openclaw-gateway` siguió `running|healthy`;
- `openclaw-telegram-bot.service` siguió `active`;
- no apareció ningún listener nuevo;
- la única diferencia observada en `ss -lntp` fue renumeración interna de file descriptors de `systemd` sobre `:22`, no un puerto nuevo ni un nuevo proceso escuchando.

## Rollback

Rollback no necesario.

El primer incremento quedó validado sin requerir retirada del archivo, de la unidad ni del usuario dedicado.

## Matiz sobre `systemctl status` en unidades `oneshot`

Durante la automatización de la validación apareció un falso negativo:

- el wrapper interpretó como fallo una consulta posterior a `systemctl status` sobre una unidad `oneshot` ya finalizada.

La ejecución real del writer fue correcta:

- la unidad arrancó;
- creó el archivo esperado;
- escribió el audit log esperado;
- quedó `inactive (dead)` tras completar la ejecución, que es el comportamiento normal para `oneshot`.

Este matiz debe tratarse como:

- detalle de interpretación del wrapper de validación;
- no como fallo funcional del writer.

## Juicio técnico final

El primer incremento host-side de Sprint 4 queda validado para:

- `heartbeat.write`;
- `runtime-status`;
- writer dedicado;
- `systemd oneshot` manual;
- create-only en `Agent/Heartbeat/`;
- auditoría fuera del vault.

La validación host-side demuestra que el patrón mínimo es:

- acotado;
- auditable;
- reversible;
- no intrusivo para el bot ni para `openclaw-gateway`.

## Pendiente de verificación en host

- frecuencia operativa segura de ejecuciones posteriores;
- decisión fina de `run_id` para ejecuciones repetidas;
- si conviene inyección externa de `run_id` o wrapper mínimo para generarlo;
- procedimiento operativo final para futuras ejecuciones manuales;
- política de retención o limpieza futura de heartbeats;
- cualquier ampliación a `pending-review` o `error-summary`;
- cualquier ampliación a `draft.write` o `report.write`.

## Criterio explícito de no ampliar aún a `draft.write`

No hay GO todavía para `draft.write`.

Razones:

- el primer incremento validado cubre solo `heartbeat.write`;
- el patrón fino de `run_id` sigue sin cerrarse;
- falta decidir la operación manual futura antes de ampliar superficie;
- no hay todavía validación host-side de escritura en `Agent/Drafts_Agent/` ni `Agent/Reports_Agent/`.
