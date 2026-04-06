# SPRINT_3_CIERRE_BORRADOR.md

## Resumen ejecutivo

Sprint 3 queda listo para evaluación de cierre como sprint de:

- arquitectura del vault canónico;
- gobierno documental del conocimiento;
- baseline host-side mínima del vault y de Syncthing;
- política prudente de exclusiones, conflictos, renombrados, borrados y backup;
- definición de flujos futuros de cliente sin activarlos todavía.

Lectura canónica propuesta: Sprint 3 queda cerrable por checklist y evidencia dentro de su alcance real.

## Alcance realmente cubierto por Sprint 3

### Estado real observado

Sprint 3 ya dejó validado en host que:

- existe `/opt/data/obsidian/vault-main`;
- el ownership base del vault es `devops:obsidian`;
- existe el árbol base del vault;
- Syncthing opera como servicio dedicado;
- la GUI escucha en `127.0.0.1:8384` con auth local;
- el listener TCP escucha en `127.0.0.1:22000`;
- `vault-main` quedó dada de alta como carpeta local;
- existe `.stignore` mínimo conservador;
- existe backup manual en `/opt/backups/obsidian`;
- existe restore de prueba en ruta temporal;
- no hay dispositivos remotos ni pairing;
- OpenClaw sigue separado del vault y de Syncthing.

### Decisiones documentales cerradas

- vault canónico en DAVLOS;
- Syncthing como solución prevista de sincronización;
- runtime del agente separado del vault;
- escritura del agente limitada a zonas controladas;
- HITL obligatorio para promoción, renombrados amplios y borrados;
- Syncthing no se trata como backup;
- postura prudente por plataforma para escritorio, Android e iPhone/iPad.

### Fuera de alcance

- pairing real con clientes;
- onboarding real de clientes;
- despliegue productivo en iPhone/iPad;
- integración operativa OpenClaw ↔ Vault;
- apertura pública de la GUI o de puertos de Syncthing;
- ampliación de privilegios del agente sobre el vault.

## Pendiente de verificación en host

- pairing y onboarding real con clientes;
- necesidad real de una `vault-agent-zone` separada;
- superficie real de lectura del agente fuera de zonas controladas;

## Entregables creados

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

## Riesgos residuales

- confundir baseline host-side mínima con sincronización productiva;
- abrir clientes sin una ventana controlada y sin backup reciente;
- diluir ownership del conocimiento del usuario;
- usar Syncthing como excusa para evitar una política de recuperación.

## Criterio de cierre del sprint

Sprint 3 puede darse por listo para cierre si la revisión humana confirma que:

- el estado host-side mínimo ya validado quedó reflejado sin exageraciones;
- los pendientes reales se concentran en pairing/onboarding de clientes y no en la baseline del VPS;
- la documentación no convierte flujos definidos en validaciones ya ejecutadas;
- Sprint 4 no queda abierto ni implícita ni operativamente.

## Condiciones previas para abrir Sprint 4

Antes de abrir Sprint 4 debe seguir cumpliéndose:

- Sprint 3 queda cerrado primero;
- no se fuerza pairing por arrastre documental;
- no se mezcla el baseline del vault con integración operativa del agente;
- cualquier nueva fase parte de la separación actual entre OpenClaw y el vault.
