# OPENCLAW_VAULT_HEARTBEAT_WRITER_DEPLOY_SPRINT_4.md

## Propósito

Preparar el despliegue mínimo y revisable del primer writer host-side de Sprint 4 para `heartbeat.write`.

Este incremento solo autoriza la creación de una nota Markdown nueva en `Agent/Heartbeat/` y su auditoría host-side fuera del vault.

## Alcance exacto del primer incremento

Incluye solo:

- writer host-side dedicado;
- capacidad única `heartbeat.write`;
- tipo inicial único `runtime-status`;
- salida única en `Agent/Heartbeat/`;
- create-only;
- auditoría host-side fuera del vault;
- activación manual vía `systemd` `oneshot`.

No incluye:

- `Drafts_Agent`;
- `Reports_Agent`;
- watcher;
- timer;
- Syncthing como parte del flujo;
- promoción automática;
- escrituras fuera de `Agent/Heartbeat/`;
- mezcla con `openclaw-gateway` o con `openclaw-telegram-bot.service`.

## Estado real observado

Sprint 3 ya dejó validado en host que:

- existe `/opt/data/obsidian/vault-main`;
- existe `Agent/Heartbeat/` dentro del vault;
- el vault base quedó con ownership `devops:obsidian` y permisos base `2770`;
- OpenClaw sigue separado del vault;
- el bot Telegram y `openclaw-gateway` ya existen como componentes distintos del boundary.

La integración efectiva de escritura OpenClaw ↔ Vault sigue `pendiente de verificación en host`.

## Decisión de activación elegida

La activación inicial recomendada es:

- `systemd oneshot`, disparado manualmente.

Razones:

- mantiene ejecución explícita y auditable;
- evita introducir timer o watcher en el primer incremento;
- permite sandboxing fuerte sin reutilizar el bot;
- facilita rollback simple: detener el uso de la unidad y retirar el archivo creado;
- deja validación clara de "un archivo nuevo y nada más" en el vault.

## Identidad recomendada del writer

La identidad recomendada es:

- usuario dedicado nuevo `openclaw-vault-writer` con shell `nologin`, grupo primario propio y grupo suplementario `obsidian`.

Razones:

- menor blast radius que reutilizar `devops`, `syncthing` o el usuario del bot;
- separación limpia respecto de secretos y runtime del bot Telegram;
- rollback claro: deshabilitar unidad y retirar identidad dedicada si se decide no continuar.

La creación real del usuario, su pertenencia a `obsidian` y cualquier ACL o ajuste fino quedan `pendiente de verificación en host`.

## Archivos implicados

- `docs/runbooks/OPENCLAW_VAULT_HEARTBEAT_WRITER_DEPLOY_SPRINT_4.md`
- `docs/checklists/SPRINT_4_HEARTBEAT_WRITER_VALIDACION.md`
- `templates/systemd/openclaw-vault-heartbeat-writer.service`
- `scripts/helpers/openclaw_vault_heartbeat_writer.py`

## Prechecks

Antes de ejecutar en host:

- confirmar que `/opt/automation/projects/obsi-claw-AI_agent` sigue siendo el clon operativo previsto;
- confirmar que `/opt/data/obsidian/vault-main/Agent/Heartbeat` existe y no es symlink;
- confirmar que `openclaw-gateway` y `openclaw-telegram-bot.service` siguen sanos antes del cambio;
- confirmar que no existe listener nuevo asociado al writer;
- confirmar la ruta final de auditoría fuera del vault;
- confirmar que la identidad dedicada no hereda secretos del bot;
- confirmar que la unidad se instalará sin timer asociado.

Cada punto sigue `pendiente de verificación en host` hasta validación real.

## Cambio mínimo previsto

Cambio host-side previsto para ejecución posterior:

1. copiar o actualizar este repo en el clon operativo documentado;
2. instalar `scripts/helpers/openclaw_vault_heartbeat_writer.py` desde el repo;
3. instalar `templates/systemd/openclaw-vault-heartbeat-writer.service` como unidad real;
4. crear identidad dedicada mínima para el writer;
5. confirmar acceso de escritura solo a `Agent/Heartbeat/` y a la ruta de auditoría;
6. ejecutar una sola vez la unidad `systemd`;
7. validar que aparece exactamente un `.md` nuevo en `Agent/Heartbeat/` y nada más dentro del vault.

No ejecutar timer. No habilitar watcher. No tocar bot ni contenedor.

## Validación inmediata esperada

La validación inmediata mínima debe probar:

- una ejecución manual de la unidad `oneshot`;
- cero listeners nuevos;
- cero degradación observable en bot Telegram y `openclaw-gateway`;
- un único archivo `.md` nuevo en `Agent/Heartbeat/`;
- cero cambios dentro del vault fuera de `Agent/Heartbeat/`;
- frontmatter mínimo correcto;
- naming `YYYYMMDDTHHMMSSZ_runtime-status_<run_id>.md`;
- auditoría JSONL fuera del vault;
- rechazo explícito de overwrite al repetir el mismo nombre exacto;
- ausencia de promoción automática.

Usar la checklist `docs/checklists/SPRINT_4_HEARTBEAT_WRITER_VALIDACION.md`.

## Rollback

Rollback mínimo:

1. no volver a disparar la unidad;
2. desinstalar o dejar inhabilitada la unidad si la validación falla;
3. retirar manualmente el `.md` creado en `Agent/Heartbeat/` si el contenido es inválido;
4. conservar la evidencia del journal y del audit log;
5. no tocar `Drafts_Agent`, `Reports_Agent`, notas núcleo ni Syncthing como parte del rollback.

Si hubiera impacto mayor sobre el vault, aplicar el backup del vault ya validado en Sprint 3.

## Evidencia a guardar

- salida de `systemctl status openclaw-vault-heartbeat-writer.service --no-pager`;
- salida de `journalctl -u openclaw-vault-heartbeat-writer.service --no-pager -n 50`;
- diff o listado before/after de `Agent/Heartbeat/`;
- prueba de ausencia de cambios fuera de `Agent/Heartbeat/`;
- contenido del `.md` creado;
- línea JSONL correspondiente del audit log host-side;
- prueba de que no apareció listener nuevo;
- prueba de que bot y contenedor siguieron sanos.

## Criterio de abortar

Abortar si ocurre cualquiera de estos casos:

- la ruta destino resuelve fuera de `Agent/Heartbeat/`;
- aparece cualquier cambio en el vault fuera de `Agent/Heartbeat/`;
- el destino o alguno de sus padres es symlink;
- el writer requiere reutilizar secretos del bot;
- la identidad dedicada exige ampliar privilegios sin justificación mínima;
- aparece un listener nuevo;
- `openclaw-gateway` o el bot Telegram muestran degradación atribuible al cambio;
- la auditoría host-side no queda separada del vault;
- el resultado depende de timer, watcher o lógica no documentada.

## Pendiente de verificación en host

- existencia final del usuario `openclaw-vault-writer`;
- grupo exacto y permisos efectivos mínimos para la unidad;
- ruta final de auditoría fuera del vault;
- ruta final de instalación de la unidad real en `/etc/systemd/system/`;
- si `/opt/automation/projects/obsi-claw-AI_agent` sigue siendo el clon operativo correcto;
- si el `runtime-status` inicial debe llevar `run_id` externo o fijo por unidad;
- si `LogsDirectory=` de `systemd` es suficiente o si conviene ruta de auditoría distinta;
- cualquier ajuste fino de ownership o ACL requerido para create-only real;
- la secuencia exacta de comandos host-side de despliegue y validación.
