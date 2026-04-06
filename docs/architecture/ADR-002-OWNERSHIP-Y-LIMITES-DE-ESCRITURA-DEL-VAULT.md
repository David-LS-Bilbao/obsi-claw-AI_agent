# ADR-002 — OWNERSHIP Y LÍMITES DE ESCRITURA DEL VAULT

## Estado
Aceptada como decisión de producto y apoyada por baseline host-side mínima en Sprint 3.

## Propósito

Definir el ownership del conocimiento y los límites de lectura y escritura del agente sobre el vault canónico.

## Alcance

Esta ADR fija política documental.
No sustituye la evidencia host-side ni autoriza por sí sola cambios de ACLs, mounts o ampliación de privilegios del agente.

## Estado real observado

Sprint 3 ya validó en host que:

- el vault base existe en `/opt/data/obsidian/vault-main`;
- el ownership base del vault es `devops:obsidian`;
- Syncthing usa un usuario separado (`syncthing`);
- OpenClaw sigue fuera de la ruta del vault;
- no existe todavía integración operativa OpenClaw ↔ Vault.

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

- leer únicamente lo que una política futura le autorice de forma explícita;
- escribir solo en zonas controladas;
- producir borradores, reportes y heartbeats revisables;
- proponer cambios, no consolidarlos por sí solo sobre notas núcleo.

### 3. Escritura permitida por defecto

La escritura del agente se limita por defecto a:

- `Agent/Inbox_Agent/`
- `Agent/Drafts_Agent/`
- `Agent/Reports_Agent/`
- `Agent/Heartbeat/`

La lista canónica se define en `docs/vault/CONVENCION_DE_CARPETAS_Y_ZONAS.md`.

### 4. Zonas prohibidas por defecto

El agente no debe escribir por defecto en:

- notas núcleo del usuario;
- índices principales del vault;
- carpetas sensibles o privadas;
- configuraciones de Obsidian;
- áreas no incluidas en la política de escritura controlada.

### 5. HITL obligatorio

Requieren HITL como baseline:

- promoción de borrador a nota canónica;
- mover notas existentes;
- borrar notas;
- renombrados amplios;
- resolver conflictos de sincronización;
- ampliar la superficie de escritura del agente.

### 6. Lectura del agente

El principio de producto sigue siendo mínimo privilegio también para lectura.

Sprint 3 no autoriza a inferir lectura completa de toda la bóveda por parte del agente.

## Qué no se autoriza todavía

- escritura libre sobre toda la bóveda;
- promoción automática a notas núcleo;
- borrado automático;
- reconciliación automática de conflictos;
- mantenimiento masivo de enlaces;
- asumir que OpenClaw ya tiene acceso efectivo al vault.

## Consecuencias

### Positivas

- ownership claro;
- menor riesgo de corrupción documental;
- mejor trazabilidad entre contenido humano y contenido del agente;
- alineación con HITL y mínimo privilegio.

### Costes

- mayor fricción operativa;
- necesidad de revisión humana;
- necesidad de imponer límites técnicos en una fase posterior.

## Pendiente de verificación en host

- la superficie real de lectura que se autorizaría al agente fuera de zonas controladas;
- el mecanismo técnico exacto para imponer esos límites;
- si conviene separar más adelante una `vault-agent-zone` independiente;
- cualquier ajuste fino de permisos por zona más allá del ownership base ya validado.
