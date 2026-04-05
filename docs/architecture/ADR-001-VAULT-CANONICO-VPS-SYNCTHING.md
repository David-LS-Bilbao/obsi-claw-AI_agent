# ADR-001 — VAULT CANÓNICO EN VPS + SYNCTHING + OPENCLAW SEPARADO

## Estado
Aceptada como decisión de producto

## Alcance

Esta ADR fija una dirección de arquitectura.
No demuestra despliegue en host.
No autoriza por sí sola instalación de Syncthing ni creación material del vault.

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

Las rutas anteriores son objetivo recomendado de diseño y quedan `pendiente de verificación en host` como estado materializado.

## Zonas iniciales de escritura permitida del agente

Dentro del vault principal o en una subzona controlada:

- `Agent/Inbox_Agent/`
- `Agent/Drafts_Agent/`
- `Agent/Reports_Agent/`
- `Agent/Heartbeat/`

La convención de carpetas canónica se cierra en `docs/vault/CONVENCION_DE_CARPETAS_Y_ZONAS.md`.

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
- Sprint 3 definirá y dejará preparada documentalmente la arquitectura del vault, la política de ownership y la preparación de Syncthing.
- Sprint 4 habilitará la primera integración controlada OpenClaw ↔ vault.

## No objetivos de esta ADR

- no define todavía exclusiones exactas de sync;
- no define puertos, firewall ni despliegue operativo de Syncthing;
- no fija todavía el usuario del sistema ni el ownership exacto del servicio de sincronización;
- no autoriza activar sync bidireccional total;
- no autoriza al agente a escribir sobre notas núcleo del usuario.
