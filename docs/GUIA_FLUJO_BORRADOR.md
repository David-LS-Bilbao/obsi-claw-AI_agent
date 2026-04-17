# Guía de flujo: borrador desde Telegram → Obsidian

Esta guía describe el flujo completo para crear y gestionar borradores usando OpenClaw desde Telegram, siguiendo el contrato ADR-003.

## Visión general

```
Telegram (usuario)
    ↓  "escribe borrador: Título :: Contenido"
OpenClaw Bot
    ↓  confirmación HITL
    ↓  action.draft.write.v1
Agent/Inbox_Agent/STAGED_INPUT.md     ← señal para el pipeline
Agent/Drafts_Agent/<ts>_draft_<id>.md ← borrador con pending_human_review
    ↓  Syncthing
Obsidian (móvil/escritorio)
    ↓  revisar y editar el borrador
    ↓  promover o archivar
Vault (nota final)
```

## Paso 1 — Crear borrador desde Telegram

Envía al bot:

```
escribe borrador: Ideas para el sprint 6 :: Puntos principales: revisar backlog, priorizar con el equipo
```

El separador `::` divide el título del contenido. El bot responde con una confirmación:

```
Voy a crear un borrador en Agent/Drafts_Agent.
título: Ideas para el sprint 6
contenido: Puntos principales...
¿Confirmas? (sí/no)
```

Responde `sí`. El bot confirma:

```
Borrador creado.
título: Ideas para el sprint 6
ruta: Agent/Drafts_Agent/20260417T161223Z_draft_20260417T161223Z.md
Estado: pending_human_review — revísalo en Obsidian antes de promoverlo.
```

## Paso 2 — Revisar en Obsidian

El borrador aparece en `Agent/Drafts_Agent/` con frontmatter:

```yaml
---
managed_by: openclaw
agent_zone: Drafts_Agent
run_id: "20260417T161223Z"
created_at_utc: "2026-04-17T16:12:23Z"
human_review_status: pending_human_review
proposed_target_path: ""
---

# Ideas para el sprint 6

Puntos principales...
```

Edita el contenido en Obsidian. Cuando estés satisfecho, cambia `human_review_status` a `reviewed` o mueve la nota a su ubicación final en el vault.

## Paso 3 — Ventana del pipeline (STAGED_INPUT.md)

`Agent/Inbox_Agent/STAGED_INPUT.md` actúa como señal del pipeline. **Solo puede existir uno a la vez.**

Si intentas crear otro borrador mientras existe uno pendiente, el bot responde:

```
No se puede crear un borrador: STAGED_INPUT.md ya existe.
Hay un pipeline pendiente sin procesar.
Espera a que el agente lo procese o archívalo antes de crear uno nuevo.
```

Para desbloquear manualmente en el VPS:

```bash
sudo mv /opt/data/obsidian/vault-main/Agent/Inbox_Agent/STAGED_INPUT.md \
    /opt/data/obsidian/vault-main/Agent/Inbox_Agent/_staging_backup/STAGED_INPUT.$(date +%Y%m%dT%H%M%S).bak.md
```

## Explorar borradores desde Telegram

```
ver borradores
```

Lista los archivos en `Agent/Drafts_Agent/` (excluyendo artefactos de pipeline).

## Otras capturas rápidas

Para captura sin ocupar la ventana del pipeline:

```
captura: Idea rápida :: Texto corto de la idea
```

Escribe directamente en `Agent/Inbox_Agent/` como nota normal, sin tocar `STAGED_INPUT.md`.

## Referencia de contratos

- **ADR-001**: Vault canónico en VPS + Syncthing
- **ADR-002**: Ownership y límites de escritura del vault
- **ADR-003**: Integración controlada OpenClaw ↔ vault (`docs/architecture/ADR-003-INTEGRACION-CONTROLADA-OPENCLAW-VAULT.md`)
