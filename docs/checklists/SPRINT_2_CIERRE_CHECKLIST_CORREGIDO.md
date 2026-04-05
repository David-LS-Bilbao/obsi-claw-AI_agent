# SPRINT_2_CIERRE_CHECKLIST_CORREGIDO.md

Revisado al `2026-04-05`.

Convención usada:

- `[x]` cerrado
- `[~]` parcial o no bloqueante
- `[ ]` pendiente

## Sprint 2 — Hardening real de egress / allowlist

### Preparación

- [x] Releer documentación mínima obligatoria
- [x] Confirmar estado real actual de `agents_net`
- [x] Confirmar política actual de salida efectiva
- [x] Inventariar destinos realmente necesarios para el baseline mínimo
- [x] Separar destinos MUST / SHOULD / no permitidos
- [~] Dejar trazabilidad completa de la cronología exacta de primera activación

### Diseño técnico

- [x] Diseñar política `deny-by-default`
- [x] Diseñar allowlist mínima real
- [~] Diseñar mitigación anti-SSRF de forma implícita por reducción de superficie de egress
- [x] Definir prechecks antes de tocar host
- [x] Definir backup
- [x] Definir rollback
- [x] Definir validación post-cambio

### Ejecución controlada

- [x] Aplicar o reaplicar cambios mínimos y reversibles
- [x] Verificar reachability necesaria para OpenClaw
- [x] Verificar reachability a `inference-gateway`
- [x] Verificar que no se rompe el runtime
- [x] Documentar evidencia del cambio
- [x] Actualizar estado semafórico

### Trabajo secundario no bloqueante

- [~] Revisar Telegram persistente
- [~] Revisar health/readiness
- [~] Revisar contrato final de secretos
- [~] Limpiar deuda documental menor en `davlos-control-plane`

### Criterio de cierre técnico

- [x] `egress/allowlist` deja de estar en rojo
- [x] Existe rollback claro
- [x] El boundary sigue operativo y sin ampliar superficie innecesaria

### Cierre documental

- [x] Redactar `docs/sprints/SPRINT_2_CIERRE.md`
- [x] Redactar `RESUMEN_SPRINT_2.md`
- [x] Actualizar `ESTADO_SEMAFORICO.md`
- [x] Actualizar `RIESGOS_Y_DECISIONES.md`
- [x] Dejar documentada la discrepancia cronológica del hardening dentro de Sprint 2

### Estado real del sprint

- [x] Sprint 2 cerrado técnicamente
- [x] Sprint 2 cerrado documentalmente
- [x] Sprint 2 alineado con GitHub

## Nota de cierre

Sprint 2 queda cerrado con una precisión importante:

- el hardening real de `egress/allowlist` queda validado;
- la última ventana revisada se documenta como validación/reaplicación idempotente;
- no queda demostrado que esa misma ventana fuese la primera activación histórica del hardening.
