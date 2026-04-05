# SPRINT_2_CIERRE.md

## Resumen ejecutivo

Sprint 2 queda cerrado formalmente como sprint de hardening real de `egress/allowlist` del boundary OpenClaw.

El gap técnico de `egress/allowlist` queda `VERDE` con evidencia funcional suficiente. El cierre debe redactarse de forma honesta: la última ventana revisada no puede presentarse como la primera activación demostrable del hardening, porque antes de ese `apply` ya aparecían reglas activas compatibles con la política final.

## Objetivo real del Sprint 2

Cerrar el principal gap rojo heredado de Sprint 1:

- materializar o validar una allowlist real para `agents_net`;
- imponer `deny-by-default` efectivo con cambio pequeño, reversible y verificable;
- mantener el boundary operativo;
- mantener fuera de alcance operativo a `vault canónico + Syncthing + Obsidian`.

## Qué se ha confirmado realmente

- el script `scripts/hardening/openclaw_egress_allowlist.sh` queda operativo para este cambio;
- el script ya pasa `plan`, `apply` y `verify`;
- `DOCKER-USER` contiene el salto `-s 172.22.0.0/16 -j OPENCLAW-EGRESS`;
- `OPENCLAW-EGRESS` contiene:
  - `ESTABLISHED,RELATED`;
  - allow explícito a `172.22.0.1:11440/tcp`;
  - `DROP` final;
- `11434/tcp` queda fuera del baseline permitido por defecto;
- `openclaw-gateway` mantiene reachability efectiva a `172.22.0.1:11440/tcp`;
- una prueba negativa controlada confirma bloqueo efectivo de `1.1.1.1:443/tcp`;
- la última ventana de validación terminó sin rollback;
- el gap técnico de `egress/allowlist` puede clasificarse `VERDE`.

## Evidencia funcional suficiente

La evidencia funcional mínima que soporta el cierre es:

- `iptables -S DOCKER-USER` muestra el salto hacia `OPENCLAW-EGRESS`;
- `iptables -S OPENCLAW-EGRESS` muestra `ESTABLISHED,RELATED`, allow a `172.22.0.1:11440/tcp` y `DROP`;
- la prueba positiva desde `openclaw-gateway` a `172.22.0.1:11440` devuelve `ALLOW_OK`;
- la prueba negativa desde `openclaw-gateway` a `1.1.1.1:443` devuelve `BLOCK_OK ... TIMEOUT`;
- el script ya no falla por desalineación interna entre `populate_chain()` y `verify_rules()`.

## Discrepancia cronológica detectada

Sprint 1 dejó documentado que `DOCKER-USER` estaba vacía y que no existía una allowlist real de egress en [../evidence/AUDITORIA_EGRESS_ALLOWLIST_SPRINT_1.md](../evidence/AUDITORIA_EGRESS_ALLOWLIST_SPRINT_1.md).

Durante Sprint 2 apareció una discrepancia importante: antes del último `apply` revisado ya existían reglas activas compatibles con la política final. La trazabilidad host-side más útil quedó en `/var/backups/openclaw-egress/`:

- `20260405T112939Z_iptables.save`: `DOCKER-USER` sin `OPENCLAW-EGRESS`;
- `20260405T113005Z_iptables.save`: `DOCKER-USER -> OPENCLAW-EGRESS` ya activo;
- `20260405T113506Z_iptables.save`: estado otra vez sin la cadena activa;
- `20260405T141331Z_iptables.save`: `OPENCLAW-EGRESS` ya activa antes de la última reaplicación validada.

Como `create_backup()` corre antes de `populate_chain()`, el snapshot `20260405T141331Z` prueba que la última ventana no fue, al menos de forma demostrable, la primera activación del hardening.

## Juicio técnico adoptado

El juicio más fiel para cerrar Sprint 2 es este:

- el gap técnico de `egress/allowlist` queda cerrado en Sprint 2;
- la última ventana revisada validó y reaplicó de forma idempotente un hardening que ya aparecía activo antes de ese `apply`;
- no queda soportado afirmar que esa última ventana fuese la primera activación efectiva del hardening.

## Qué NO se hizo a propósito

- no se tocó Syncthing;
- no se activó el vault canónico;
- no se mezcló este sprint con implementación operativa de Obsidian;
- no se amplió la allowlist más allá de `172.22.0.1:11440/tcp`;
- no se reabrió `11434/tcp` por defecto;
- no se modificó `davlos-control-plane` en este cierre documental.

## Qué queda abierto tras cerrar Sprint 2

- Telegram persistente sigue `ÁMBAR`;
- la coherencia documental entre este repo y `davlos-control-plane` sigue requiriendo limpieza posterior;
- si alguna vez se quisiera reautorizar `11434/tcp` directo, eso debe reabrirse solo con evidencia host-side nueva;
- la arquitectura `vault canónico + Syncthing + ownership` sigue diferida a Sprint 3.

## Criterio de cierre del Sprint 2

Sprint 2 puede cerrarse porque:

- el gap rojo principal heredado de Sprint 1 ya no depende solo de intención documental;
- la política efectiva observada ya restringe egress de `agents_net` a la ruta aprobada y bloquea el resto probado;
- el boundary sigue operativo sobre `172.22.0.1:11440/tcp`;
- la cronología se deja explícita sin inventar una primera activación no demostrable;
- la documentación separa el hardening actual del trabajo futuro sobre vault, Syncthing y Obsidian.

## Siguiente paso lógico: Sprint 3

Abrir Sprint 3 con foco en `vault canónico + Syncthing + política de ownership`, manteniendo separado:

- el boundary OpenClaw ya endurecido en egress;
- la integración futura del vault;
- la alineación posterior local ↔ GitHub como actividad de publicación, no como cambio de infraestructura.
