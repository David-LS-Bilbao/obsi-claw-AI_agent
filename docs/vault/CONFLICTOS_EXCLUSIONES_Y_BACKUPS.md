# CONFLICTOS_EXCLUSIONES_Y_BACKUPS.md

## Propósito

Definir la postura mínima y prudente para:

- conflictos de sincronización;
- exclusiones iniciales de sync;
- renombrados y borrados;
- backups del vault;
- restore y validación.

## Estado

Baseline documental cerrada con validación host-side mínima en Sprint 3.

## Estado real observado

Sprint 3 ya dejó materializado en host que:

- `vault-main` es una carpeta local de Syncthing;
- no hay dispositivos remotos ni pairing;
- existe `.stignore` mínimo conservador en `/opt/data/obsidian/vault-main/.stignore`;
- existe backup manual del vault en `/opt/backups/obsidian`;
- existe restore de prueba en ruta temporal fuera del vault vivo.

## Conflictos previsibles

### Conflicto usuario vs usuario

Dos dispositivos pueden modificar la misma nota en tiempos cercanos.

### Conflicto usuario vs agente

El usuario puede editar una nota mientras el agente genera un borrador relacionado o intenta promover contenido.

### Conflicto estructural

Cambios en taxonomía, nombres o carpetas pueden desalinear sync y enlaces.

## Baseline prudente de resolución

- el contenido humano estable prevalece sobre contenido generado automáticamente;
- el agente no resuelve conflictos por sí solo;
- cualquier conflicto que afecte notas núcleo requiere HITL;
- la promoción del agente debe ocurrir desde zonas controladas, no sobre notas vivas del usuario.

## Exclusiones iniciales de sync

La lista mínima y conservadora ya materializada en `.stignore` es:

```text
.DS_Store
Thumbs.db
desktop.ini
*~
*.swp
*.swo
.~lock.*
.obsidian/cache/**
.obsidian/workspace.json
.obsidian/workspace-mobile.json
.obsidian/window-state.json
```

### Qué no se ignora todavía

- contenido Markdown;
- adjuntos reales del vault;
- carpetas núcleo del usuario;
- `Agent/`;
- `.obsidian` completa;
- plugins, themes, snippets o templates.

## Renombrados y borrados

La baseline cerrada en Sprint 3 es:

- nada de renombrados masivos mientras no haya clientes validados;
- nada de borrados automáticos por parte del agente;
- toda operación estructural relevante requiere HITL;
- cualquier renombrado o borrado amplio deberá ir precedido por backup o snapshot cuando ese mecanismo exista;
- Syncthing no se usa como sustituto de recuperación.

## Backups

### Postura mínima ya validada

- el vault canónico tiene backup trazable en el VPS;
- el backup no depende de Syncthing;
- existe restore validado en ruta temporal;
- la política de retención y disparadores se detalla en `docs/runbooks/VAULT_BACKUP_RETENCION_Y_DISPARADORES.md`.

## Restore

Baseline ya validada:

1. restaurar sobre ruta temporal fuera del vault vivo;
2. verificar integridad básica del árbol restaurado;
3. comparar inventario básico con el vault vivo;
4. solo después evaluar una recuperación real.

## Qué no debe asumirse

- que Syncthing sustituye a backup;
- que restore está resuelto por existir una copia;
- que conflictos de sync pueden dejarse a criterio implícito del usuario;
- que el agente puede reconciliar conflictos automáticamente.

## Pendiente de verificación en host

- pairing real con clientes;
- ajustes futuros de exclusiones cuando aparezca contenido cliente real;
- retención y automatización posteriores al baseline manual;
- cualquier restore real sobre el vault vivo.
