# ADR-001 — VAULT CANÓNICO EN VPS + SYNCTHING + OPENCLAW SEPARADO

## Estado
Aceptada como decisión de producto y contrastada con baseline host-side mínima en Sprint 3.

## Alcance

Esta ADR fija la arquitectura base del vault y recoge el estado host-side ya observado.

No autoriza por sí sola:

- pairing con clientes;
- onboarding real de escritorio o Android;
- apertura pública de Syncthing;
- integración operativa OpenClaw ↔ Vault.

## Contexto

Obsi-Claw necesita:

- un segundo cerebro accesible desde varios dispositivos;
- un nodo canónico en DAVLOS;
- una solución autogestionada de sincronización;
- separación estricta entre runtime del agente y conocimiento del usuario.

## Estado real observado

Durante Sprint 3 ya quedó validado en host que:

- el runtime de OpenClaw sigue fuera del vault;
- existe `/opt/data/obsidian/vault-main`;
- Syncthing opera como servicio dedicado;
- la GUI escucha solo en `127.0.0.1:8384` con auth local;
- el listener TCP escucha solo en `127.0.0.1:22000`;
- `vault-main` quedó registrada como carpeta local;
- no hay dispositivos remotos ni pairing;
- OpenClaw sigue separado del vault y de Syncthing.

## Decisión

Se adopta la siguiente arquitectura:

1. vault canónico en DAVLOS;
2. Syncthing como mecanismo de sincronización previsto;
3. copias locales del vault en clientes futuros;
4. OpenClaw separado del vault;
5. escritura del agente restringida a zonas controladas;
6. nada de abrir el vault remoto en vivo ni tratar Syncthing como sustituto de backup.

## Rutas canónicas

### Materializadas y validadas en host

- `/opt/automation/agents/openclaw`
- `/etc/davlos/secrets/openclaw`
- `/opt/data/obsidian/vault-main`

### Abiertas como decisión posterior

- `/opt/data/obsidian/vault-agent-zone`

La ruta `vault-agent-zone` sigue siendo opcional y no quedó materializada en Sprint 3.

## Zonas iniciales de escritura permitida del agente

Las zonas controladas baseline se modelan bajo:

- `Agent/Inbox_Agent/`
- `Agent/Drafts_Agent/`
- `Agent/Reports_Agent/`
- `Agent/Heartbeat/`

La convención canónica se detalla en `docs/vault/CONVENCION_DE_CARPETAS_Y_ZONAS.md`.

## Consecuencias

### Positivas

- el VPS puede actuar como nodo canónico sin mezclar runtime y conocimiento;
- Syncthing queda acotado a loopback y sin exposición pública;
- las copias cliente futuras se diseñan como copias locales, no como edición remota del vault vivo;
- la superficie de escritura del agente queda limitada desde el diseño.

### Costes

- mayor complejidad operativa que Obsidian Sync;
- necesidad de política explícita de conflictos;
- necesidad de backup independiente de Syncthing;
- fricción adicional esperable en iPhone/iPad.

## Pendiente de verificación en host

- pairing y onboarding real con clientes;
- necesidad real de una `vault-agent-zone` independiente;
- la superficie real de lectura del agente fuera de zonas controladas.

## No objetivos de esta ADR

- no autoriza sync productivo con clientes;
- no define flujos operativos por plataforma más allá del baseline documental;
- no autoriza escritura del agente fuera de zonas controladas;
- no autoriza promoción automática a notas núcleo del usuario.
