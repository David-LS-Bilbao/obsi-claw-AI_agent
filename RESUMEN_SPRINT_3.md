# RESUMEN_SPRINT_3.md

## Contexto mínimo

Obsi-Claw combina dos planos:

- un vault canónico de Obsidian como base de conocimiento;
- OpenClaw como operador técnico semiautónomo dentro de un perímetro controlado.

Sprint 1 cerró baseline y gobierno técnico.
Sprint 2 cerró el gap de `egress/allowlist`.
Sprint 3 cierra la arquitectura del vault y añade baseline host-side mínima ya validada para el vault y Syncthing, sin pairing y sin integración OpenClaw ↔ Vault.

## Estado consolidado al final de Sprint 3

### Estado real observado

- existe `/opt/data/obsidian/vault-main` materializado con ownership `devops:obsidian`;
- existe el árbol base del vault;
- existe `syncthing@syncthing.service` activo con config bajo `/var/lib/syncthing`;
- la GUI de Syncthing escucha solo en `127.0.0.1:8384` con auth local;
- el listener TCP de Syncthing quedó en `127.0.0.1:22000`;
- `vault-main` quedó registrada como carpeta local;
- existe `.stignore` mínimo conservador;
- existe backup manual del vault en `/opt/backups/obsidian`;
- existe restore de prueba en ruta temporal;
- no hay dispositivos remotos;
- no hay pairing;
- no hay referencias runtime nuevas entre OpenClaw y `/opt/data/obsidian`.

### Decisión documental cerrada

- vault canónico en DAVLOS;
- Syncthing como solución prevista de sincronización;
- runtime del agente separado del vault;
- escritura del agente solo en zonas controladas;
- HITL obligatorio para promoción, renombrados amplios y borrados;
- política prudente de conflictos, exclusiones y backup;
- postura documental por plataforma para escritorio, Android e iPhone/iPad.

### Pendiente de verificación en host

- pairing y onboarding real con clientes;
- necesidad real de una `vault-agent-zone` separada;
- superficie real de lectura del agente fuera de zonas controladas.

## Decisiones cerradas

- el vault canónico pertenece al plano de conocimiento del usuario, no al runtime del agente;
- OpenClaw no queda autorizado para escribir libremente sobre toda la bóveda;
- las zonas controladas del agente se modelan bajo `Agent/Inbox_Agent/`, `Agent/Drafts_Agent/`, `Agent/Reports_Agent/` y `Agent/Heartbeat/`;
- Syncthing ya existe como baseline host-side mínima, pero no como sync productivo con clientes;
- el backup del vault es independiente de Syncthing y ya tiene evidencia mínima de restore seguro.

## Riesgos principales

- confundir baseline host-side mínima con sync productivo;
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
- `docs/runbooks/CLIENTE_ESCRITORIO_SYNCTHING_OBSIDIAN.md`
- `docs/runbooks/CLIENTE_ANDROID_SYNCTHING_OBSIDIAN.md`
- `docs/runbooks/VAULT_BACKUP_RETENCION_Y_DISPARADORES.md`
- `docs/vault/CONVENCION_DE_CARPETAS_Y_ZONAS.md`
- `docs/vault/CONFLICTOS_EXCLUSIONES_Y_BACKUPS.md`
- `docs/vault/POSTURA_IPHONE_IPAD_SYNCTHING_OBSIDIAN.md`
- `docs/sprints/SPRINT_3_CIERRE_BORRADOR.md`
- `docs/sprints/SPRINT_3_PR_REVIEW.md`

## Siguiente paso lógico

Cerrar la revisión humana y el checklist final de Sprint 3, sin abrir Sprint 4 todavía y sin forzar pairing con clientes.
