# CLIENTE_ESCRITORIO_SYNCTHING_OBSIDIAN.md

## Propósito

Definir el flujo recomendado para un futuro cliente de escritorio con Obsidian + Syncthing, sin tratarlo como ya validado en Sprint 3.

## Estado

Flujo definido documentalmente.
No validado todavía con clientes reales.

## Estado real observado

En host ya quedó validado que:

- existe `vault-main` como vault canónico;
- Syncthing opera en DAVLOS como nodo local y sin pairing;
- la GUI queda en loopback;
- existe `.stignore` mínimo conservador;
- existe backup manual con restore de prueba independiente de Syncthing.

## Modelo de copia local del vault

La copia de escritorio debe funcionar así:

- el usuario trabaja sobre una carpeta local del dispositivo;
- Obsidian abre esa copia local;
- Syncthing sincroniza archivos entre la copia local y el nodo canónico;
- no se trabaja sobre shares de red ni sobre el vault del VPS montado remotamente.

## Prerrequisitos antes de cualquier pairing

- backup reciente del vault canónico;
- host DAVLOS estable y sin cambios estructurales pendientes;
- `vault-main` sin renombrados masivos en curso;
- cliente con Syncthing y Obsidian instalados;
- ruta local del cliente estable, persistente y fuera de carpetas efímeras;
- espacio suficiente en disco para copia completa del vault;
- decisión explícita de arrancar con un solo cliente nuevo a la vez.

## Flujo recomendado de onboarding futuro

1. Preparar una carpeta local vacía y dedicada al vault.
2. Verificar que el usuario abrirá esa carpeta con Obsidian, no una ruta remota.
3. Confirmar backup reciente del vault canónico.
4. Revisar que no haya cambios estructurales amplios pendientes.
5. Hacer pairing controlado con un solo cliente.
6. Esperar primera sincronización completa y revisar inventario básico.
7. Abrir Obsidian sobre la copia local y revisar que el vault se comporta de forma normal.
8. Mantener observación antes de incorporar un segundo cliente.

## Qué no hacer

- no abrir el vault del VPS por share de red;
- no hacer pairing de dos clientes nuevos en paralelo;
- no iniciar el primer pairing durante renombrados o borrados amplios;
- no usar Syncthing como excusa para saltarse backup;
- no mezclar la fase de cliente con cambios de OpenClaw.

## Validaciones mínimas

- la carpeta local existe y es persistente;
- el inventario básico coincide con el vault canónico;
- no aparecen conflictos inesperados en la primera sincronización;
- `.stignore` sigue siendo coherente con el contenido recibido;
- el usuario abre la copia local sin editar directamente el VPS.

## Riesgos

- conflictos por edición concurrente;
- ruido por configuración local del cliente;
- error humano al abrir una ruta incorrecta;
- arrancar sin backup reciente;
- normalizar pairing antes de cerrar observabilidad mínima.

## Criterio de GO/NO-GO para un futuro pairing real

### GO

- backup reciente confirmado;
- host DAVLOS estable;
- cliente con copia local dedicada;
- un solo cliente nuevo en la ventana;
- usuario entiende que trabaja sobre copia local.

### NO-GO

- no hay backup fresco;
- hay renombrados o borrados amplios pendientes;
- el cliente pretende abrir un vault remoto en red;
- se quiere incorporar más de un cliente nuevo a la vez;
- el pairing se intenta mezclar con cambios de OpenClaw o de permisos.
