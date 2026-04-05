# SPRINT_2_BORRADOR.md

## Título
Sprint 2 — Hardening real de egress / allowlist del boundary OpenClaw

## Propósito

Cerrar el principal gap rojo heredado de Sprint 1:

- ausencia de allowlist real de salida;
- ausencia de deny-by-default efectivo para `agents_net`.

## Contexto consolidado

- Sprint 1 ya está cerrado.
- El boundary OpenClaw ya existe como baseline real.
- La nueva decisión de arquitectura del proyecto fija:
  - vault canónico en VPS;
  - Syncthing como solución prevista de sincronización;
  - OpenClaw separado del vault.

## Objetivo principal

Diseñar y, si la evidencia y la ventana operativa lo permiten, dejar listo o ejecutar un endurecimiento pequeño, reversible y seguro de `egress/allowlist` para `agents_net`.

## Lo que este sprint NO debe hacer

- no instalar Syncthing;
- no crear todavía el vault canónico;
- no mezclar la allowlist del boundary con la sincronización futura del vault;
- no abrir puertos o superficie adicional para móvil/escritorio;
- no activar integración operativa de Obsidian.

## MUST

- auditar la salida real del boundary;
- inventariar destinos necesarios;
- diseñar deny-by-default;
- definir backup, rollback y validación;
- ejecutar solo cambios pequeños, auditables y reversibles.

## SHOULD

- revisar Telegram persistente;
- consolidar health/readiness;
- anotar requisitos futuros que Syncthing impondrá, sin activarlos.

## Entregables

- plan de cambio de egress;
- evidencia pre y post;
- runbook;
- cierre formal del sprint;
- resumen de relevo.

## Criterio de cierre

Sprint 2 se considerará correctamente cerrado si:

- el gap de egress queda reducido materialmente o cerrado;
- el boundary sigue operativo;
- la nueva arquitectura de vault + Syncthing no introduce ruido en este sprint;
- la documentación separa claramente hardening actual y sincronización futura.
