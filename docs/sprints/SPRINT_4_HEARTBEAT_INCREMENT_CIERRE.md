# SPRINT_4_HEARTBEAT_INCREMENT_CIERRE.md

## Resumen ejecutivo

La subfase operativa inicial de Sprint 4 queda cerrable como subfase de:

- integración mínima OpenClaw ↔ Vault;
- `heartbeat.write` only;
- writer host-side dedicado;
- `systemd oneshot` manual;
- create-only en `Agent/Heartbeat/`;
- auditoría host-side fuera del vault.

El cierre es deliberadamente estrecho:

- no abre `draft.write`;
- no abre `report.write`;
- no abre watcher;
- no abre promoción automática.

## Alcance exacto de la subfase

Esta subfase cubre solo:

- instalación y validación host-side del writer dedicado `openclaw-vault-writer`;
- validación de la unidad `openclaw-vault-heartbeat-writer.service` como `oneshot` manual;
- una ejecución real validada de `heartbeat.write`;
- tipo único validado: `runtime-status`;
- destino único validado: `Agent/Heartbeat/`;
- verificación de "un archivo nuevo y nada más".

## Qué quedó validado

- el writer dedicado existe y quedó separado del bot Telegram;
- la unidad `systemd` del writer quedó como `oneshot`, `static`, sin timer y sin listener;
- el flujo create-only sobre `Agent/Heartbeat/` funcionó en host;
- se creó exactamente un `.md` nuevo en `Agent/Heartbeat/`;
- no se observaron cambios en `Agent/Inbox_Agent/`, `Agent/Drafts_Agent/`, `Agent/Reports_Agent/` ni `90_Notas_Nucleo_Usuario/`;
- la auditoría quedó fuera del vault;
- `openclaw-gateway` siguió sano;
- `openclaw-telegram-bot.service` siguió activo;
- no aparecieron listeners nuevos.

## Qué no quedó validado

- `draft.write`;
- `report.write`;
- cualquier escritura en `Agent/Drafts_Agent/`;
- cualquier escritura en `Agent/Reports_Agent/`;
- watcher;
- timer;
- promoción automática;
- operación recurrente diaria;
- generación automática futura de más tipos de heartbeat;
- política final de retención observada en host más allá de esta subfase.

## Evidencia canónica

Evidencia principal de host:

- `docs/evidence/VALIDACION_HEARTBEAT_WRITER_SPRINT_4_2026-04-07.md`

Documentación de apoyo:

- `docs/runbooks/OPENCLAW_VAULT_HEARTBEATS_SPRINT_4.md`
- `docs/architecture/ADR-003-INTEGRACION-CONTROLADA-OPENCLAW-VAULT.md`
- `docs/runbooks/OPENCLAW_VAULT_HEARTBEAT_WRITER_DEPLOY_SPRINT_4.md`
- `docs/checklists/SPRINT_4_HEARTBEAT_WRITER_VALIDACION.md`

## Política mínima de operación adoptada

### Frecuencia inicial

Frecuencia baseline recomendada:

- ad hoc/manual only.

No se recomienda todavía:

- frecuencia diaria automática;
- emisión por evento automática;
- timer;
- watcher.

Racional:

- menor ruido documental;
- validación más clara de cada ejecución;
- trazabilidad humana simple;
- evita automatización prematura antes de abrir más superficie.

### Retención mínima en `Agent/Heartbeat/`

Retención baseline recomendada:

- mantener el conjunto vivo pequeño y legible;
- preferir un máximo operativo de `10` heartbeats o `30` días, lo que ocurra antes;
- no aplicar borrado automático.

### Criterio de archivo o limpieza

Hasta nueva fase, el criterio mínimo es:

1. revisión humana del heartbeat antiguo;
2. confirmación de que el audit log host-side correspondiente sigue disponible;
3. confirmación de que el heartbeat no está referenciado por una incidencia activa;
4. retirada o archivo manual.

La ruta final de archivo sigue `pendiente de verificación en host`.

### Límites para evitar ruido documental

- no emitir heartbeats periódicos por defecto;
- no emitir más de un heartbeat por intervención manual si no hay motivo claro;
- no usar `Agent/Heartbeat/` como log continuo;
- no dejar crecer `Agent/Heartbeat/` sin revisión humana;
- no ampliar tipos de heartbeat sin nueva validación.

## Decisión baseline sobre `run_id`

La baseline documental para siguientes ejecuciones será:

- wrapper mínimo que genere `run_id` automáticamente por ejecución.

No se recomienda `run_id` fijo en la unidad porque:

- degrada la trazabilidad entre ejecuciones;
- dificulta correlacionar nota, audit log y evidencia;
- introduce ambigüedad en futuras validaciones.

No se recomienda depender de inyección manual como baseline porque:

- aumenta riesgo de error humano;
- dificulta repetibilidad operativa;
- hace más frágil la correlación entre ejecución y evidencia.

La materialización del wrapper sigue `pendiente de verificación en host`.

## Riesgos residuales

- confundir el cierre de `heartbeat.write` con GO para abrir `draft.write`;
- dejar `run_id` sin cerrar técnicamente y erosionar la trazabilidad futura;
- generar ruido si la frecuencia manual se relaja sin política clara;
- ampliar tipos de heartbeat sin nueva validación host-side;
- tratar la subfase heartbeat como validación implícita de toda la integración OpenClaw ↔ Vault.

## Criterio de cierre de esta subfase

La subfase puede considerarse cerrada porque:

- el primer incremento real ya quedó validado en host;
- la evidencia canónica ya existe;
- la política mínima de operación ya quedó fijada;
- el límite de alcance quedó explícito;
- no se presenta esta subfase como GO para capacidades posteriores.

## Criterio explícito de no abrir aún `draft.write`

No hay GO todavía para `draft.write`.

Antes de estudiarlo debe seguir cumpliéndose:

- subfase `heartbeat.write` cerrada documentalmente;
- política fina de `run_id` resuelta en baseline;
- operación manual del heartbeat entendible y mantenible;
- nueva validación host-side específica para `Agent/Drafts_Agent/`.
