# RESUMEN_SPRINT_2.md

## Dónde estamos

Sprint 2 queda cerrado como sprint de hardening real de `egress/allowlist` del boundary OpenClaw.

El gap principal heredado de Sprint 1 queda `VERDE` con evidencia funcional suficiente. La redacción adoptada evita falsear la cronología: la última ventana revisada no se presenta como primera activación demostrable del hardening, sino como validación y reaplicación idempotente de un estado que ya aparecía activo antes del `apply` final.

## Qué quedó cerrado

- `scripts/hardening/openclaw_egress_allowlist.sh` ya pasa `plan`, `apply` y `verify`;
- `DOCKER-USER` salta a `OPENCLAW-EGRESS` para `172.22.0.0/16`;
- `OPENCLAW-EGRESS` permite `ESTABLISHED,RELATED` y `172.22.0.1:11440/tcp`, y termina en `DROP`;
- `openclaw-gateway` alcanza `172.22.0.1:11440/tcp`;
- `openclaw-gateway` ya no alcanza `1.1.1.1:443/tcp` en la prueba negativa controlada;
- `11434/tcp` queda fuera por defecto.

## Qué no se tocó

- Syncthing;
- vault canónico;
- integración operativa de Obsidian;
- cambios documentales o de implementación en `davlos-control-plane`.

## Qué sigue pendiente

- Telegram persistente sigue `ÁMBAR`;
- la coherencia documental entre repos sigue abierta;
- cualquier reapertura de `11434/tcp` requeriría evidencia host-side nueva;
- Sprint 3 debe centrarse en `vault canónico + Syncthing + ownership`.

## Siguiente paso recomendado

Tomar como base:

- `docs/sprints/SPRINT_2_CIERRE.md`
- `docs/ESTADO_SEMAFORICO.md`
- `docs/RIESGOS_Y_DECISIONES.md`
- `docs/architecture/ADR-001-VAULT-CANONICO-VPS-SYNCTHING.md`

La regla de continuidad cambia así:

- el hardening real de egress ya no es el gap principal;
- Sprint 3 puede abrirse sin reabrir la discusión básica de egress;
- la alineación local ↔ GitHub queda preparada, pero no ejecutada en este paso.
