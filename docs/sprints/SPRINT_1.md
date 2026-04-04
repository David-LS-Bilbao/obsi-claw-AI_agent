# SPRINT_1.md

## Estado del sprint

`CERRADO CON DEUDA ABIERTA`

Sprint 1 se cierra como sprint de auditoría y consolidación documental. El cierre no significa que todos los riesgos estén resueltos; significa que el baseline real ya quedó confirmado y que la deuda abierta está clasificada y transferida.

## Objetivo real del sprint

Auditar, consolidar y endurecer el boundary OpenClaw ya existente, cerrar divergencias documentales y preparar la integración inicial segura con Obsidian.

## Enfoque MoSCoW

### MUST

- workspace local separado y seguro;
- baseline documental mínimo;
- divergencias abiertas escritas;
- preparación del siguiente paso de auditoría host-side.

### SHOULD

- plantillas mínimas de estado y dirección del proyecto;
- reglas canónicas para futuros chats y prompts.
- verificación funcional controlada del helper readonly;
- revisión de salud funcional del canal Telegram;
- documentación explícita del resultado de la auditoría readonly de egress/allowlist.

### COULD

- visión inicial de la vault Obsidian sin capacidad operativa todavía.

### WON'T

- reinstalar OpenClaw;
- tocar runtime real, servicios, secretos, firewall o systemd;
- modificar `davlos-control-plane`.

## Criterios de done

- existe estructura documental mínima y coherente;
- la precedencia entre repositorios queda escrita;
- las incertidumbres quedan marcadas como `pendiente de verificación en host`;
- el siguiente paso seguro queda definido.
- existe auditoría host-side readonly suficiente para separar claims confirmados de claims históricos o dudosos.
- existe gap analysis explícito con prioridades MoSCoW y backlog corto.
- existe cierre formal del sprint con deuda transferida y arranque limpio de Sprint 2.

## Exclusiones explícitas

- cambios sobre `/opt/control-plane`;
- cambios sobre `/opt/automation/agents/openclaw`;
- cambios sobre `n8n`, `NPM`, PostgreSQL, WireGuard, UFW o secretos;
- sincronización Obsidian productiva.

## Divergencias documentales abiertas

- `davlos-control-plane` refleja un checkpoint operativo avanzado del boundary.
- `obsi-claw-AI_agent` todavía está consolidando su capa de producto y documentación viva.
- `control-plane/README.md` y la evidencia de host confirman broker y Telegram, pero `control-plane/docs/AGENTS.md` sigue tratándolos como no asumibles.
- Toda implementación posterior debe contrastarse contra el estado real del VPS.

## Estado tras auditoría y gap analysis

### Verde

- runtime;
- red y bind local;
- inference-gateway;
- hardening base del contenedor.
- helper readonly;
- broker core readonly con prueba funcional trazable.

### Ámbar

- Telegram;
- contrato final de secretos y health/readiness.

### Rojo

- cierre de egress/allowlist, ya auditado como gap abierto;
- coherencia documental global;
- cualquier integración activa con Obsidian.

## Qué pasa a Sprint 2

- hardening real de `egress/allowlist` como foco principal;
- revisión funcional de Telegram como track secundario;
- consolidación menor de health/readiness y contrato de secretos;
- limpieza documental adicional recomendada en `davlos-control-plane`.

## Qué no bloquea el cierre

- que Telegram siga en ámbar;
- que `egress/allowlist` siga en rojo si queda auditado y transferido;
- que Obsidian siga solo en diseño prudente y sin sync;
- que la limpieza documental de `control-plane` quede recomendada y no ejecutada desde este repo.

## Siguiente paso lógico

Abrir Sprint 2 con foco principal en el hardening real, pequeño y reversible, de `egress/allowlist`, manteniendo Telegram como track secundario y Obsidian en modo diseño prudente.
