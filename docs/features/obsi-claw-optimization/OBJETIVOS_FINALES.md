# OBJETIVOS_FINALES — Feature de optimización de Obsi-Claw

## Propósito

Esta feature tiene como objetivo convertir el baseline prudente ya validado de OpenClaw en una base más útil, mantenible y preparada para la siguiente evolución de Obsi-Claw, sin romper el boundary actual ni mezclar cambios inseguros en `main`.

## Contexto de partida

El proyecto parte de un estado ya validado:

- el boundary OpenClaw ya puede tratarse como **baseline prudente validado**;
- la fuente de verdad operativa del host es `davlos-control-plane`;
- `obsi-claw-AI_agent` sigue siendo la fuente de verdad de producto, arquitectura, roadmap, prompts y diseño vivo;
- no se parte desde cero;
- no debe rehacerse la arquitectura ya validada;
- no deben introducirse cambios host-side sin validación específica.

## Objetivo general de la feature

Definir, documentar y preparar de forma profesional la siguiente fase de optimización de Obsi-Claw para que pueda ejecutarse de forma incremental, segura, reversible y trazable.

## Objetivos finales

### 1. Alinear producto y operación

- reflejar correctamente en el repo de producto que OpenClaw ya dispone de baseline prudente validado;
- reducir drift entre documentación de producto y realidad operativa ya validada;
- mantener la separación clara entre repo de producto y repo operativo.

### 2. Definir la siguiente fase de optimización

- concretar qué significa “optimizar Obsi-Claw” en esta nueva fase;
- separar mejoras reales de boundary, mejoras de observabilidad y mejoras de integración con vault;
- priorizar MVP antes que complejidad.

### 3. Preparar entregables reutilizables

- objetivos de sprint claros;
- criterios de done verificables;
- riesgos explícitos;
- prompts reutilizables para Codex CLI;
- runbooks o checklists si hicieran falta;
- documentación suficiente para continuar el trabajo en nuevos chats o nuevas ramas.

### 4. Mantener el modelo de seguridad

- no ampliar superficie sin justificación;
- no debilitar helper readonly, sudoers, ownership ni límites del boundary;
- no introducir nuevas promesas de seguridad sin evidencia;
- mantener cambios pequeños y reversibles.

### 5. Preparar la ejecución futura

- dejar identificado qué puede hacerse solo en repo;
- dejar identificado qué requerirá validación host-side posterior;
- dejar clara la secuencia lógica de implementación.

## Alcance de esta feature

Incluye:

- documentación de producto;
- definición de objetivos y backlog técnico;
- preparación de prompts para Codex;
- alineación documental con el baseline validado;
- diseño del siguiente tramo de optimización.

## No alcance

No incluye todavía:

- cambios host-side;
- despliegues;
- cambios directos en runtime;
- cambios reales de permisos;
- cambios reales en Syncthing;
- cambios reales del vault;
- nuevas capacidades no validadas en host.

## Criterio de éxito

La feature se considerará bien encaminada cuando existan:

- objetivos finales claros y cerrados;
- una hoja de ruta pequeña y ejecutable;
- criterios de done por bloque;
- riesgos y dependencias identificados;
- prompts listos para que Codex implemente el siguiente tramo sin improvisación;
- documentación coherente con el baseline validado.

## Riesgos principales

- confundir baseline validado con sistema totalmente cerrado;
- abrir nuevas líneas de trabajo sin acotar alcance;
- mezclar documentación de producto con detalles operativos que pertenecen a `davlos-control-plane`;
- intentar ejecutar cambios host-side sin preparación específica.

## Siguiente paso lógico

A partir de este documento, preparar:

1. un `AGENTS.md` específico para esta feature;
2. un documento de sprint o backlog mínimo;
3. prompts de implementación para Codex CLI.
