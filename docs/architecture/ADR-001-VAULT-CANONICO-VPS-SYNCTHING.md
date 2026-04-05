# ADR-001 — VAULT CANÓNICO EN VPS + SYNCTHING + OPENCLAW SEPARADO

## Estado
Aceptada

## Contexto

El proyecto Obsi-Claw requiere:

- un segundo cerebro accesible desde varios dispositivos;
- un VPS DAVLOS donde ya existe un boundary OpenClaw real;
- una solución sin Obsidian Sync de pago;
- una forma de mantener Obsidian y OpenClaw unidos sin mezclar runtime y conocimiento.

## Decisión

Se adopta la siguiente arquitectura:

1. **Vault canónico** en el VPS DAVLOS.
2. **Syncthing** como mecanismo previsto de sincronización de archivos.
3. **Copias locales** del vault en los dispositivos del usuario.
4. **OpenClaw separado del vault**, manteniendo el runtime del agente fuera de la ruta del conocimiento.
5. **Escritura del agente restringida** a zonas controladas.
6. **Nada de abrir el vault remoto en vivo** como carpeta remota de edición multiusuario.

## Rutas objetivo recomendadas

### Runtime del agente
- `/opt/automation/agents/openclaw`
- `/etc/davlos/secrets/openclaw`

### Vault canónico
- `/opt/data/obsidian/vault-main`

### Posible zona específica del agente
- `/opt/data/obsidian/vault-agent-zone`

## Zonas iniciales de escritura permitida del agente

Dentro del vault principal o en una subzona controlada:

- `Inbox_Agent/`
- `Drafts_Agent/`
- `Reports_Agent/`
- `Heartbeat/`

## Consecuencias

### Positivas
- se evita coste recurrente de Obsidian Sync;
- el VPS puede actuar como nodo central;
- los dispositivos trabajan sobre copias locales;
- el runtime del agente sigue separado;
- se puede aplicar ownership claro y HITL.

### Negativas
- mayor complejidad operativa que Obsidian Sync;
- necesidad de diseñar política de conflictos;
- necesidad de backups del vault;
- posible fricción adicional en iOS.

## Decisiones derivadas

- Sprint 2 no instalará Syncthing todavía.
- Sprint 3 definirá e implementará la arquitectura del vault y la preparación de Syncthing.
- Sprint 4 habilitará la primera integración controlada OpenClaw ↔ vault.

## No objetivos de esta ADR

- no define todavía exclusiones exactas de sync;
- no define puertos, firewall ni despliegue operativo de Syncthing;
- no autoriza activar sync bidireccional total;
- no autoriza al agente a escribir sobre notas núcleo del usuario.
