# RIESGOS_Y_DECISIONES.md

## Registro de decisiones

### DEC-001 — El boundary OpenClaw actual se trata como baseline real
**Estado:** aceptada

Se asume que OpenClaw ya está desplegado en DAVLOS y que Sprint 2 no parte de una instalación desde cero.

### DEC-002 — El gap principal previo a Obsidian es egress / allowlist
**Estado:** aceptada

Antes de activar sincronización o integración operativa con el vault, debe reducirse el riesgo de salida libre del boundary.

### DEC-003 — No se usará Obsidian Sync de pago como solución base
**Estado:** aceptada

El proyecto usará una solución autogestionada basada en sincronización de archivos.

### DEC-004 — El vault canónico vivirá en el VPS DAVLOS
**Estado:** aceptada

Decisión cerrada a nivel de producto:

- el vault canónico debe vivir en DAVLOS y no dentro del runtime del agente.

Ruta objetivo recomendada en diseño:

- `/opt/data/obsidian/vault-main`

La ruta ya quedó materializada y validada en host.
La evidencia canónica quedó registrada en `docs/evidence/VALIDACION_HOST_VAULT_SYNCTHING_SPRINT_3_2026-04-05.md`.

### DEC-005 — La sincronización prevista será mediante Syncthing
**Estado:** aceptada

El modelo será:

- VPS como nodo canónico,
- clientes con copia local,
- sincronización de archivos,
- nada de abrir el vault remoto en vivo.

Ya quedó validado en host un baseline mínimo:

- `syncthing@syncthing.service`;
- usuario dedicado `syncthing`;
- GUI solo en loopback;
- auth local explícita;
- listener TCP solo en loopback;
- `vault-main` registrada como carpeta local;
- `.stignore` mínimo conservador;
- backup manual del vault y restore de prueba;
- sin dispositivos remotos ni pairing.

Siguen pendientes fuera del cierre de Sprint 3:

- pairing y validación real con clientes.

### DEC-006 — OpenClaw no escribirá libremente sobre toda la bóveda
**Estado:** aceptada

Las primeras zonas de escritura del agente serán controladas y acotadas.

Sprint 3 cerró la baseline y los límites iniciales.
Sprint 4 debe operacionalizar la política exacta de lectura, promoción, movimiento y rollback del agente dentro de ese perímetro.

### DEC-007 — El cierre de egress en Sprint 2 se documenta sin inventar una primera activación no demostrable
**Estado:** aceptada

El gap `egress/allowlist` queda `VERDE` en Sprint 2, pero la última ventana revisada se documenta como validación/reaplicación idempotente porque los snapshots previos del propio script muestran estado ya activo antes del `apply` final.

### DEC-008 — Sprint 3 se resuelve primero como arquitectura y después como baseline host-side mínima
**Estado:** aceptada

Sprint 3 arrancó como sprint de arquitectura y preparación documental.
La validación host-side posterior se limitó a una baseline mínima y reversible del vault y de Syncthing, sin pairing, sin clientes y sin integración OpenClaw ↔ Vault.

Sprint 3 no debe leerse como autorización implícita para abrir clientes, publicar la GUI ni abrir Sprint 4.
Su baseline en este repositorio es:

- ADRs;
- runbooks;
- convenciones;
- definición de ownership, conflictos, exclusiones y backups;
- documentación de flujos futuros por plataforma;
- congelación documental del estado host-side realmente validado.

## Riesgos del proyecto

### RISK-001 — Egress / allowlist del boundary
**Estado:** verde
**Tratamiento:** cerrado en Sprint 2

Confirmado por:
- `scripts/hardening/openclaw_egress_allowlist.sh` ya pasa `plan`, `apply` y `verify`;
- allow efectivo a `172.22.0.1:11440/tcp`;
- bloqueo efectivo probado de `1.1.1.1:443/tcp`;
- juicio cronológico adoptado: la última ventana validó/reaplicó un estado que ya aparecía activo antes del `apply` final;
- validación final consolidada en `docs/evidence/VALIDACION_EGRESS_ALLOWLIST_SPRINT_2_2026-04-05.md`.

### RISK-002 — Conflictos de sincronización del vault
**Estado:** ámbar
**Tratamiento:** Sprint 3

Riesgo:
- cambios concurrentes entre cliente y VPS;
- promoción accidental de borradores del agente;
- confusión entre notas humanas y notas generadas.

Mitigación prevista:
- ownership explícito;
- carpetas separadas;
- HITL;
- backups.

### RISK-003 — Mezcla entre runtime del agente y vault
**Estado:** ámbar
**Tratamiento:** Sprint 3

Mitigación:
- rutas separadas;
- runbooks separados;
- nada de usar el workspace del agente como vault.

### RISK-004 — Móvil iOS con más fricción operativa
**Estado:** ámbar
**Tratamiento:** Sprint 3

Mitigación:
- priorizar escritorio y Android;
- documentar alternativa específica para iOS si realmente se necesita.

### RISK-005 — Documentación desalineada entre repos
**Estado:** ámbar
**Tratamiento:** continuo

Mitigación:
- precedencia documental clara;
- actualización de docs vivas al cierre de cada sprint.

## No decisiones todavía cerradas

- si conviene una carpeta hermana `vault-agent-zone` o solo zonas controladas dentro del vault principal;
- la superficie real de lectura que se autorizaría al agente fuera de zonas controladas;
- la retención y automatización posteriores del backup del vault;
- el pairing y la validación real con clientes.
