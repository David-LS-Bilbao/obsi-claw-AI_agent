# BASELINE_OPENCLAW_VALIDADO_Y_SIGUIENTE_TRAMO.md

## Propósito

Dejar constancia, a nivel de producto, de que OpenClaw ya no debe tratarse como un boundary “incierto”, sino como una **baseline prudente validada** en el repo operativo `davlos-control-plane`.

Este documento no sustituye la evidencia ni el estado operativo del VPS.
Su función es alinear el punto de partida de `obsi-claw-AI_agent` con la validación ya cerrada en el repo operativo.

## Qué significa aquí “baseline prudente validado”

Significa que el boundary actual ya cuenta con evidencia host-side suficiente para tratarse como base operativa real y defendible del proyecto, sin vender todavía:

- estabilidad perfecta;
- reconstrucción integral cerrada;
- cierre total de deuda técnica;
- expansión libre del runtime;
- integración productiva completa con el vault.

## Qué quedó realmente validado

Según la validación readonly registrada en `davlos-control-plane`:

- el runtime OpenClaw existe y está operativo en host;
- el boundary mantiene red separada y publish northbound limitado;
- el helper readonly existe, funciona y sigue una superficie cerrada;
- el broker restringido existe y su core readonly ya fue ejercitado;
- el `state` y su `.lock` quedaron observados como `root:root`, compatibles con el writer efectivo actual;
- el cableado `devops -> sudo -n helper` funciona;
- Telegram existe como servicio persistente y queda validado mínimamente para uso prudente, no como canal plenamente fiable.

## Qué no quedó validado todavía

No debe afirmarse todavía que exista:

- fiabilidad sostenida de Telegram sin warnings;
- reconstrucción reproducible completa del boundary;
- equivalencia exacta byte a byte entre repo operativo y helper ya instalado en host;
- writers no root compatibles con el modelo actual del `.lock`;
- integración OpenClaw ↔ vault más allá de los incrementos controlados ya documentados.

## Riesgos residuales no bloqueantes

- `operational_logs_recent` expone metadata operativa lateral limitada; no se observaron secretos obvios, pero no debe tratarse como salida pública.
- El modelo del `.lock` es correcto para el estado root-only actual; si apareciera un writer no root, habría que reevaluarlo.
- Persiste un drift menor repo ↔ host en el helper operativo: mejora del tail del audit log y comentarios, sin cambio de superficie ni de allowlist.

## Por qué esto cambia el punto de partida del proyecto

Hasta ahora era razonable tratar OpenClaw como un MVP host-side aún por consolidar.
Tras la validación readonly cerrada en el repo operativo, el proyecto ya no parte de una incertidumbre gruesa sobre la existencia o forma del boundary.

El cambio real es este:

- antes: auditoría + caracterización + cierre de gaps básicos;
- ahora: optimización prudente sobre una base real ya validada.

## Relación entre este repo y `davlos-control-plane`

`davlos-control-plane` sigue siendo la **fuente de verdad operativa**:

- runtime observado;
- validaciones host-side;
- checkpoints de deploy;
- reports de baseline y endurecimiento.

`obsi-claw-AI_agent` sigue siendo la **fuente de verdad de producto**:

- arquitectura funcional;
- roadmap;
- prompts;
- sprints;
- diseño de interacción con vault, Obsidian y operador.

Este repo no debe duplicar secretos, dumps ni detalles sensibles del host.

## Siguiente tramo lógico

El siguiente tramo razonable ya no es “descubrir qué hay”, sino optimizar de forma pequeña, segura y reversible la baseline OpenClaw ya validada.

Ese siguiente tramo queda preparado en:

- `docs/sprints/SPRINT_SIGUIENTE_OPTIMIZACION_OPENCLAW.md`

## Qué sigue pendiente

- intervención host-side controlada para sincronizar el helper instalado con la última revisión menor del repo operativo;
- vigilancia explícita de que no aparezcan writers no root sobre `restricted_operator_state.json` sin reabrir el análisis del `.lock`;
- mejora sostenida de observabilidad y estabilidad operativa sin abrir superficie innecesaria;
- continuidad y uso estable del sistema en más ciclos reales.
