# SYNCTHING_DAVLOS_PREPARACION.md

## Propósito

Definir la postura documental y los prechecks mínimos para una futura preparación de Syncthing en DAVLOS sin asumir que esté instalado ni desplegado.

## Estado

Borrador de Sprint 3.

Todo despliegue real queda `pendiente de verificación en host`.

## Objetivo de este runbook

Dejar claro:

- para qué se usaría Syncthing;
- qué no debe hacerse por defecto;
- qué decisiones previas deben cerrarse;
- qué validar antes de tocar host;
- cómo documentar rollback conceptual.

## Postura prevista

Syncthing se adopta como solución prevista de sincronización de archivos para el vault canónico:

- DAVLOS como nodo canónico;
- clientes con copia local;
- nada de abrir el vault remoto en vivo;
- nada de usar Syncthing como excusa para dar escritura libre al agente.

## Alcance documental

Este runbook no:

- instala paquetes;
- crea servicios;
- abre puertos;
- crea carpetas reales;
- modifica firewall;
- toca systemd.

## Diseño objetivo recomendado

### Ruta objetivo

- vault principal recomendado: `/opt/data/obsidian/vault-main`
- subzona opcional del agente: `/opt/data/obsidian/vault-agent-zone`

Estas rutas quedan `pendiente de verificación en host`.

### Servicio esperado

La opción recomendada es un servicio persistente, pequeño y reversible.

Pero quedan `pendiente de verificación en host`:

- usuario exacto del sistema;
- unidad de servicio;
- bind de GUI;
- rutas de configuración;
- puertos efectivos.

## Ownership recomendado

Baseline recomendada:

- el vault pertenece al usuario humano o a una cuenta explícitamente aprobada para conocimiento;
- OpenClaw no debe ser owner del vault;
- Syncthing no debe justificar por sí solo permisos amplios para el agente.

El ownership exacto queda `pendiente de verificación en host`.

## Superficie mínima recomendada

- GUI localhost-only como baseline recomendada;
- acceso administrativo solo por túnel SSH o canal equivalente controlado;
- nada de exposición pública por defecto;
- nada de apertura de superficie “temporal” sin runbook y rollback.

## Validaciones previas mínimas

Antes de cualquier despliegue real debería validarse:

- que la ruta canónica del vault es coherente con el layout real del host;
- que existe política de ownership cerrada;
- que existe política de conflictos y exclusiones;
- que existe política mínima de backup y restore;
- que la apertura de GUI no amplía superficie innecesaria;
- que el método de acceso remoto está definido.

## Riesgos principales

- conflictos de sincronización;
- drift entre dispositivos;
- mezcla entre runtime del agente y conocimiento del usuario;
- exposición innecesaria de la GUI;
- permisos demasiado amplios.

## Rollback documental

Si una futura preparación real no supera validaciones:

1. no desplegar;
2. no abrir puertos;
3. no materializar servicio persistente;
4. mantener el vault fuera de cualquier sync activo;
5. registrar el bloqueo y volver a estado documental.

## Pendiente de verificación en host

- si Syncthing ya está instalado;
- qué paquete o método de instalación conviene en DAVLOS;
- qué usuario del sistema debe ejecutarlo;
- qué puertos y binds serían válidos;
- qué rutas reales existen o conviene crear.
