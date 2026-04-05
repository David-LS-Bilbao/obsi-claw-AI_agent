# ADR-002 — OWNERSHIP Y LÍMITES DE ESCRITURA DEL VAULT

## Estado
Aceptada como decisión de producto

## Propósito

Definir la política de ownership del conocimiento y los límites de lectura y escritura del agente sobre el vault canónico de Obsidian.

## Alcance

Esta ADR fija política documental y de producto.
No demuestra permisos efectivos en host.
No autoriza cambios de ACLs, usuarios ni mounts por sí sola.

## Contexto

El proyecto adopta como diseño objetivo:

- vault canónico en DAVLOS;
- OpenClaw separado del runtime del vault;
- Syncthing como mecanismo previsto de sincronización;
- colaboración del agente solo en zonas controladas;
- promoción a notas núcleo con HITL.

Sin esta política, el riesgo principal es mezclar conocimiento humano, borradores del agente y automatización sin control.

## Decisiones

### 1. Owner primario del conocimiento

El owner primario del conocimiento es el usuario humano.

Esto implica:

- ownership editorial de notas núcleo;
- ownership de la taxonomía principal;
- ownership de decisiones de promoción, borrado, reestructuración y conflicto.

### 2. Rol del agente

OpenClaw se trata como colaborador restringido, no como owner del vault.

El agente puede:

- leer únicamente lo que una política futura le permita de forma explícita;
- escribir solo en zonas controladas;
- producir borradores, reportes, heartbeats o material revisable;
- proponer, no consolidar por sí solo, cambios en notas núcleo.

### 3. Escritura permitida por defecto

La escritura del agente se limita por defecto a zonas controladas, por ejemplo:

- `Agent/Inbox_Agent/`
- `Agent/Drafts_Agent/`
- `Agent/Reports_Agent/`
- `Agent/Heartbeat/`

La lista exacta de carpetas canónicas se define en `docs/vault/CONVENCION_DE_CARPETAS_Y_ZONAS.md`.

### 4. Zonas prohibidas por defecto

El agente no debe escribir por defecto en:

- notas núcleo del usuario;
- índices principales del vault;
- carpetas sensibles o privadas del usuario;
- configuraciones de Obsidian;
- áreas no incluidas en la política de escritura controlada.

### 5. HITL obligatorio

Requieren HITL como baseline:

- promoción de borrador a nota canónica;
- mover notas existentes;
- borrar notas;
- cambiar taxonomía principal;
- resolver conflictos de sincronización;
- ampliar la superficie de escritura del agente.

### 6. Lectura del agente

El principio de producto es mínimo privilegio también para lectura.

La lectura exacta que se autorice al agente queda `pendiente de verificación en host` y de definición operativa posterior.
Por defecto, este repositorio no autoriza a inferir lectura completa de toda la bóveda.

## Qué no se autoriza todavía

- escritura libre sobre toda la bóveda;
- promoción automática a notas núcleo;
- borrado automático;
- reconciliación automática de conflictos;
- mantenimiento masivo de enlaces o renombrados;
- asumir que el agente ya tiene acceso efectivo al vault en host.

## Consecuencias

### Positivas

- ownership claro;
- menor riesgo de corrupción documental;
- trazabilidad más limpia entre contenido humano y contenido del agente;
- alineación con HITL y mínimo privilegio.

### Costes

- más fricción operativa;
- necesidad de revisión humana;
- necesidad de documentar conflictos y promociones.

## Pendiente de verificación en host

- usuario y grupo efectivos que serían owner del vault;
- permisos POSIX o ACL concretas;
- superficie real de lectura del agente;
- mecanismo técnico exacto para imponer estos límites.
