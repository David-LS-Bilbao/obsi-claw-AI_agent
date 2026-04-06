# VAULT_BACKUP_RETENCION_Y_DISPARADORES.md

## Propósito

Definir la política mínima de retención y los disparadores operativos de backup del vault canónico en Sprint 3.

## Estado

Baseline documental cerrada con evidencia host-side mínima ya validada.

## Estado real observado

Ya quedó validado en host que:

- la ruta de backup es `/opt/backups/obsidian/`;
- existe al menos un backup manual del vault;
- el naming baseline usa timestamp UTC en el artefacto;
- existe checksum acompañante;
- el restore de prueba se hizo en ruta temporal fuera del vault vivo;
- Syncthing no participa como mecanismo de backup.

## Mecanismo baseline de backup

El mecanismo mínimo de Sprint 3 es:

- `tar --zstd` del contenido de `vault-main`;
- artefacto en `/opt/backups/obsidian/`;
- checksum `sha256` por artefacto;
- restore de prueba a ruta temporal.

## Naming baseline

Formato:

- `vault-main_YYYYMMDDTHHMMSSZ.tar.zst`
- `vault-main_YYYYMMDDTHHMMSSZ.tar.zst.sha256`

## Política mínima de retención

Como baseline operativa de Sprint 3:

- conservar siempre el último backup validado por restore;
- conservar al menos los últimos 7 backups diarios;
- conservar cualquier backup generado justo antes de un cambio estructural relevante hasta que exista otro backup validado posterior;
- no borrar el único backup validado disponible.

Sprint 3 no introduce todavía rotación automática.

## Disparadores de backup manual adicional

Hacer backup adicional cuando ocurra cualquiera de estos casos:

- antes de renombrados amplios;
- antes de borrados amplios;
- antes de cambios estructurales del árbol del vault;
- antes de modificar de forma material la política de exclusiones;
- antes de cualquier futuro pairing real con clientes;
- después de una intervención importante, si hace falta congelar nuevo baseline.

## Relación entre backup y cambios estructurales

La regla baseline es:

- no mezclar cambios estructurales amplios con ausencia de backup fresco;
- no usar Syncthing como sustituto de snapshot;
- no asumir que un backup viejo cubre una ventana de cambio relevante posterior.

## Restore seguro

El restore baseline se hace así:

1. extraer el artefacto en una ruta temporal fuera del vault vivo;
2. verificar checksum;
3. revisar árbol restaurado;
4. comparar inventario básico con el vault canónico;
5. solo después decidir si hace falta una recuperación real.

## Qué sigue abierto para fases posteriores

- automatización de la retención;
- política incremental o deduplicada más avanzada;
- validaciones periódicas adicionales de restore;
- criterio final de archivo histórico a más largo plazo.

## Qué no debe asumirse

- que Syncthing equivale a backup;
- que un restore probado en temporal autoriza por sí solo restaurar sobre el vault vivo;
- que la retención mínima manual de Sprint 3 resuelve la política final del proyecto.
