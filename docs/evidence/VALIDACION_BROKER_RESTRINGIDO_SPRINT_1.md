# VALIDACION_BROKER_RESTRINGIDO_SPRINT_1.md

## Resumen ejecutivo

El broker restringido de OpenClaw queda verificado como materializado, observable y coherente con una policy runtime real, pero no puede pasar a verde sin una prueba funcional controlada sobre su propio camino de ejecución. La evidencia pasiva confirma que no es solo branding documental: existe policy runtime distinta del template, state store con override real, audit log vivo y observabilidad estable vía helper readonly. Además, el código de `telegram_bot.py` importa y usa el broker con la misma policy runtime.

La clasificación final es `ÁMBAR FUERTE`: el broker está bien cableado y gobernando artefactos reales, pero falta una única comprobación funcional no mutante para cerrar el salto de “observable” a “ejercitado”.

## Artefactos confirmados

| Artefacto | Resultado | Evidencia |
| --- | --- | --- |
| Policy runtime | OK | `/opt/automation/agents/openclaw/broker/restricted_operator_policy.json` existe, `root:root`, `0640` |
| State store | OK | `/opt/automation/agents/openclaw/broker/state/restricted_operator_state.json` existe, `root:root`, `0600` |
| Audit log | OK | `/opt/automation/agents/openclaw/broker/audit/restricted_operator.jsonl` existe, `root:root`, `0600` |
| Template fallback | OK | `/opt/control-plane/templates/openclaw/restricted_operator_policy.json` existe y difiere del runtime |
| Policy viva no decorativa | OK parcial | runtime y fallback tienen distinto hash y el state store contiene override real |

Resumen útil:

- la policy runtime y el template no son idénticos;
- comparten el mismo set de `action_id`;
- la policy runtime activa `telegram.enabled=true`, mientras el template no lo fija del mismo modo;
- el state store contiene override al menos para `action.dropzone.write.v1`;
- la auditoría reciente contiene eventos reales ligados a `telegram.command`.

## Policy observada

### Policy runtime real

Top-level keys observadas:

- `actions`
- `broker`
- `health_checks`
- `log_streams`
- `operator_auth`
- `telegram`
- `webhook_targets`

Resumen seguro:

- `action_count=5`
- `readonly=2`
- `restricted=3`
- `enabled=true` en 4 acciones
- `enabled=false` en 1 acción
- `bind_host=127.0.0.1`
- `bind_port=18890`
- `state_store_path` y `audit_log_path` apuntan a rutas reales del runtime
- `telegram.enabled=true`
- `allowed_chats` y `allowed_users` existen, sin exponer identificadores

### Runtime vs template

Hallazgos:

- el runtime difiere del template por hash y tamaño;
- el set de acciones es el mismo;
- el runtime refleja activación/cableado de Telegram que no queda igual en el template;
- esto sugiere una policy viva de runtime, no una simple copia inerte del fallback.

### Restricción visible

Se observan señales compatibles con un modelo de `restricted operator`:

- catálogo pequeño y explícito de acciones;
- separación entre acciones `readonly` y `restricted`;
- presencia de `permission` por acción;
- acciones sensibles no habilitadas de forma abierta;
- override runtime y expiración TTL visibles en el state store/helper.

No se da por demostrado un `deny-by-default` completo sin revisar el camino de ejecución, así que ese punto queda `pendiente de verificación en host`.

## Observabilidad vía helper readonly

### `runtime_summary`

- exit code: `0`
- resultado: `OK`
- confirma que la policy fuente es `runtime`
- confirma existencia de `state`, `audit` y `telegram_runtime`

### `broker_state_console`

- exit code: `0`
- resultado: `OK`
- muestra `summary total=5 enabled=3 disabled=1 expired=1 consumed=0`
- distingue claramente acciones `readonly` y `restricted`
- expone razones coherentes con el modelo restringido:
  - `baseline_readonly`
  - `baseline_restricted`
  - `requires_dedicated_root_owned_wrapper`
  - TTL expirado en `action.dropzone.write.v1`

### `broker_audit_recent`

- exit code: `0`
- resultado: `OK`
- devuelve auditoría reciente real
- la auditoría contiene eventos de Telegram y de routing/intents
- no aparecen señales obvias de bypass, corrupción o incoherencia de formato

## Coherencia real entre policy, state y auditoría

### ¿El broker está realmente cableado al runtime?

Sí, con evidencia suficiente para afirmarlo:

- la policy runtime apunta a paths reales del runtime;
- el helper resuelve `policy_source=runtime`;
- existe state store real y audit log real en esas rutas;
- `telegram_bot.py` importa el broker y usa la misma policy runtime.

### ¿La policy observada gobierna algo real o solo existe en disco?

Gobierna algo real con suficiente evidencia pasiva:

- el state store contiene override runtime;
- el helper refleja estados efectivos distintos de la policy declarativa plana;
- la auditoría reciente contiene eventos consistentes con un flujo real.

Lo que no queda cerrado:

- no se ejercitó el camino funcional del broker con una petición real no mutante.

### ¿La auditoría parece viva y útil?

Sí:

- existe archivo persistente;
- tiene tamaño y timestamp coherentes;
- el helper extrae eventos recientes parseables y útiles.

### ¿Hay indicios de que `restricted operator` sea solo branding documental?

No.

La combinación de policy viva, state store, auditoría reciente y uso desde `telegram_bot.py` contradice esa hipótesis.

### ¿Hay algo que contradiga el claim de broker restringido?

No hay contradicción fuerte, pero sí un límite relevante:

- no se observó escucha activa en `bind_port=18890` en esta captura;
- eso impide afirmar que el modo servidor del broker esté activo como socket independiente;
- aun así, la evidencia apunta a uso embebido/integrado del broker en el runtime de Telegram y utilidades asociadas.

## Clasificación final del broker

`ÁMBAR FUERTE`

## Qué queda pendiente exactamente

Una única verificación funcional controlada sobre el camino real del broker para una acción inequívocamente readonly.

Por qué no se hace ahora:

- incluso una acción “readonly” sigue siendo ejecución funcional del broker;
- en este paso se ha impuesto no disparar acciones reales;
- hace falta acotar previamente que la acción elegida no muta estado ni amplía superficie.

Riesgo de esa futura verificación:

- bajo a medio si se limita a una acción readonly explícita;
- mayor si se mezcla con Telegram o con acciones `restricted`.

Cómo debería acotarse en un futuro prompt:

- usar una sola acción readonly explícita;
- sin Telegram como canal de entrada;
- con timeout corto;
- capturando stdout/stderr/exit code y auditoría antes/después;
- abortando si aparece cualquier indicio de mutación.

## Decisión recomendada del sprint

Mantener el broker en `ÁMBAR FUERTE` y usar el helper readonly ya validado como soporte de observabilidad.

Siguiente paso recomendado:

- diseñar y ejecutar una única prueba funcional no mutante del broker sobre una acción readonly explícita, fuera de Telegram y con trazabilidad completa.
