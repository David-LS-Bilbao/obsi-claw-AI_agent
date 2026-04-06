# SPRINT_3_PR_REVIEW.md

## Estado

Documento de preparación para revisión humana y PR de cierre de Sprint 3.

No sustituye validación operativa adicional ni autoriza pairing.

## Resumen de PR

### Objetivo del sprint

Consolidar Sprint 3 como sprint de:

- arquitectura del vault canónico;
- baseline host-side mínima del vault y de Syncthing;
- política de ownership;
- separación vault/runtime;
- conflictos, exclusiones, renombrados, borrados y backups;
- postura prudente por plataforma sin activar clientes.

### Qué se ha documentado

- ADR del vault canónico y de la separación OpenClaw/vault;
- ADR de ownership y límites de escritura del agente;
- runbook de baseline host-side de Syncthing en DAVLOS;
- runbook de acceso seguro a la GUI de Syncthing;
- runbooks de cliente futuro para escritorio y Android;
- postura prudente para iPhone/iPad;
- política de backup, retención y disparadores;
- convención canónica de carpetas y zonas del vault;
- baseline de conflictos, exclusiones y backups;
- borrador del sprint, borrador de cierre y resumen final.

### Estado real observado

- existe `/opt/data/obsidian/vault-main`;
- el vault base tiene ownership `devops:obsidian`;
- Syncthing opera como servicio dedicado;
- la GUI escucha solo en `127.0.0.1:8384`;
- el listener TCP escucha solo en `127.0.0.1:22000`;
- `vault-main` quedó registrada como carpeta local;
- existe `.stignore` mínimo conservador;
- existe backup manual con restore de prueba;
- no hay dispositivos remotos;
- no hay pairing;
- OpenClaw sigue separado del vault y de Syncthing.

### Decisiones cerradas

- el vault canónico en DAVLOS queda fijado como baseline de producto;
- Syncthing queda fijado como baseline host-side mínima y como solución prevista de sincronización;
- el runtime del agente permanece separado del vault;
- OpenClaw no queda autorizado para escribir libremente sobre toda la bóveda;
- las zonas controladas del agente se modelan bajo `Agent/Inbox_Agent/`, `Agent/Drafts_Agent/`, `Agent/Reports_Agent/` y `Agent/Heartbeat/`;
- la promoción a conocimiento estable requiere HITL;
- Syncthing no sustituye backup;
- iPhone/iPad no queda aprobado como primer cliente objetivo de Sprint 3.

### Qué sigue abierto

- pairing y onboarding real con clientes;
- necesidad real de una `vault-agent-zone` separada;
- superficie real de lectura del agente fuera de zonas controladas;

## Documentos canónicos a revisar primero

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
- `docs/sprints/SPRINT_3_BORRADOR.md`
- `docs/sprints/SPRINT_3_CIERRE_BORRADOR.md`
- `RESUMEN_SPRINT_3.md`

## Checklist de revisión humana

- [ ] Hay coherencia entre `README.md`, `docs/PLAN_DIRECTOR.md`, `docs/MAPA_DE_SPRINTS.md` y las ADRs.
- [ ] Los documentos separan `estado real observado`, `decisión documental cerrada` y `pendiente de verificación en host`.
- [ ] Ningún documento convierte flujos cliente definidos en pairing ya validado.
- [ ] El ownership humano del conocimiento queda fijado de forma explícita.
- [ ] El agente queda restringido a zonas controladas y no parece autorizado para escribir libremente sobre toda la bóveda.
- [ ] Syncthing aparece como baseline host-side mínima ya validada, sin convertirse en sync productivo.
- [ ] La GUI de Syncthing queda como `localhost-only` sin superficie pública nueva.
- [ ] Conflictos, exclusiones, renombrados, borrados y backups quedan tratados como baseline prudente.
- [ ] La postura de iPhone/iPad queda documentada sin venderla como despliegue viable ya ejecutado.
- [ ] Sprint 4 no aparece abierto ni implícita ni operativamente.

## Texto base para descripción de PR

```md
## Objetivo

Cerrar Sprint 3 como sprint cerrable por checklist y evidencia dentro de su alcance real: arquitectura del vault y baseline host-side mínima ya validada para Syncthing y backup, sin pairing y sin abrir Sprint 4.

## Qué incluye

- ADR del vault canónico y de la separación vault/runtime
- ADR de ownership y límites de escritura
- runbook de baseline host-side de Syncthing
- runbook de acceso seguro a la GUI
- runbooks de cliente futuro para escritorio y Android
- postura prudente para iPhone/iPad
- política de conflictos, exclusiones, renombrados, borrados, backup y restore
- borrador del sprint, borrador de cierre y resumen final

## Estado real observado

- existe `/opt/data/obsidian/vault-main`
- Syncthing opera como servicio dedicado con GUI en `127.0.0.1:8384` y listener TCP en `127.0.0.1:22000`
- `vault-main` ya está registrada como carpeta local
- existe `.stignore` mínimo conservador
- existe backup manual con restore de prueba
- no hay dispositivos remotos
- no hay pairing
- no hay integración OpenClaw ↔ vault

## Qué no hace esta PR

- no hace pairing con clientes
- no valida onboarding real de escritorio o Android
- no despliega clientes iOS/iPadOS
- no abre GUI ni puertos públicos
- no activa Sprint 4
```
