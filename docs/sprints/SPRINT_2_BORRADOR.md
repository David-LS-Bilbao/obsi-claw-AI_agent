# SPRINT_2_BORRADOR.md

## Estado

Borrador de arranque. No autoriza cambios por sí solo.

## Objetivo propuesto del Sprint 2

Ejecutar el hardening real y reversible de `egress/allowlist` del boundary OpenClaw, partiendo de la auditoría ya hecha en Sprint 1 y sin perder la baseline operativa confirmada.

## Alcance recomendado

- inventariar con precisión los destinos, puertos y protocolos que OpenClaw necesita realmente;
- traducir ese inventario a un diseño de `deny-by-default` con allowlist explícita;
- preparar runbook con prechecks, backup, rollback y validación;
- validar en host, con cambios mínimos y reversibles, la política efectiva de `egress/allowlist`;
- usar Telegram solo como pista secundaria de salud operativa, no como foco principal.

## Exclusiones

- sync bidireccional con Obsidian;
- reescritura de notas núcleo del usuario;
- cambios amplios en `n8n`, NPM, WireGuard, PostgreSQL o servicios ajenos;
- replatforming amplio del contenedor OpenClaw;
- incorporación de proveedores externos o credenciales nuevas sin necesidad explícita.

## Prerequisitos

- cierre documental de Sprint 1 disponible en `docs/sprints/SPRINT_1_CIERRE.md`;
- baseline semafórica disponible en `docs/ESTADO_SEMAFORICO.md`;
- evidencia host-side previa disponible y vigente;
- inventario de destinos permitidos revisado antes de tocar reglas;
- plan de rollback claro antes de cualquier cambio host-side;
- ventana operativa prudente si se llegara a actuar sobre firewall o forwarding real.

## Backlog candidato priorizado

### MUST

- fijar la matriz real de destinos permitidos para `openclaw-gateway`;
- definir la política mínima de `deny-by-default` para `agents_net`;
- preparar runbook reversible de aplicación y rollback;
- validar que la ruta aprobada a `172.22.0.1:11440` siga operativa tras el diseño propuesto;
- dejar explícito qué destinos no deben seguir accesibles.

### SHOULD

- revisar la salud funcional real de Telegram;
- consolidar contrato final de health/readiness del boundary;
- revisar si `11434` debe seguir visible para `agents_net` o solo `11440` debería quedar permitido;
- documentar cleanup recomendado pendiente en `davlos-control-plane`.

### COULD

- endurecer deuda menor del contenedor como `ReadonlyRootfs` solo si no rompe la baseline y existe rollback;
- preparar el siguiente tramo documental de integración prudente con Obsidian.

### WON'T

- automatización agresiva sobre la vault;
- sync bidireccional;
- cambios grandes no reversibles;
- ampliación prematura de superficie operativa del boundary.

## Cambio mínimo y reversible recomendado para abrir Sprint 2

Preparar un cambio host-side pequeño y reversible que convierta `agents_net` en `deny-by-default` a nivel de egress mediante una capa explícita de control en `DOCKER-USER` o equivalente, manteniendo inicialmente solo:

- tráfico `ESTABLISHED,RELATED`;
- destino aprobado `172.22.0.1:11440/tcp`;
- cualquier destino adicional solo si queda demostrado como estrictamente necesario por evidencia previa.

Este documento no autoriza ni ejecuta ese cambio. Solo fija el arranque recomendado del sprint.
