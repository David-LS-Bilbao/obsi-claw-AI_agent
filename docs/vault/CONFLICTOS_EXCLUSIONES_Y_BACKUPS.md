# CONFLICTOS_EXCLUSIONES_Y_BACKUPS.md

## Propósito

Definir la postura mínima y prudente para:

- conflictos de sincronización;
- exclusiones iniciales de sync;
- backups del vault;
- restore y validación.

## Estado

Borrador de Sprint 3.

No demuestra que exista una política desplegada en host.

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

Como baseline prudente, deben evaluarse para exclusión:

- cachés o metadatos locales no necesarios;
- temporales de trabajo del agente si no forman parte del conocimiento estable;
- directorios de exportación efímera;
- cualquier artefacto que aumente ruido entre dispositivos.

La lista exacta queda abierta y `pendiente de verificación en host`.

## Backups

### Postura mínima

- el vault canónico debe tener backups trazables;
- el backup no debe depender solo de Syncthing;
- debe existir restore validable, no solo copia de archivos.

### Preguntas aún abiertas

- frecuencia exacta;
- ubicación exacta en DAVLOS;
- incremental vs snapshot completo;
- retención;
- validación periódica de restore.

## Restore

Baseline recomendada:

1. restaurar sobre entorno controlado;
2. validar integridad del árbol;
3. revisar notas núcleo y zonas del agente;
4. confirmar que la política de exclusiones y conflictos sigue siendo coherente.

## Qué no debe asumirse

- que Syncthing sustituye a backup;
- que restore está resuelto por existir una copia;
- que conflictos de sync pueden dejarse a criterio implícito del usuario;
- que el agente pueda reconciliar conflictos automáticamente.

## Pendiente de verificación en host

- ubicación real de backups;
- mecanismo real de backup;
- frecuencia viable;
- procedimiento exacto de restore;
- exclusiones concretas que conviene fijar en Syncthing y en el propio vault.
