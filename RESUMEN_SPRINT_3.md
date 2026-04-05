# RESUMEN_SPRINT_3.md

## Contexto mínimo

Obsi-Claw combina dos planos:

- un vault canónico de Obsidian como base de conocimiento;
- OpenClaw como operador técnico semiautónomo dentro de un perímetro controlado.

Sprint 1 cerró baseline y gobierno técnico.
Sprint 2 cerró documentalmente y con evidencia funcional suficiente el gap de `egress/allowlist`.
Sprint 3 arrancó como cierre documental de arquitectura y hoy ya añade validación host-side mínima del vault y del plano administrativo de Syncthing, sin pairing y sin integración OpenClaw ↔ Vault.

## Estado consolidado al final de Sprint 3

### Decisión documental cerrada

- vault canónico en DAVLOS como diseño objetivo;
- Syncthing como solución prevista de sincronización;
- runtime del agente separado del vault;
- escritura del agente solo en zonas controladas;
- HITL obligatorio para promoción a conocimiento estable;
- postura de mínimo privilegio para lectura y escritura.

### Estado real observado

- existe un boundary OpenClaw previo en DAVLOS documentado en la base del proyecto;
- existe `/opt/data/obsidian/vault-main` materializado con ownership `devops:obsidian`;
- existe `syncthing@syncthing.service` activo con config bajo `/var/lib/syncthing`;
- la GUI de Syncthing escucha solo en `127.0.0.1:8384` y exige auth local;
- el listener TCP de Syncthing quedó en `127.0.0.1:22000`;
- Syncthing sigue con `0` carpetas activas y `0` dispositivos remotos;
- no hay referencias runtime nuevas entre OpenClaw y `/opt/data/obsidian`.

La evidencia canónica de este estado quedó registrada en `docs/evidence/VALIDACION_HOST_VAULT_SYNCTHING_SPRINT_3_2026-04-05.md`.

### Pendiente de verificación en host

- alta de la primera carpeta real del vault dentro de Syncthing;
- exclusiones exactas de sync;
- estrategia operativa de backup y restore;
- pairing con clientes;
- postura final por plataforma, sobre todo iOS.

## Decisiones cerradas

- el vault canónico pertenece al plano de conocimiento del usuario, no al runtime del agente;
- OpenClaw no queda autorizado para escribir libremente sobre toda la bóveda;
- las zonas controladas del agente se modelan bajo `Agent/Inbox_Agent/`, `Agent/Drafts_Agent/`, `Agent/Reports_Agent/` y `Agent/Heartbeat/`;
- las notas núcleo del usuario y la taxonomía principal quedan fuera de escritura directa del agente;
- Syncthing ya existe como servicio mínimo, pero todavía no como sync productivo;
- la GUI de Syncthing quedó cerrada en loopback con auth local y acceso recomendado por túnel SSH.

## Decisiones abiertas

- si la zona del agente vivirá dentro del vault principal o en carpeta hermana;
- política exacta de conflictos;
- exclusiones exactas de sincronización;
- política operativa mínima de backup y restore;
- postura final por plataforma, sobre todo iOS.

## Riesgos principales

- confundir diseño objetivo con estado real observado;
- abrir superficie innecesaria alrededor de Syncthing;
- permitir escritura demasiado amplia al agente;
- mezclar vault y runtime;
- tratar sync como sustituto de backup.

## Artefactos canónicos que hay que leer primero

- `README.md`
- `docs/PLAN_DIRECTOR.md`
- `docs/MAPA_DE_SPRINTS.md`
- `docs/RIESGOS_Y_DECISIONES.md`
- `docs/architecture/ADR-001-VAULT-CANONICO-VPS-SYNCTHING.md`
- `docs/architecture/ADR-002-OWNERSHIP-Y-LIMITES-DE-ESCRITURA-DEL-VAULT.md`
- `docs/runbooks/SYNCTHING_DAVLOS_PREPARACION.md`
- `docs/runbooks/SYNCTHING_GUI_ACCESO_SEGURO.md`
- `docs/vault/CONVENCION_DE_CARPETAS_Y_ZONAS.md`
- `docs/vault/CONFLICTOS_EXCLUSIONES_Y_BACKUPS.md`
- `docs/sprints/SPRINT_3_CIERRE_BORRADOR.md`
- `docs/sprints/SPRINT_3_PR_REVIEW.md`

## Siguiente paso lógico

Seguir dentro de Sprint 3, sin abrir Sprint 4 todavía.

El orden prudente ahora es:

1. dar de alta `vault-main` como carpeta local en Syncthing;
2. mantener `0` dispositivos remotos y `0` pairing;
3. validar exclusiones de sync y backups operativos;
4. mantener separación estricta entre OpenClaw y el vault.

## Prompt breve de arranque para Sprint 4

Usa Sprint 3 como baseline documental.
No asumas despliegue previo de vault ni de Syncthing.
Primero contrasta estado real observado en host, después define la primera integración controlada OpenClaw ↔ Vault con HITL, mínimo privilegio y zonas de escritura limitadas.
