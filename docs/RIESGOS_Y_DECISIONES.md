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
- baseline Sprint 3 documentada con listener TCP en loopback;
- `vault-main` registrada como carpeta local;
- `.stignore` mínimo conservador;
- backup manual del vault y restore de prueba;
- baseline Sprint 3 documentada sin dispositivos remotos ni pairing.

Sprint 5 abrió una tensión documental adicional:

- observación de `10.90.0.1:22000` sobre `wg0`;
- el alcance efectivo actual de `22000` queda `pendiente de verificación en host`;
- no debe afirmarse exposición pública sin verificación adicional en host.

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

### DEC-009 — El uso estable del sistema se declara solo en sentido prudente
**Estado:** aceptada

`Uso estable del sistema` no significa perfección ni ausencia total de warnings.
Significa que las capacidades mínimas validadas permiten uso sostenido con ámbar conocido, acotado y no bloqueante, sin vender:

- reconstrucción reproducible completa del boundary;
- sincronización productiva total de Syncthing;
- un canal Telegram plenamente fiable.

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
- reconciliación continua entre repo de producto y repo operativo cuando aparezca drift observable.

### RISK-006 — Alcance documental del listener Syncthing `22000`
**Estado:** ámbar
**Tratamiento:** Sprint 6 / continuo

Riesgo:
- mantener `local-only` como formulación global cuando el scope efectivo de `22000` ya quedó tensionado documentalmente.

Mitigación:
- separar GUI/API en loopback del listener de sincronización;
- usar redacción prudente;
- mantener el alcance efectivo de `22000` como `pendiente de verificación en host`.

### RISK-007 — Telegram con validación mínima pero degradación observable
**Estado:** ámbar
**Tratamiento:** Sprint 6 / continuo

Riesgo:
- confundir validación mínima de `/status` con canal plenamente fiable.

Mitigación:
- tratar Telegram como validado mínimamente para uso operativo prudente;
- mantener en ámbar la degradación observable de polling;
- reservar como `pendiente de verificación en host` cualquier afirmación de fiabilidad sostenida o ausencia de degradación.

### RISK-008 — Inflar Sprint 5 por encima de la evidencia
**Estado:** ámbar
**Tratamiento:** Sprint 6 / continuo

Riesgo:
- presentar Sprint 5 como cierre amplio de skills, Telegram o autonomía cuando la evidencia validada es más acotada.

Mitigación:
- sostener que la Skill 01 es la capacidad interna claramente validada;
- tratar `draft.write` reutilizado como segunda tarea real segura, no como arrastre a nuevas capacidades;
- conservar el cierre del sprint como prudente y no maximalista.

### RISK-009 — Confundir backup externo mínimo del boundary con reconstrucción completa
**Estado:** ámbar
**Tratamiento:** Sprint 6 / continuo

Riesgo:
- asumir que la continuidad del boundary ya quedó cerrada por existir bundle externo mínimo;
- ignorar que, aun tras el backup de secretos y el rebuild rehearsal mínimo, sigue sin demostrarse una reconstrucción reproducible completa.

Mitigación:
- documentar que la continuidad ya no depende solo del runtime vivo;
- mantener la clasificación como recuperabilidad parcial;
- conservar como `pendiente de verificación en host` cualquier afirmación de reconstrucción exacta o continuidad integral cerrada.

## No decisiones todavía cerradas

- si conviene una carpeta hermana `vault-agent-zone` o solo zonas controladas dentro del vault principal;
- la superficie real de lectura que se autorizaría al agente fuera de zonas controladas;
- la retención y automatización posteriores del backup del vault;
- el alcance efectivo actual del listener Syncthing `22000`;
- la fiabilidad sostenida del canal Telegram más allá de su validación mínima;
- el pairing y la validación real con clientes.
