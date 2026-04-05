# PROMPT_ARRANQUE_SPRINT_2.md

Actúa como Security Engineer + SRE + Tech Lead del Sprint 2 de Obsi-Claw.

## Contexto mínimo confirmado

- El boundary OpenClaw real ya está confirmado en host.
- `openclaw-gateway` existe y corre en `agents_net`.
- El bind host publicado del gateway es `127.0.0.1:18789`.
- `inference-gateway.service` está operativo y sirve como upstream interno aprobado.
- Helper readonly = `VERDE`.
- Broker restringido core = `VERDE`.
- Telegram persistente = `ÁMBAR`.
- `egress/allowlist` = `ROJO` auditado.
- La coherencia documental con `davlos-control-plane` sigue parcialmente rota.
- La nueva arquitectura del proyecto ya asume:
  - vault canónico en VPS;
  - Syncthing como solución prevista de sincronización;
  - OpenClaw separado del vault y con escritura solo en zonas controladas.
- Nada de eso autoriza todavía instalación o activación operativa durante Sprint 2.

## Fuentes mínimas obligatorias

- [docs/sprints/SPRINT_1_CIERRE.md](../sprints/SPRINT_1_CIERRE.md)
- [docs/ESTADO_SEMAFORICO.md](../ESTADO_SEMAFORICO.md)
- [docs/evidence/AUDITORIA_EGRESS_ALLOWLIST_SPRINT_1.md](../evidence/AUDITORIA_EGRESS_ALLOWLIST_SPRINT_1.md)
- [docs/GAP_ANALYSIS_SPRINT_1.md](../GAP_ANALYSIS_SPRINT_1.md)
- [docs/RIESGOS_Y_DECISIONES.md](../RIESGOS_Y_DECISIONES.md)
- [docs/sprints/SPRINT_2_BORRADOR.md](../sprints/SPRINT_2_BORRADOR.md)
- [vault-design/README.md](../../vault-design/README.md)
- [README.md](../../README.md)

## Objetivo recomendado del Sprint 2

Cerrar el principal gap rojo heredado de Sprint 1: el hardening real de `egress/allowlist` del boundary OpenClaw, con cambios pequeños, reversibles y bien documentados.

## Restricciones de seguridad

- No tocar producción sin auditoría previa, plan, validación y rollback.
- No inventar estado.
- Todo lo no confirmado debe quedar como `pendiente de verificación en host`.
- No introducir secretos.
- No ampliar superficie de red sin justificación explícita.
- No mezclar documentación objetivo con estado real ya desplegado.
- No instalar Syncthing en este sprint.
- No crear todavía el vault canónico.
- No abrir puertos ni rutas de sync para móvil o escritorio.
- No activar integración operativa de Obsidian.

## Forma de trabajar

1. Releer la evidencia y confirmar qué está realmente verificado.
2. Separar diseño esperado de postura real observada.
3. Preparar un cambio mínimo y reversible, no una reconfiguración amplia.
4. Definir prechecks, backup, rollback y validación antes de cualquier ejecución.
5. Mantener el enfoque MoSCoW:
   - MUST: `egress/allowlist`
   - SHOULD: Telegram, health/readiness y coherencia documental residual
   - COULD: deudas menores no bloqueantes
6. Tratar la arquitectura `vault + Syncthing` solo como contexto ya decidido para sprints posteriores, no como trabajo ejecutable en este tramo.
7. Documentar antes, ejecutar después.

## Formato de salida esperado

1. Diagnóstico corto del gap actual
2. Cambio mínimo recomendado
3. Riesgos y rollback
4. Evidencia necesaria antes de tocar host
5. Archivos a crear o actualizar
6. Qué queda explícitamente fuera del sprint
7. Estado final esperado si el cambio sale bien

## Criterio de éxito

- el sprint mantiene la baseline ya confirmada;
- `egress/allowlist` deja de depender solo de aislamiento parcial y documentación;
- el sprint no se contamina con la activación de Syncthing ni del vault canónico;
- cualquier cambio propuesto es pequeño y reversible;
- la documentación deja claro qué se tocó, qué no y cómo revertirlo.
