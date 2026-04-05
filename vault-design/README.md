# README.md

## Estado actual del vault

La arquitectura documental del proyecto ya asume una decisión de alto nivel:

- el vault canónico vivirá en el VPS DAVLOS;
- la sincronización prevista será mediante Syncthing;
- OpenClaw seguirá separado del runtime del vault;
- el agente solo escribirá en zonas controladas.

Eso no significa que dicha arquitectura esté desplegada ya.
Toda activación operativa real del vault o de Syncthing sigue `pendiente de verificación en host`.

## Ruta objetivo recomendada

- `/opt/data/obsidian/vault-main`

Ruta opcional si más adelante se decide una separación más fuerte del agente:

- `/opt/data/obsidian/vault-agent-zone`

Ambas rutas se tratan como diseño objetivo recomendado y quedan `pendiente de verificación en host` hasta contraste con el layout operativo real de DAVLOS.

## Postura vigente

- no abrir el vault remoto en vivo como carpeta editable multiusuario;
- no activar sync bidireccional total sin política de conflictos;
- no reescribir notas núcleo del usuario;
- no automatizar reorganización estructural agresiva;
- sí diseñar zonas controladas donde el agente pueda producir material revisable.

## Zonas iniciales controladas para el agente

- `Agent/Inbox_Agent/`
- `Agent/Drafts_Agent/`
- `Agent/Reports_Agent/`
- `Agent/Heartbeat/`

La convención canónica de carpetas se define en `docs/vault/CONVENCION_DE_CARPETAS_Y_ZONAS.md`.

## Ownership de escritura recomendado

- el usuario conserva ownership de:
  - notas núcleo;
  - documentación estable;
  - estructura principal del vault.
- el agente queda limitado a:
  - inbox controlada;
  - borradores;
  - reportes;
  - heartbeats;
  - otras zonas autorizadas explícitamente.
- cualquier paso desde borrador a nota estable debe pasar por HITL.

## Zonas donde el agente NO escribe

- notas núcleo del usuario;
- índices principales del vault;
- convenciones globales de nombres o enlaces sin revisión humana;
- cualquier carpeta no incluida en la política de escritura controlada.

## Operaciones que requieren HITL

- promover un borrador a documento canónico;
- mover o borrar notas existentes;
- cambiar taxonomía principal;
- habilitar sync operativo;
- resolver conflictos de sincronización;
- autorizar escritura del agente fuera de zonas controladas.

## Qué no quedó activado al cierre de Sprint 2

- no se instala Syncthing;
- no se crea todavía el vault canónico en producción;
- no se abre superficie de red para sync;
- no se activa integración operativa OpenClaw ↔ vault.

## Qué pasa a Sprint 3

- concretar arquitectura final del vault canónico;
- definir exclusiones y política de conflictos;
- definir backups;
- diseñar y dejar preparada documentalmente la instalación de Syncthing;
- cerrar ownership, límites de lectura y límites de escritura del agente.

## Qué pasa a Sprint 4

- habilitar la primera integración controlada OpenClaw ↔ vault;
- activar heartbeats seguros;
- validar que el agente no corrompe el vault.

Nada de lo anterior debe asumirse desplegado por el solo hecho de que exista documentación de Sprint 3.

## Regla operativa final

Si la integración con el vault exige asumir conflictos, locking, ownership o sync no resueltos, no se activa.
