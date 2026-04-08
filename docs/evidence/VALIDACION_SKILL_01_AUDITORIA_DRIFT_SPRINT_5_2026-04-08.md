# Validación Skill 01 — Auditoría de Drift — Sprint 5

## 1. Objetivo

Dejar evidencia canónica de la ejecución de la Skill 01 — Auditoría de Drift Host ↔ Documentación como primera validación útil de Sprint 5, con contraste entre documentación operativa clave y estado mínimo observable del host en modo solo lectura.

## 2. Alcance ejecutado

- Modo ejecutado: solo lectura, sin `sudo`, sin edición y sin mutación de host.
- Documentación contrastada:
  - `/opt/automation/projects/obsi-claw-AI_agent/docs/ESTADO_GLOBAL.md`
  - `/opt/automation/projects/obsi-claw-AI_agent/docs/ESTADO_SEMAFORICO.md`
  - `/opt/control-plane/README.md`
- Estado host comprobado:
  - existencia de `/opt/control-plane`
  - estado de `openclaw-telegram-bot.service`
  - estado de `openclaw-vault-heartbeat-writer.service`
  - estado de `openclaw-vault-draft-writer.service`
  - listeners `18789`, `11440`, `8384`, `22000`
  - existencia y contenido de alto nivel de `Agent/Heartbeat` y `Agent/Drafts_Agent`

## 3. Hallazgos confirmados

- `/opt/control-plane` existe y su `README.md` es legible.
- `docs/ESTADO_GLOBAL.md` y `docs/ESTADO_SEMAFORICO.md` existen y son legibles en el clon operativo auditado.
- `openclaw-telegram-bot.service` figura como `active (running)` desde `2026-04-03 06:37:23 UTC`.
- El journal corto visible de `openclaw-telegram-bot.service` muestra warnings de polling `502 Bad Gateway` y `read operation timed out`, en línea con el estado ÁMBAR documentado.
- `openclaw-vault-heartbeat-writer.service` existe, está cargado como `static` y aparece `inactive (dead)` tras ejecución correcta el `2026-04-07 10:49:46 UTC`.
- `openclaw-vault-draft-writer.service` existe, está cargado como `static` y aparece `inactive (dead)` tras ejecuciones correctas el `2026-04-07 12:21:32 UTC` y `2026-04-07 15:12:20 UTC`.
- Listeners observados:
  - `127.0.0.1:18789`
  - `127.0.0.1:11440`
  - `172.22.0.1:11440`
  - `127.0.0.1:8384`
  - `10.90.0.1:22000`
- `/opt/data/obsidian/vault-main/Agent/Heartbeat` existe y contiene 1 fichero `.md`.
- `/opt/data/obsidian/vault-main/Agent/Drafts_Agent` existe y contiene 2 ficheros `.md`.
- El contenido de alto nivel observado confirma:
  - `heartbeat_type: "runtime-status"`
  - trigger manual `systemd oneshot`
  - drafts con estado `pending_human_review`
  - ausencia de promoción automática

## 4. Divergencias relevantes

- `ESTADO_GLOBAL.md` documenta el listener TCP de Syncthing en `127.0.0.1:22000`, pero la observación directa del host muestra `10.90.0.1:22000`.
- `ESTADO_GLOBAL.md` afirma que no aparecieron referencias runtime nuevas entre OpenClaw y `/opt/data/obsidian`, pero la observación directa del host muestra dos unidades `openclaw-vault-*` con ejecuciones recientes y escritura efectiva en:
  - `/opt/data/obsidian/vault-main/Agent/Heartbeat`
  - `/opt/data/obsidian/vault-main/Agent/Drafts_Agent`

## 5. Riesgo operativo

- Riesgo documental medio: usar `ESTADO_GLOBAL.md` como resumen operativo vigente puede ocultar que ya existe integración controlada OpenClaw ↔ vault en modo `oneshot`.
- Riesgo de superficie medio: si `22000` ya no está limitado a `127.0.0.1`, la afirmación documental de operación `local-only` para Syncthing puede estar desactualizada o mal acotada.
- En este alcance no se observó evidencia de fallo inmediato del runtime auditado.

## 6. Pendientes de verificación en host

- Sesión SSH operativa externa: `pendiente de verificación en host`.
- Requisito de autenticación local en la GUI de Syncthing en `127.0.0.1:8384`: `pendiente de verificación en host`.
- Afirmación de que Syncthing sigue sin carpetas activas y sin dispositivos remotos: `pendiente de verificación en host`.
- Estado exacto de `syncthing@syncthing.service`: `pendiente de verificación en host`.
- Comprobación funcional HTTP del gateway más allá del listener TCP observado: `pendiente de verificación en host`.
- Alcance real de exposición del listener `10.90.0.1:22000`: `pendiente de verificación en host`.

## 7. Impacto sobre el checklist de Sprint 5

- Esta ejecución aporta evidencia canónica de una tarea real, segura y revisable de Sprint 5.
- La ejecución confirma que la Skill 01 produce hallazgos útiles y accionables sin mutación del host.
- La ejecución mejora el estado operativo del sprint al fijar dos divergencias concretas entre documentación y host.
- Esta evidencia no cierra Sprint 5 por completo; persisten puntos `pendiente de verificación en host` y reconciliación documental por completar.

## 8. Conclusión

La Skill 01 quedó validada como mecanismo útil de auditoría mínima entre documentación operativa y estado observable del host. La evidencia obtenida confirma continuidad del runtime auditado, confirma integración controlada OpenClaw ↔ vault en modo `oneshot` y detecta drift documental relevante sobre Syncthing y sobre la relación actual entre OpenClaw y el vault.

## 9. Siguiente paso recomendado

Usar esta evidencia como baseline corto de Sprint 5 y contrastar, en una iteración documental posterior, `ESTADO_GLOBAL.md` frente a los dos drift confirmados en esta validación, manteniendo como no cerrado todo lo `pendiente de verificación en host`.
