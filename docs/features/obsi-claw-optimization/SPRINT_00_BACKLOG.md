# SPRINT_00_BACKLOG — Feature `obsi-claw-optimization`

## Propósito del sprint

Preparar la siguiente fase de optimización de Obsi-Claw con un sprint documental, pequeño y ejecutable, que reduzca drift, aclare límites y deje lista la secuencia de trabajo sin tocar host, sin tocar runtime y sin inventar validaciones host-side.

## Objetivo general

Convertir el baseline prudente ya validado de OpenClaw en un punto de partida operativo y documental más claro para el siguiente tramo, dejando definidos:

- qué hay que alinear en el repo de producto;
- qué significa realmente "optimizar" en esta fase;
- qué puede avanzarse solo en repo;
- qué queda `pendiente de validación o ejecución host-side`;
- qué prompts mínimos necesita Codex para ejecutar el trabajo sin improvisación.

## Bloques de trabajo

### Bloque 1 — Alineación del baseline y precedencia documental

**Objetivo**

Corregir drift documental de alto impacto para que `obsi-claw-AI_agent` refleje de forma consistente que OpenClaw parte ya de un baseline prudente validado, manteniendo a `davlos-control-plane` como fuente de verdad operativa.

**Alcance**

- revisar documentación viva de alto impacto;
- corregir mensajes que sigan tratando OpenClaw como boundary incierto;
- dejar explícita la precedencia entre repo de producto y repo operativo;
- registrar drift residual aceptado cuando no compense corregirlo todavía.

**No alcance**

- reescritura completa de cierres históricos;
- duplicación de evidencia host-side;
- cambios en scripts, runtime, systemd o despliegues.

**Entregables**

- ajustes documentales mínimos en documentos vivos de alto impacto;
- nota explícita de precedencia documental;
- lista corta de drift residual aceptado.

**Criterio de done**

- no quedan contradicciones relevantes en documentación viva sobre el punto de partida actual;
- el baseline prudente validado queda reflejado sin sobrerrepresentarlo;
- ninguna afirmación operativa depende de estado host-side inventado.

**Riesgos**

- presentar la baseline como si todo el sistema estuviera cerrado;
- mezclar documentación de producto con detalles que deben permanecer en `davlos-control-plane`.

**Dependencia con `davlos-control-plane`**

Alta.
La validación del baseline y la verdad operativa se toman de ese repo, pero sin copiar evidencia sensible ni simular comprobaciones host-side.

### Bloque 2 — Matriz de dominios de optimización

**Objetivo**

Traducir "optimizar Obsi-Claw" a un conjunto pequeño de dominios concretos y acotados para evitar que la feature se convierta en un paraguas ambiguo.

**Alcance**

- separar, como mínimo, optimización de boundary, observabilidad controlada, estabilidad Telegram, integración prudente con vault e higiene documental;
- describir para cada dominio su valor esperado, límites y dependencias;
- clasificar cada dominio como `repo-only`, mixto o `pendiente de validación o ejecución host-side`.

**No alcance**

- rediseño de arquitectura;
- nuevas features amplias de runtime;
- promesas de hardening o despliegues no verificados.

**Entregables**

- matriz de dominios de optimización;
- definición corta de cada dominio;
- frontera explícita entre lo que entra ahora y lo que no entra todavía.

**Criterio de done**

- el término "optimización" deja de ser ambiguo;
- cada dominio tiene frontera clara;
- se evita mezclar seguridad, observabilidad y vault en un único bloque difuso.

**Riesgos**

- abrir demasiadas líneas en paralelo;
- etiquetar como optimización lo que en realidad sería un cambio host-side grande.

**Dependencia con `davlos-control-plane`**

Media.
La clasificación debe respetar la realidad operativa ya validada, aunque el trabajo siga siendo documental.

### Bloque 3 — Mapa repo-only vs host-side y gates de verificación

**Objetivo**

Dejar una separación verificable entre trabajo resoluble solo en repo y trabajo que requerirá contraste posterior con host o con `davlos-control-plane`.

**Alcance**

- identificar afirmaciones y tareas que necesitan evidencia host-side;
- definir gates mínimos de verificación antes de cualquier paso operativo futuro;
- registrar qué repo es fuente de verdad para cada tipo de cambio.

**No alcance**

- ejecutar comandos contra host;
- generar evidencia nueva;
- redactar como cerradas validaciones que no se hayan ejecutado.

**Entregables**

- matriz `repo-only` vs `host-side`;
- listado de gates o checkpoints previos a cambios futuros;
- catálogo breve de afirmaciones que no deben hacerse sin evidencia nueva.

**Criterio de done**

- cada tarea futura queda etiquetada como repo-only o dependiente de host;
- los pasos host-side futuros quedan bloqueados por un gate explícito;
- no quedan zonas grises sobre qué puede afirmarse desde este repo.

**Riesgos**

- pseudo-validar trabajo operativo desde documentación;
- dejar dependencias host-side implícitas o mal clasificadas.

**Dependencia con `davlos-control-plane`**

Alta.
Los gates deben remitir al repo operativo como checkpoint, no sustituirlo.

### Bloque 4 — Checklist mínima de preparación operativa futura

**Objetivo**

Preparar, solo a nivel documental, la secuencia mínima de prechecks y condiciones de entrada para el siguiente tramo operativo, sin ejecutarlo.

**Alcance**

- ordenar prechecks, condiciones de entrada, stop conditions y rollback esperado a nivel documental;
- marcar qué componentes no deben tocarse sin validación adicional;
- dejar explícita la secuencia prudente para futuras intervenciones pequeñas.

**No alcance**

- despliegues;
- edición de helper, sudoers, servicios o runtime;
- creación de comandos host-side no sustentados por documentación existente.

**Entregables**

- checklist mínima de preparación operativa;
- lista de precondiciones y stop conditions;
- nota breve de rollback esperado a nivel documental.

**Criterio de done**

- la secuencia futura se entiende sin improvisación;
- ningún paso host-side aparece como ejecutado;
- queda claro qué no debe tocarse sin nueva verificación.

**Riesgos**

- deslizar un plan de despliegue dentro de una pieza documental;
- convertir una checklist de preparación en una promesa de ejecución.

**Dependencia con `davlos-control-plane`**

Alta.
Las precondiciones y checkpoints deben remitir al repo operativo antes de cualquier acción real.

### Bloque 5 — Pack de prompts Codex por bloque

**Objetivo**

Dejar prompts listos para usar con Codex CLI, uno por bloque, con alcance pequeño, restricciones explícitas y formato de salida auditable.

**Alcance**

- redactar un prompt por bloque del backlog;
- exigir siempre salida estructurada;
- dejar claro si el trabajo es solo repo o depende de verificación host-side;
- limitar cada prompt a cambios pequeños y revisables.

**No alcance**

- prompts genéricos;
- prompts que mezclen varios dominios en una sola ejecución;
- prompts que presupongan estado del host o despliegues ya realizados.

**Entregables**

- `PROMPTS_CODEX.md` con un prompt reutilizable por bloque;
- instrucciones explícitas de límites y formato de respuesta.

**Criterio de done**

- cada prompt se puede copiar y pegar en Codex CLI;
- cada prompt prohíbe inventar estado del host;
- cada prompt acota el diff y el área de trabajo.

**Riesgos**

- producir prompts vagos o demasiado amplios;
- inducir cambios grandes o difíciles de auditar.

**Dependencia con `davlos-control-plane`**

Indirecta.
Los prompts deben remitir al repo operativo cuando el trabajo dependa de host-side, sin simular que ese contraste ya ocurrió.

## Propuesta de secuencia de ejecución

1. **Bloque 1 — Alineación del baseline y precedencia documental**
2. **Bloque 2 — Matriz de dominios de optimización**
3. **Bloque 3 — Mapa repo-only vs host-side y gates de verificación**
4. **Bloque 4 — Checklist mínima de preparación operativa futura**
5. **Bloque 5 — Pack de prompts Codex por bloque**

## Nota de control

Este sprint no despliega, no modifica `main`, no toca scripts ni runtime y no pretende sustituir la verdad operativa de `davlos-control-plane`.
Su valor es dejar una base documental ejecutable para el siguiente tramo de optimización.
