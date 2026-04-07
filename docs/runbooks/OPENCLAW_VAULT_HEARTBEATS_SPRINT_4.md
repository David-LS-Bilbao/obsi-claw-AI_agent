# OPENCLAW_VAULT_HEARTBEATS_SPRINT_4.md

## Propósito

Definir la postura mínima y segura de heartbeats del agente sobre el vault durante Sprint 4.

## Estado real observado

Sprint 3 ya dejó validado en host que:

- el vault canónico existe;
- `Agent/` existe dentro de `vault-main`;
- OpenClaw sigue separado del vault;
- no existe todavía integración operativa OpenClaw ↔ Vault.

Además, a fecha `2026-04-07` ya quedó validado en host el primer incremento:

- writer dedicado `openclaw-vault-writer`;
- `systemd oneshot` manual;
- `heartbeat.write` only;
- create-only en `Agent/Heartbeat/`;
- un único `.md` nuevo creado;
- auditoría host-side fuera del vault;
- sin listeners nuevos;
- sin degradación observable de `openclaw-gateway` ni de `openclaw-telegram-bot.service`.

## Decisión documental cerrada

La activación inicial será `heartbeat-first`.

Watcher queda diferido.

El único heartbeat validado en host por ahora es:

- `runtime-status`

Heartbeats previstos documentalmente para fases posteriores, todavía sin GO host-side:

- `pending-review`
- `error-summary`

Todos deben escribirse únicamente en:

- `Agent/Heartbeat/`

## Precondiciones

### Documentales cerradas

- existe baseline de Sprint 3;
- `Agent/Heartbeat/` forma parte de la superficie controlada;
- HITL sigue siendo obligatorio para promoción.

### Pendiente de verificación en host

- el canal técnico exacto que emitirá los heartbeats;
- la capacidad real de escritura del agente en `Agent/Heartbeat/`;
- el formato final de naming y rotación en DAVLOS.

## Formato de salida

Cada heartbeat debe ser una nota Markdown independiente.

Patrón recomendado:

- `YYYYMMDDTHHMMSSZ_runtime-status_<run_id>.md`

Patrones futuros, todavía sin GO host-side:

- `YYYYMMDDTHHMMSSZ_pending-review_<run_id>.md`
- `YYYYMMDDTHHMMSSZ_error-summary_<run_id>.md`

Frontmatter mínimo:

```yaml
managed_by: openclaw
agent_zone: Heartbeat
run_id: <run_id>
created_at_utc: <timestamp_utc>
updated_at_utc: <timestamp_utc>
source_refs: []
human_review_status: not_required
heartbeat_type: runtime-status
```

Cuerpo mínimo:

- Contexto
- Resultado
- Trazabilidad

## Restricciones

- no leer fuera de `Agent/` para emitir heartbeats;
- no incluir secretos;
- no reescribir notas núcleo;
- no usar una única nota mutable como baseline;
- no convertir heartbeat en watcher implícito.

## Validación

La validación mínima documental exige:

- un heartbeat por archivo;
- metadata mínima presente;
- naming con timestamp UTC;
- contenido comprensible para revisión humana;
- ausencia de efectos fuera de `Agent/Heartbeat/`.

La validación host-side ya quedó cerrada para el primer incremento `runtime-status`, con evidencia en:

- `docs/evidence/VALIDACION_HEARTBEAT_WRITER_SPRINT_4_2026-04-07.md`

Matiz relevante:

- un wrapper de automatización interpretó mal `systemctl status` sobre una unidad `oneshot` ya finalizada;
- esto no debe tratarse como fallo funcional del writer.

## Política mínima de operación

### Frecuencia inicial recomendada

La frecuencia baseline recomendada es:

- ad hoc/manual only.

No se recomienda todavía:

- diaria automática;
- por evento automática;
- timer;
- watcher.

### Retención mínima recomendada

La retención baseline recomendada en `Agent/Heartbeat/` es:

- máximo operativo de `10` archivos vivos o `30` días, lo que ocurra antes;
- sin borrado automático;
- con revisión humana antes de retirar o archivar.

### Criterio de archivo o limpieza

Si `Agent/Heartbeat/` supera ese umbral:

1. el humano revisa los heartbeats más antiguos;
2. confirma que el audit log host-side correspondiente sigue disponible;
3. confirma que no existe incidencia activa asociada;
4. retira o archiva manualmente.

La ruta final de archivo sigue `pendiente de verificación en host`.

### Límite de ruido documental

- no usar `Agent/Heartbeat/` como log continuo;
- no emitir más de un heartbeat por intervención manual sin motivo claro;
- no ampliar el catálogo de heartbeats sin nueva validación host-side.

## Decisión baseline sobre `run_id`

La baseline documental para siguientes ejecuciones será:

- wrapper mínimo que genere `run_id` automáticamente por ejecución.

No se recomienda como baseline:

- `run_id` fijo en la unidad;
- inyección manual ad hoc en cada ejecución.

Racional:

- mejor trazabilidad;
- mejor repetibilidad;
- menor riesgo de error humano;
- menor riesgo de confundir validaciones futuras.

## Rollback

Baseline de rollback:

1. si el heartbeat es incorrecto, se retira o archiva manualmente el archivo generado;
2. si el patrón genera ruido, se congela la emisión y se conserva trazabilidad;
3. si hubiera impacto mayor, el fallback es el backup del vault validado en Sprint 3.

Syncthing no cuenta como rollback.

## Riesgos

- heartbeats demasiado frecuentes;
- heartbeats con información sensible;
- heartbeats ambiguos que no distingan estado de error y estado normal;
- proliferación de ruido documental en `Agent/Heartbeat/`.
- confundir el cierre de `heartbeat.write` con GO para `draft.write` o `report.write`;
- mantener `run_id` fijo en la unidad y degradar la trazabilidad futura.

## Pendiente de verificación en host

- frecuencia real segura;
- mecanismo operativo final para siguientes ejecuciones manuales;
- materialización del wrapper mínimo para generar `run_id` automáticamente;
- mecanismo real de archivo o limpieza de heartbeats antiguos.
