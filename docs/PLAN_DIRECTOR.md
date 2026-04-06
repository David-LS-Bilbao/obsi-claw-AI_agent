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

La ruta anterior ya quedó validada y materializada en host como:

- `/opt/data/obsidian/vault-main`

La evidencia canónica quedó registrada en `docs/evidence/VALIDACION_HOST_VAULT_SYNCTHING_SPRINT_3_2026-04-05.md`.

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

Estado host-side ya validado en Sprint 3:

- `syncthing@syncthing.service` activo;
- usuario de sistema `syncthing`;
- config bajo `/var/lib/syncthing`;
- GUI en `127.0.0.1:8384` con auth local;
- listener TCP en `127.0.0.1:22000`;
- sin listeners públicos de Syncthing;
- `vault-main` registrada como carpeta local;
- `.stignore` mínimo conservador materializado;
- backup manual del vault validado con restore de prueba;
- sin dispositivos remotos ni pairing.

Siguen `pendiente de verificación en host`:

- pairing y onboarding real con clientes.

### Escritura del agente
OpenClaw no escribirá libremente sobre todo el vault.
Las zonas iniciales de escritura permitida serán controladas, por ejemplo:

- `Agent/Inbox_Agent/`
- `Agent/Drafts_Agent/`
- `Agent/Reports_Agent/`
- `Agent/Heartbeat/`

La promoción a notas núcleo del usuario requerirá HITL.
La lectura y escritura efectivas fuera de estas zonas quedan `pendiente de verificación en host` hasta definición operativa posterior de esa superficie.
La convención canónica de carpetas se detalla en `docs/vault/CONVENCION_DE_CARPETAS_Y_ZONAS.md`.

## Estado de partida real

No partimos desde cero:

- el boundary OpenClaw ya existe en DAVLOS;
- hay baseline real confirmada;
- helper readonly y broker core están validados;
- `egress/allowlist` ya queda cerrado técnicamente en Sprint 2;
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
**Estado:** cerrado

Objetivo:
- cerrar el principal gap rojo del boundary,
- aplicar o dejar listo un deny-by-default real para `agents_net`,
- mantener cambios pequeños y reversibles.

No incluye:
- instalación de Syncthing,
- activación del vault canónico,
- integración operativa de Obsidian.

Resultado real ejecutado:
- `egress/allowlist` queda `VERDE`;
- allow efectivo a `172.22.0.1:11440/tcp`;
- bloqueo efectivo probado de `1.1.1.1:443/tcp`;
- el juicio cronológico adoptado es de validación/reaplicación idempotente en la última ventana revisada.

### Sprint 3 — Vault canónico en VPS + Syncthing + política de ownership
**Estado:** cerrable por checklist y evidencia

Objetivo:
- fijar arquitectura del vault;
- consolidar el layout del conocimiento;
- cerrar política de conflictos, exclusiones y backups;
- congelar la baseline host-side mínima ya validada de Syncthing y del vault;
- dejar definidos los flujos futuros de cliente sin activarlos.

Alcance de Sprint 3 en este repositorio:

- ADRs;
- runbooks;
- convenciones documentales;
- criterios de ownership, conflictos, exclusiones y backups;
- postura por plataforma para escritorio, Android e iPhone/iPad;
- cierre documental del baseline host-side mínimo validado.

Fuera de alcance por defecto:

- pairing con clientes;
- onboarding real de clientes;
- apertura pública de GUI o puertos;
- integración operativa OpenClaw ↔ Vault.

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
