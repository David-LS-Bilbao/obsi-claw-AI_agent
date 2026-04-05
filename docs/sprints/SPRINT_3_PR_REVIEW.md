# SPRINT_3_PR_REVIEW.md

## Estado

Documento de preparación para revisión humana y futura PR de Sprint 3.

No autoriza despliegue en host.
No sustituye validación operativa.

## Resumen de PR

### Objetivo del sprint

Consolidar la base documental y arquitectónica para:

- vault canónico en VPS;
- Syncthing como solución prevista de sincronización;
- política de ownership;
- separación vault/runtime;
- conflictos, exclusiones y backups;
- zonas controladas de escritura del agente;
- preparación segura para una futura integración controlada OpenClaw ↔ Vault.

### Qué se ha documentado

- ADR del vault canónico y de la separación OpenClaw/vault;
- ADR de ownership y límites de escritura del agente;
- runbook de preparación de Syncthing en DAVLOS;
- runbook de acceso seguro a la GUI de Syncthing;
- convención canónica de carpetas y zonas del vault;
- baseline documental de conflictos, exclusiones y backups;
- borrador del sprint;
- borrador de cierre documental;
- resumen de relevo hacia Sprint 4.

### Decisiones cerradas

- el vault canónico en DAVLOS queda fijado como diseño objetivo de producto;
- Syncthing queda fijado como solución prevista de sincronización;
- el runtime del agente debe permanecer separado del vault;
- OpenClaw no queda autorizado para escribir libremente sobre toda la bóveda;
- las zonas controladas del agente se modelan bajo `Agent/Inbox_Agent/`, `Agent/Drafts_Agent/`, `Agent/Reports_Agent/` y `Agent/Heartbeat/`;
- la promoción a conocimiento estable requiere HITL;
- la postura base es de mínimo privilegio para lectura y escritura.

### Qué sigue abierto

- si la zona del agente vivirá dentro del vault principal o en carpeta hermana;
- ownership exacto en host;
- usuario y grupo del sistema para Syncthing;
- exclusiones exactas de sincronización;
- política concreta de conflictos;
- estrategia operativa mínima de backup y restore;
- postura final por plataforma, especialmente iOS;
- método final de acceso seguro a la GUI.

### Pendiente de verificación en host

- ruta operativa real del vault canónico;
- existencia material del vault en DAVLOS;
- existencia o no de despliegue real de Syncthing;
- usuario, grupo y permisos efectivos;
- binds, puertos y unidad de servicio reales;
- exclusiones efectivas de sync;
- mecanismo operativo de backup y restore.

### Riesgos residuales

- confundir diseño objetivo con estado real observado;
- abrir superficie innecesaria alrededor de Syncthing;
- diluir ownership del conocimiento del usuario;
- permitir que el agente salga de zonas controladas;
- tratar Syncthing como sustituto de backup;
- abrir Sprint 4 sin contraste previo en host.

## Documentos canónicos a revisar primero

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
- `docs/sprints/SPRINT_3_BORRADOR.md`
- `docs/sprints/SPRINT_3_CIERRE_BORRADOR.md`
- `RESUMEN_SPRINT_3.md`

## Checklist de revisión humana

- [ ] Hay coherencia entre `README.md`, `docs/PLAN_DIRECTOR.md`, `docs/MAPA_DE_SPRINTS.md` y las ADRs.
- [ ] Ningún documento convierte diseño objetivo en despliegue ya realizado.
- [ ] El ownership humano del conocimiento queda fijado de forma explícita.
- [ ] El agente queda restringido a zonas controladas y no parece autorizado para escribir libremente sobre toda la bóveda.
- [ ] La convención `Agent/...` se usa de forma coherente como naming canónico.
- [ ] Syncthing se trata como solución prevista y no como componente activado.
- [ ] La GUI de Syncthing se trata como acceso localhost-only o canal controlado, no como superficie pública.
- [ ] Conflictos, exclusiones y backups quedan tratados como baseline prudente.
- [ ] `pendiente de verificación en host` se usa donde todavía no hay evidencia material.
- [ ] Sprint 4 aparece preparado, pero no activado todavía.

## Texto base para descripción de PR

```md
## Objetivo

Preparar Sprint 3 como sprint documental de arquitectura y gobierno del vault, sin desplegar Syncthing ni activar todavía la integración operativa OpenClaw ↔ Vault.

## Qué incluye

- ADR del vault canónico y de la separación vault/runtime
- ADR de ownership y límites de escritura
- runbook de preparación de Syncthing
- runbook de acceso seguro a la GUI
- convención de carpetas y zonas controladas
- baseline de conflictos, exclusiones y backups
- borrador de sprint, borrador de cierre y resumen de relevo

## Decisiones cerradas

- vault canónico en DAVLOS como diseño objetivo
- Syncthing como solución prevista de sincronización
- runtime del agente separado del vault
- escritura del agente limitada a `Agent/Inbox_Agent/`, `Agent/Drafts_Agent/`, `Agent/Reports_Agent/` y `Agent/Heartbeat/`
- HITL obligatorio para promoción a conocimiento estable
- mínimo privilegio como baseline

## Qué no hace esta PR

- no despliega Syncthing
- no crea el vault en host
- no fija permisos efectivos en DAVLOS
- no abre GUI ni puertos
- no activa Sprint 4

## Pendiente de verificación en host

- ruta real del vault
- ownership y permisos efectivos
- servicio, binds y puertos reales de Syncthing
- exclusiones exactas de sync
- estrategia operativa de backup y restore

## Riesgos residuales

- confundir diseño con despliegue
- abrir más superficie de la necesaria
- diluir ownership del usuario
- permitir escritura demasiado amplia al agente
- tratar Syncthing como sustituto de backup
```
