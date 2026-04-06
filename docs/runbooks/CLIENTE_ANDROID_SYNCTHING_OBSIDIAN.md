# CLIENTE_ANDROID_SYNCTHING_OBSIDIAN.md

## Propósito

Definir el flujo recomendado para un futuro cliente Android con Obsidian + Syncthing, sin tratarlo como validado en Sprint 3.

## Estado

Flujo definido documentalmente.
No validado todavía con dispositivos Android reales.

## Estado real observado

En host ya quedó validado que:

- existe `vault-main` como nodo canónico;
- Syncthing opera sin dispositivos remotos ni pairing;
- existe `.stignore` mínimo conservador;
- existe backup manual del vault con restore de prueba;
- OpenClaw sigue separado del vault y de Syncthing.

## Modelo de copia local del vault en Android

La postura baseline es:

- el dispositivo Android mantiene una copia local del vault;
- la app de Obsidian trabaja sobre esa copia local;
- Syncthing sincroniza archivos, no sesiones de edición remota;
- el almacenamiento debe ser estable y no depender de rutas temporales o poco fiables.

## Prerrequisitos antes de cualquier pairing

- backup reciente del vault canónico;
- dispositivo con espacio suficiente;
- permisos de almacenamiento bien resueltos;
- exclusión de optimizaciones agresivas de batería si la app lo requiere;
- carpeta local clara y persistente para el vault;
- decisión explícita de validar primero un solo dispositivo Android.

## Flujo recomendado futuro

1. Definir la carpeta local del vault en almacenamiento estable.
2. Verificar permisos de almacenamiento de Obsidian y Syncthing.
3. Revisar política de batería para evitar que Syncthing quede suspendido de forma impredecible.
4. Confirmar backup reciente del vault canónico.
5. Hacer pairing controlado con un único dispositivo.
6. Esperar primera sincronización completa y revisar inventario básico.
7. Abrir Obsidian sobre la copia local y validar lectura/escritura normal del usuario.
8. Mantener observación antes de sumar más clientes.

## Advertencias específicas de Android

- la batería puede suspender procesos en segundo plano;
- los permisos de almacenamiento pueden cambiar entre versiones de Android;
- tarjetas SD o rutas inestables no son baseline recomendada;
- la primera sincronización puede ser más lenta o sensible a conectividad.

## Qué no hacer

- no usar almacenamiento efímero o poco fiable;
- no arrancar pairing sin backup reciente;
- no mezclar el primer pairing con cambios masivos del vault;
- no asumir que Android se comporta igual que escritorio;
- no tratar a Syncthing como mecanismo de backup.

## Validaciones mínimas

- la carpeta local existe y es accesible;
- Obsidian puede abrir la copia local;
- no aparecen conflictos anómalos en la primera sincronización;
- la app de Syncthing no queda bloqueada por batería o permisos;
- el inventario básico coincide con el vault canónico.

## Riesgos

- batería o sistema operativo suspendiendo sincronización;
- permisos de almacenamiento incompletos;
- rutas locales inestables;
- conflicto de edición si se usa el móvil como primer cliente agresivo.

## Criterio de GO/NO-GO para un futuro pairing real

### GO

- backup reciente confirmado;
- almacenamiento local estable;
- permisos y batería resueltos;
- un solo dispositivo Android nuevo en la ventana;
- usuario entiende el modelo de copia local.

### NO-GO

- almacenamiento inestable;
- permisos incompletos;
- batería bloqueando la app;
- ausencia de backup reciente;
- intento de validar varios clientes a la vez.
