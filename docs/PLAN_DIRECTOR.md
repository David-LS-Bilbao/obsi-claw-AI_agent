# PLAN_DIRECTOR.md

## Propósito

Definir el marco de producto y documentación viva de Obsi-Claw AI Agent como capa separada del estado operativo del VPS.

## Relación entre repositorios

- `obsi-claw-AI_agent`: producto, arquitectura, roadmap, prompts, runbooks y diseño del Second Brain.
- `davlos-control-plane`: referencia operativa del VPS DAVLOS y checkpoint documental del boundary ya desplegado.

## Regla de precedencia documental

1. Evidencia verificable del host y del runtime.
2. `davlos-control-plane` para la verdad operativa documentada.
3. `obsi-claw-AI_agent` para diseño, planificación y consolidación futura.

## Objetivo revisado del Sprint 1

Auditar y consolidar el boundary de OpenClaw ya existente, cerrar divergencias documentales y preparar la integración inicial segura con Obsidian, sin reinstalar OpenClaw desde cero ni tocar producción en este paso.

## Carriles del proyecto

- Carril operativo: contrastar documentación con el checkpoint real del VPS.
- Carril documental: sembrar estructura mínima, estado global y riesgos.
- Carril de diseño: preparar vault, prompts y runbooks sin asumir ownership de escritura todavía.

## Divergencias documentales abiertas

- `davlos-control-plane` presenta un checkpoint operativo avanzado del boundary OpenClaw.
- `obsi-claw-AI_agent` sigue en fase semilla y todavía no refleja esa madurez en su estructura.
- Cualquier implementación futura debe contrastarse contra el estado real del VPS antes de ejecutarse.

## Siguiente paso

Realizar auditoría host-side guiada por evidencia y actualizar este plan con hallazgos confirmados.
