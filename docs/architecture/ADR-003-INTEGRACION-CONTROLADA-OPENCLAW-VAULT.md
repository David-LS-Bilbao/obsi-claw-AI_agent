# ADR-003 — INTEGRACION CONTROLADA OPENCLAW ↔ VAULT

## Estado

Aprobada para el incremento mínimo de `draft.write` y validada parcialmente en host en Sprint 4

## Propósito

Cerrar el contrato repo-side de `draft.write` dentro de una integración controlada OpenClaw ↔ vault, sin ampliar superficie ni asumir despliegue host-side.

## Alcance

Esta ADR fija política documental y contrato técnico repo-side para `draft.write`, y registra la validación host-side acotada de su incremento mínimo.

No demuestra:

- GO para `report.write`;
- GO para watcher;
- GO para timer;
- promoción automática;
- validación exhaustiva de `.obsidian/`.

Todo lo anterior sigue `pendiente de verificación en host`.

## Contexto

Sprint 4 ya había validado el perímetro mínimo de escritura controlada para `draft.write`.

El hueco abierto era otro:

- la unidad inyectaba `draft_title` y `draft_body`;
- el helper dependía de argumentos dinámicos;
- el staged input no era todavía la única fuente semántica del draft.

La validación host-side posterior cerró ese hueco con un staged request canónico, una unidad sin payload dinámico y un único draft nuevo por ejecución.

## Decisiones

### 1. Unico input semántico

`draft.write` toma toda la semántica desde un staged request Markdown autocontenido en:

- `Agent/Inbox_Agent/STAGED_INPUT.md`

### 2. Frontmatter estricto

El staged request debe usar frontmatter con:

- mínimos: `operation`, `schema_version`, `run_id`, `draft_title`;
- opcionales: `source_refs`, `proposed_target_path`.

El body Markdown del staged request pasa a ser `draft_body`.

### 3. Writer determinista

El helper:

- valida el path canónico;
- valida `operation: draft.write`;
- valida `schema_version: 1`;
- toma `run_id` y `draft_title` del frontmatter;
- toma el body Markdown como contenido del borrador;
- escribe create-only solo en `Agent/Drafts_Agent/`.

### 4. Unidad estable y sin payload dinámico

La unidad template no debe inyectar:

- `--draft-title`;
- `--draft-body`;
- `--run-id`;
- `--source-ref`.

La semántica queda en el staged request.

### 5. Auditoría reforzada sin volcado de payload

La auditoría mínima incluye:

- `input_sha256`;
- `output_sha256`.

La auditoría no guarda el body completo.

### 6. HITL sigue obligatorio

`proposed_target_path` no autoriza acción automática.

La promoción fuera de `Drafts_Agent` queda separada y sigue `pendiente de verificación en host`.

## Estado validado en host para esta ADR

Quedó validado en host para el incremento mínimo de `draft.write` que:

- `STAGED_INPUT.md` canónico funciona como única fuente semántica;
- el helper determinista consume el staged request sin leer más allá de ese input;
- se genera exactamente un draft nuevo en `Agent/Drafts_Agent/`;
- el staged request queda intacto;
- la auditoría host-side registra `input_sha256` y `output_sha256`;
- no aparecieron listeners nuevos;
- no hubo degradación observable de bot ni contenedor.

La verificación directa pre/post de `.obsidian/` sigue `pendiente de verificación en host`.

## Qué no autoriza esta ADR

- `report.write`;
- watcher;
- timer;
- promoción automática;
- lectura transversal del vault;
- selección dinámica de múltiples staged inputs;
- wrappers host-side no documentados.

Tampoco autoriza inferir que esta validación mínima habilita la siguiente capacidad por arrastre.

## Consecuencias

### Positivas

- menor ambigüedad operativa;
- mejor trazabilidad;
- `ExecStart` estable;
- superficie más pequeña;
- separación más clara entre staging, generación y promoción;
- cierre validado del incremento mínimo de `draft.write` sin ampliar superficie.

### Costes

- una sola ruta canónica de staged request;
- más rigidez para la operatoria futura;
- posible necesidad posterior de wrapper mínimo, que sigue `pendiente de verificación en host`;
- todavía no resuelve la siguiente capacidad.

## Pendiente de verificación en host

- permisos efectivos del writer para leer el staged request canónico;
- verificación directa pre/post de `.obsidian/`;
- conveniencia real de introducir más adelante un wrapper mínimo para `run_id`;
- cualquier validación host-side de `report.write`, watcher o timer.
