# COHERENCIA_DOCUMENTAL_BOUNDARY.md

## Propósito

Este documento fija cómo debe leerse la documentación del boundary OpenClaw desde `obsi-claw-AI_agent` tras la validación readonly ya cerrada en `davlos-control-plane`.

La línea validada del proyecto ya permite tratar OpenClaw como **baseline prudente validado**.
Lo que queda abierto no es una negación viva de esa baseline, sino el riesgo normal de divergencia menor entre ramas, checkpoints e históricos del repo operativo, además de algunos límites residuales host-side.

## Precedencia documental vigente

Cuando haya conflicto, diferente granularidad o cronologías que no encajen del todo, debe aplicarse este orden:

1. evidencia verificable;
2. checkpoint operativo vigente de `davlos-control-plane`;
3. documentación operativa no contradicha por evidencia más reciente;
4. `obsi-claw-AI_agent` como capa de producto;
5. propuestas futuras.

## Qué puede afirmarse hoy con prudencia

- OpenClaw ya no debe tratarse como un boundary incierto o meramente hipotético.
- El boundary puede tratarse como baseline prudente validado en la línea operativa ya contrastada.
- `davlos-control-plane` sigue siendo la referencia operativa canónica.
- `obsi-claw-AI_agent` sigue siendo la capa de producto, diseño, roadmap y preparación documental.
- Telegram, helper readonly, modelo root-only del `.lock` y ausencia de writers no root compatibles deben leerse como riesgos residuales o pendientes host-side, no como negación del baseline.

## Cómo leer los históricos

- Los cierres de sprint, borradores y documentos antiguos deben leerse con contexto temporal.
- Un documento histórico puede describir un estado real de su checkpoint sin ser ya el estado vivo actual.
- Si dos checkpoints del repo operativo no dicen exactamente lo mismo, no debe sobredramatizarse como “contradicción crítica” salvo que exista evidencia nueva que invalide la línea validada.
- Cuando aparezca drift, debe formularse preferentemente como posible divergencia entre ramas, checkpoints o históricos, no como negación automática de la baseline prudente validada.

## Riesgos residuales no bloqueantes

- fiabilidad sostenida de Telegram más allá de la validación mínima actual;
- drift menor repo ↔ host en el helper operativo del repo de control-plane;
- necesidad de reevaluar el modelo del `.lock` si aparecieran writers no root;
- divergencia menor entre checkpoints o ramas del repo operativo sobre detalles no nucleares.

## Regla práctica para este repo

- no duplicar aquí detalle operativo sensible ni checkpoints enteros del host;
- usar este repo para producto, contexto, prompts y hoja de ruta;
- remitir la verdad operativa a `davlos-control-plane`;
- etiquetar toda incertidumbre relevante como `pendiente de verificación en host`;
- evitar reabrir auditorías ya cerradas salvo que exista evidencia nueva que obligue a hacerlo.
