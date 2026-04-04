# GAP_ANALYSIS_SPRINT_1.md

## Propósito

Traducir la auditoría host-side readonly del boundary OpenClaw a una matriz de gaps, una priorización MoSCoW realista y un baseline documental utilizable para el resto del Sprint 1.

## Matriz de gaps

| Área | Estado actual | Evidencia | Gap real | Riesgo | Prioridad MoSCoW | Acción recomendada | Requiere verificación en host |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Runtime host-side | Verde: materializado y estable a nivel estructural | Runtime real en `/opt/automation/agents/openclaw`, árbol y artefactos confirmados | Falta elevar este estado a baseline oficial del proyecto para evitar drift futuro | Medio | MUST | Tratar el runtime actual como baseline confirmada y zona no tocable salvo plan explícito | No |
| Secretos | Verde en existencia; ámbar en contrato final | `/etc/davlos/secrets/openclaw` existe y contiene `telegram-bot.env` | La documentación histórica de “ruta reservada” ya no describe el estado actual; falta criterio documental de lifecycle y alcance | Medio | SHOULD | Corregir baseline documental y dejar política futura de secretos como `pendiente de verificación en host` | No |
| Docker network / aislamiento | Verde en topología; ámbar en egress final | `agents_net` confirmada y separada de `verity_network`; `DOCKER-ISOLATION` visible para bridges | La separación visible está confirmada, pero la allowlist/egress final sigue abierta | Alto | MUST | Mantener el aislamiento como baseline y separar explícitamente el gap restante: no existe allowlist real de egress | No |
| Bind local del gateway | Verde | `127.0.0.1:18789` confirmado por `ss` y `docker inspect` | La semántica de health/readiness de `18789` está mal interpretada en parte de la documentación | Medio | SHOULD | Corregir documentación para distinguir TCP healthcheck de readiness HTTP | No |
| inference-gateway | Verde | `inference-gateway.service` activa; `/healthz` correcto; upstream a Ollama local | Falta consolidar este contrato como dependencia obligatoria del boundary en la documentación del proyecto | Medio | SHOULD | Fijar el gateway como componente baseline del boundary y dejar fuera de alcance cambios de upstream en Sprint 1 | No |
| Broker restringido | Verde en el core; ámbar residual si se exigiera un canal no-Telegram autenticado | Policy runtime viva, state store con override real, auditoría viva, helper readonly operativo y una ejecución real de `action.health.general.v1` con evidencia before/after | El gap funcional del broker core queda cerrado; solo queda `pendiente de verificación en host` si se quisiera declarar operativo un canal alternativo autenticado fuera de Telegram | Medio | SHOULD | Tratar el broker core como baseline verde y no asumir un canal HTTP/auth alternativo mientras no se verifique en host | No |
| Telegram persistente | Ámbar | Servicio activo, secreto presente, state reciente; warnings de polling visibles | Hay materialización real, pero no salud funcional estable confirmada | Alto | SHOULD | Tratar Telegram como activo pero degradable; revisar warnings en fase de verificación funcional controlada | Sí |
| Helper readonly | Verde: validado readonly | Script, sudoers, interfaz y subcomandos confirmados; ejecución correcta directa y por `devops -> sudo` para `runtime_summary` | El gap principal queda cerrado; solo queda mantener disciplina de uso y tratar la salida como metadato operativo interno | Bajo | SHOULD | Usarlo como vía preferente de observabilidad controlada y revalidarlo si cambia el artefacto | No |
| Hardening de contenedor | Verde base; ámbar en cierre final | `cap_drop: ALL`, `no-new-privileges`, mounts `ro/rw`, sin bind público | `ReadonlyRootfs=false` y healthcheck TCP siguen como deuda técnica o decisión aún no cerrada | Medio | SHOULD | Mantener baseline actual y abrir gap explícito para endurecimiento posterior, sin cambiar runtime en este sprint | No |
| Egress / allowlist | Rojo auditado: no existe cierre real ni `deny-by-default` efectivo | `UFW` activo con reglas puntuales a `11434/11440`, pero `DOCKER-USER` vacía, `DOCKER-FORWARD` permisiva y `MASQUERADE` para `172.22.0.0/16` | La postura efectiva permite afirmar que la allowlist real no está aplicada todavía | Alto | MUST | Mantener el gap como rojo ya caracterizado, no declararlo cerrado y diferir el hardening real a Sprint 2 | No |
| Coherencia documental | Rojo | `control-plane/README.md` y host alinean checkpoint avanzado, pero `control-plane/docs/AGENTS.md` contradice broker y Telegram | Riesgo de tomar decisiones con una fuente canónica equivocada | Alto | MUST | Fijar precedencia documental y dejar nota formal de coherencia/desalineación | No |
| Integración inicial con Obsidian | Ámbar en diseño; rojo si se implementa prematuramente | El proyecto la plantea, pero no existe policy cerrada de ownership ni sync | Riesgo alto de corrupción o sobreescritura si se activa demasiado pronto | Alto | MUST | Definir postura inicial de vault, ownership y zonas de escritura antes de cualquier automatización | No |

## Cierre y transferencia a Sprint 2

### MUST

- cerrar formalmente Sprint 1 sin falsear el estado real;
- mantener la precedencia documental oficial ya fijada;
- dejar el baseline del boundary como verde confirmado para runtime, red, bind e inference-gateway;
- fijar la postura inicial de vault/ownership de escritura del agente;
- transferir `egress/allowlist` a Sprint 2 como gap principal.

### SHOULD

- Revisar la salud funcional real de Telegram a partir de los warnings observados.
- seguir corrigiendo la semántica documental de health/readiness donde todavía sea ambigua;
- dejar visible la limpieza recomendada pendiente en `davlos-control-plane`;
- mantener el contrato final de secretos como deuda menor no bloqueante.

### COULD

- Preparar plantillas de evidencia, sprint y runbook para futuras verificaciones.
- preparar un flujo prudente de promoción desde borradores del agente a notas estables con HITL.

### WON'T

- Sync bidireccional con Obsidian en este sprint.
- Hardening invasivo del runtime sin backup, rollback y validación previa.
- Cambios de red, systemd, Docker o secretos desde el repo de proyecto.
- Cualquier ampliación de superficie operativa del boundary.

## Baseline de Sprint 1 tras auditoría

### Verde

- runtime host-side;
- red `agents_net` y aislamiento visible frente a `verity_network`;
- bind local `127.0.0.1:18789`;
- `inference-gateway.service`;
- hardening base del contenedor;
- helper readonly validado;
- broker core readonly con prueba funcional trazable.

### Ámbar

- Telegram persistente;
- contrato final de secretos;
- definición detallada de health/readiness.

### Rojo

- cierre real de egress/allowlist: auditado y todavía no aplicado;
- coherencia documental global entre fuentes de `control-plane`;
- política final de integración con Obsidian si se pretendiera ejecutar ya.

## Gaps cerrados en Sprint 1

- baseline real del boundary y precedencia documental;
- helper readonly como canal verde de observabilidad;
- broker core readonly con prueba funcional trazable;
- auditoría específica de `egress/allowlist`;
- postura inicial prudente de vault/Obsidian.

## Gaps abiertos y transferidos a Sprint 2

- hardening real de `egress/allowlist`;
- revisión funcional de Telegram;
- limpieza documental adicional recomendada en `davlos-control-plane`;
- contrato final de health/readiness y secretos;
- cualquier canal no-Telegram autenticado del broker, si se quisiera declararlo operativo.

## Riesgo aceptado temporalmente

- Telegram puede permanecer en `ÁMBAR` porque está materializado, pero no se declara sano de forma plena sin más validación.
- `egress/allowlist` puede permanecer en `ROJO` al cierre de Sprint 1 porque este sprint era de auditoría y gobierno, no de cambio host-side.
- Obsidian puede quedarse en modo diseño prudente porque activar integración real sin ownership, HITL y rollback introduciría más riesgo que valor.

## Único siguiente cambio mínimo y reversible recomendado

Abrir Sprint 2 con un cambio pequeño y reversible orientado a convertir `agents_net` en `deny-by-default` efectivo, permitiendo solo los destinos aprobados que la evidencia confirme como necesarios.

Justificación:

- el broker core ya ha quedado verificado funcionalmente;
- la allowlist real de egress ya no es una incógnita, sino un gap host-side caracterizado;
- el mayor valor técnico siguiente ya no es seguir auditando, sino preparar el primer endurecimiento reversible del boundary.
