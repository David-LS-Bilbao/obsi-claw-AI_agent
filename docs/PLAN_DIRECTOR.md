# PLAN_DIRECTOR.md

## Misión del proyecto

Construir Obsi-Claw como una plataforma híbrida compuesta por:

- un **Segundo Cerebro persistente** basado en Obsidian y Markdown;
- un **operador técnico semiautónomo** basado en OpenClaw;
- un **boundary de seguridad** en DAVLOS que permita automatización sin ampliar superficie innecesaria.

## Fuentes de verdad

### Fuente de verdad operativa
- `davlos-control-plane`

### Fuente de verdad de producto y evolución documental
- `obsi-claw-AI_agent`

## Principios rectores

1. Seguridad por defecto.
2. Evidencia antes que documentación histórica.
3. Cambios pequeños, reversibles y auditables.
4. Markdown-first.
5. Git-first.
6. Human-in-the-loop para acciones de impacto.
7. Nada de mezclar runtime del agente y conocimiento del usuario sin política explícita.

## Decisión de arquitectura vigente

### Vault canónico
El vault maestro de Obsidian vivirá en el VPS DAVLOS.

Ruta objetivo recomendada:

- `/opt/data/obsidian/vault-main`

### Runtime del agente
OpenClaw sigue separado del vault:

- `/opt/automation/agents/openclaw`
- `/etc/davlos/secrets/openclaw`

### Sincronización
No se usará Obsidian Sync de pago como solución base.

La solución prevista es:

- **Syncthing**
- clientes con copia local del vault
- VPS como nodo canónico
- nada de abrir el vault remoto live desde móvil o escritorio

### Escritura del agente
OpenClaw no escribirá libremente sobre todo el vault.
Las zonas iniciales de escritura permitida serán controladas, por ejemplo:

- `Inbox_Agent/`
- `Drafts_Agent/`
- `Reports_Agent/`
- `Heartbeat/`

La promoción a notas núcleo del usuario requerirá HITL.

## Estado de partida real

No partimos desde cero:

- el boundary OpenClaw ya existe en DAVLOS;
- hay baseline real confirmada;
- helper readonly y broker core están validados;
- el gap principal sigue siendo `egress/allowlist`;
- Telegram queda en ámbar;
- Obsidian sigue todavía en modo diseño prudente.

## Roadmap director

### Sprint 1 — Auditoría, baseline y gobierno técnico
**Estado:** cerrado

Objetivo real ejecutado:
- auditar lo ya desplegado,
- consolidar baseline,
- clasificar riesgos,
- preparar Sprint 2.

### Sprint 2 — Hardening real de egress / allowlist
**Estado:** siguiente sprint

Objetivo:
- cerrar el principal gap rojo del boundary,
- aplicar o dejar listo un deny-by-default real para `agents_net`,
- mantener cambios pequeños y reversibles.

No incluye:
- instalación de Syncthing,
- activación del vault canónico,
- integración operativa de Obsidian.

### Sprint 3 — Vault canónico en VPS + Syncthing + política de ownership
Objetivo:
- fijar arquitectura del vault;
- definir layout del conocimiento;
- definir política de conflictos;
- definir exclusiones;
- diseñar y preparar la instalación de Syncthing;
- preparar backups del vault.

### Sprint 4 — Integración controlada OpenClaw ↔ Vault + heartbeats
Objetivo:
- habilitar zonas controladas de escritura del agente;
- activar primeros heartbeats útiles;
- validar que el agente no corrompe el vault;
- introducir promoción con HITL.

### Sprint 5 — Operador técnico semiautónomo
Objetivo:
- skills internas del proyecto;
- prompts operativos;
- automatizaciones útiles;
- salidas valiosas para Obsidian.

### Sprint 6 — Estabilización y operación continua
Objetivo:
- observabilidad;
- backups y recuperación;
- deuda técnica;
- documentación final;
- continuidad entre chats y sprints.

## Reglas de ejecución

- primero auditar;
- después documentar;
- luego proponer;
- y solo al final ejecutar.

## Criterio de éxito

El proyecto avanzará correctamente si logra:

- boundary endurecido y mantenible;
- vault canónico bien gobernado;
- sincronización segura con dispositivos;
- OpenClaw útil pero contenido;
- trazabilidad documental suficiente para continuidad.
