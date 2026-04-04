# PRUEBA_FUNCIONAL_READONLY_BROKER_SPRINT_1.md

## Resumen ejecutivo

Se ejecutó una única prueba funcional readonly del broker restringido fuera de Telegram y sin mutaciones operativas. La prueba usó el core real `RestrictedOperatorBroker.execute()` con la policy runtime activa y la acción `action.health.general.v1`, elegida por no aceptar parámetros y limitarse a `GET` locales definidos por policy.

El resultado permite cerrar el gap funcional del broker core y elevar su clasificación a `VERDE`. La evidencia before/after muestra estado efectivo estable y un único evento nuevo de auditoría coherente con la ejecución esperada.

## Camino de ejecución evaluado

### CANDIDATO SEGURO

- Invocación directa del core `RestrictedOperatorBroker.execute(BrokerRequest(...))` desde `scripts/agents/openclaw/restricted_operator/`.
- Justificación:
  - Telegram está excluido por esta tarea.
  - `server.py` documenta un endpoint HTTP local, pero no hay listener activo en `127.0.0.1:18890`.
  - `cli.py` no expone un subcomando `execute`.
  - `telegram_bot.py` llama internamente a `self.broker.execute(...)`, así que este es el camino real del core del broker.

### AMBIGUO

- `POST /v1/actions/execute` en `server.py`.
- Motivo:
  - existe en código y en documentación;
  - no está escuchando en este host;
  - además, el server mostrado no añade una capa explícita de auth del operador antes de `broker.execute(...)`.

### DESCARTADO

- Telegram `/execute ...`
- Motivo: prohibido por esta tarea.

- Acciones `restricted`
- Motivo: fuera de alcance por riesgo de mutación.

- `action.logs.read.v1`
- Motivo: es readonly, pero requiere parámetros (`stream_id`, opcional `tail_lines`) y expone una superficie mayor de salida; se descartó en favor de una acción sin payload.

## Acción readonly elegida

- `action_id`: `action.health.general.v1`
- Razones:
  - está marcada como `readonly`;
  - no acepta parámetros;
  - la implementación solo realiza `GET` HTTP a checks fijos declarados en la policy runtime;
  - en runtime, esos checks son:
    - `http://127.0.0.1:18789/`
    - `http://127.0.0.1:11440/healthz`
  - la única escritura esperable es la auditoría normal del broker.

## Pre-checks

- `broker_state_console` before:
  - `summary total=5 enabled=3 disabled=1 expired=1 consumed=0`
  - `action.health.general.v1` sigue `enabled`
  - `action.logs.read.v1` sigue `enabled`

- `broker_audit_recent` before:
  - no había eventos previos con `action_id=action.health.general.v1` en la cola reciente mostrada por el helper.

- Verificación del camino:
  - `server.py` existe pero no hay listener activo en `18890`.
  - `telegram_bot.py` ejecuta `self.broker.execute(BrokerRequest(...))`.
  - `actions.py` confirma que `HealthAction.execute()` rechaza params y solo usa `urllib.request` con `GET`.

## Resultado de la ejecución

- Se ejecutó exactamente una única acción funcional real.
- Comando:

```bash
timeout 5s python3 -c 'import json; from broker import RestrictedOperatorBroker; from models import BrokerRequest; policy="/opt/automation/agents/openclaw/broker/restricted_operator_policy.json"; result=RestrictedOperatorBroker(policy).execute(BrokerRequest(action_id="action.health.general.v1", params={}, actor="sprint1_readonly_probe")); print(json.dumps(result.to_dict(), sort_keys=True))'
```

- Exit code: `0`
- Resultado resumido:
  - `ok=true`
  - `event=action_executed`
  - `action_id=action.health.general.v1`
  - checks:
    - `openclaw_ui` -> `200`
    - `inference_gateway_healthz` -> `200`

## Evidencia before/after

### Before

- estado efectivo:
  - `summary total=5 enabled=3 disabled=1 expired=1 consumed=0`
- auditoría reciente:
  - solo eventos previos de Telegram en la cola visible

### After

- estado efectivo:
  - `summary total=5 enabled=3 disabled=1 expired=1 consumed=0`
  - sin cambios en acciones habilitadas, expiradas o consumidas

- auditoría reciente:
  - aparece un nuevo evento:
    - `ts=2026-04-03T20:10:16.058581+00:00`
    - `event=action_executed`
    - `action_id=action.health.general.v1`
    - `ok=True`

## Clasificación final del broker

`VERDE`

## Riesgos o límites observados

- La prueba valida el core real del broker, no un canal autenticado alternativo fuera de Telegram.
- `server.py` existe como diseño, pero no se observó desplegado en escucha local durante esta auditoría.
- La autorización de operador es una capa de canal; en el camino de Telegram sí existe, pero no se ha validado aquí para un canal no-Telegram.
- Si en el futuro se quisiera declarar verde un canal HTTP local autenticado del broker, eso sigue `pendiente de verificación en host`.

## Decisión recomendada del sprint

Cerrar el gap funcional del broker core como resuelto y mover el foco al siguiente riesgo rojo/alto del Sprint 1: auditoría readonly de egress/allowlist del boundary OpenClaw.
