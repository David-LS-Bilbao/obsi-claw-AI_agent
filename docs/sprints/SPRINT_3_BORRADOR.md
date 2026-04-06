# SPRINT_3_BORRADOR.md

## Estado

Documento base consolidado para evaluación final de cierre de Sprint 3.

## Objetivo real

Cerrar Sprint 3 como sprint de:

- arquitectura del vault canónico;
- baseline host-side mínima del vault y de Syncthing;
- política de ownership;
- separación vault/runtime;
- conflictos, exclusiones y backups;
- postura prudente por plataforma;
- preparación documental para fases futuras sin activar clientes.

## Alcance

### Dentro de alcance

- ADRs y decisiones de arquitectura;
- runbooks de Syncthing y de clientes futuros;
- política de ownership;
- convención de carpetas y zonas;
- conflictos, exclusiones, renombrados, borrados y backups;
- cierre documental del baseline host-side mínima ya validada.

### Fuera de alcance

- pairing real con clientes;
- onboarding real de escritorio o Android;
- despliegue en iPhone/iPad;
- integración operativa OpenClaw ↔ Vault;
- apertura pública de Syncthing;
- escritura libre del agente sobre el vault.

## Estado real observado que sirve de baseline

- existe `/opt/data/obsidian/vault-main`;
- el vault base tiene ownership `devops:obsidian`;
- el árbol base del vault ya está materializado;
- `syncthing@syncthing.service` está activo;
- la GUI de Syncthing escucha en `127.0.0.1:8384` con auth local;
- el listener TCP escucha en `127.0.0.1:22000`;
- `vault-main` quedó registrada como carpeta local;
- existe `.stignore` mínimo conservador;
- existe backup manual en `/opt/backups/obsidian` y restore de prueba en ruta temporal;
- no hay dispositivos remotos;
- no hay pairing;
- no hay integración OpenClaw ↔ Vault.

## Decisiones cerradas

- el vault canónico vive en DAVLOS;
- Syncthing es la solución prevista de sincronización;
- el runtime del agente permanece separado del vault;
- el agente no escribe libremente sobre toda la bóveda;
- las zonas controladas baseline viven bajo `Agent/Inbox_Agent/`, `Agent/Drafts_Agent/`, `Agent/Reports_Agent/` y `Agent/Heartbeat/`;
- la promoción a notas núcleo requiere HITL;
- Syncthing no sustituye a backup.

## Qué sigue abierto

- pairing y onboarding real con clientes;
- decisión final sobre una eventual `vault-agent-zone` separada;
- superficie real de lectura del agente fuera de zonas controladas;

## Entregables esperados

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
- `docs/sprints/SPRINT_3_BORRADOR.md`
- `docs/sprints/SPRINT_3_CIERRE_BORRADOR.md`
- `docs/sprints/SPRINT_3_PR_REVIEW.md`
- `RESUMEN_SPRINT_3.md`

## Riesgos principales

- confundir baseline host-side mínima con sync productivo;
- abrir clientes sin backup reciente;
- abrir superficie innecesaria alrededor de Syncthing;
- diluir ownership del conocimiento del usuario;
- mezclar vault y runtime del agente.

## Criterio de cierre

Sprint 3 puede darse por listo para cierre si:

- el estado real observado y la decisión documental cerrada quedan separados con claridad;
- los pendientes reales de host se reducen a pairing y clientes, no a la baseline mínima ya validada;
- existe postura por plataforma sin venderla como validación real con clientes;
- existe política prudente de conflictos, exclusiones, backup y restore;
- Sprint 4 no se abre ni implícita ni documentalmente;
- la lectura canónica del sprint es de cierre cerrable por checklist y evidencia dentro de su alcance real.
