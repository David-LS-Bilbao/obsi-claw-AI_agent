# MATRIZ_DOMINIOS_OPTIMIZACION — Feature `obsi-claw-optimization`

## Propósito

Esta matriz convierte la noción de "optimizar Obsi-Claw" en un conjunto pequeño de dominios de trabajo concretos, separados y priorizados.

La **baseline prudente validada** de OpenClaw es el punto de partida de esta feature, no un dominio de trabajo en sí mismo.
Lo que se organiza aquí no es una reauditoría del boundary, sino la siguiente capa de optimización documental y de preparación sobre una base ya validada.

## Criterio de lectura

Para leer correctamente esta matriz, conviene separar siempre tres planos:

### 1. Baseline validado

Es lo ya tratado como real y defendible en `davlos-control-plane`, con evidencia suficiente para usarlo como punto de partida prudente.

### 2. Deuda residual

Son límites, warnings, tensiones de checkpoint o pendientes host-side que siguen abiertos, pero que no niegan la baseline prudente validada.

### 3. Optimización futura

Es el trabajo posterior que puede ordenar, mejorar o preparar el siguiente tramo del sistema sin asumir todavía que todo deba ejecutarse ya ni en el repo ni en host.

## Matriz de dominios

| Dominio | Propósito | Problema que resuelve | Tipo | Prioridad | Riesgo principal | Dependencia con `davlos-control-plane` | Criterio de done resumido |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Contratos del boundary y superficie expuesta | Definir con claridad qué forma parte del boundary validado y qué queda fuera | Ambigüedad sobre límites reales del boundary, bind, helper y superficie observable | `mixto` | alta | Documentar un contrato distinto del realmente validado | Alta. Debe apoyarse en el checkpoint operativo vigente | Queda documentado qué entra en el boundary validado, qué es deuda residual y qué exigiría gate host-side |
| Observabilidad controlada y helper readonly | Aclarar el modelo de observabilidad prudente sin ampliar superficie | Mezcla entre observabilidad segura, conveniencia operativa y expansión del helper | `mixto` | alta | Empujar ampliaciones del helper como si ya estuvieran aprobadas | Alta. Cualquier ajuste real depende del repo operativo | Quedan definidos los usos válidos, sus límites y los pendientes host-side sin prometer cambios |
| Drift inter-repo y lectura por checkpoints | Normalizar cómo leer diferencias entre producto, históricos y repo operativo | Confusión por ramas, checkpoints e históricos que no dicen exactamente lo mismo | `repo-only` | alta | Sobredramatizar divergencias menores como contradicción estructural | Media. Usa `davlos-control-plane` como referencia, pero el trabajo es documental | Queda claro qué es baseline validado, qué es histórico y qué es drift menor aceptable |
| State runtime, ownership y modelo `.lock` | Preservar y delimitar el contrato prudente actual del state runtime | Riesgo de romper invariantes si aparecen writers no root o cambios de ownership sin revisión | `host-side` | alta | Introducir cambios sobre state o `.lock` sin reevaluación del modelo | Alta. Depende del estado real observado en host | Quedan definidos invariantes actuales, riesgos y gates previos a cualquier cambio futuro |
| Estabilidad operativa de Telegram | Delimitar Telegram como canal mínimo prudente y no como canal plenamente fiable | Tendencia a confundir validación mínima con fiabilidad sostenida | `host-side` | media | Vender Telegram como estable por defecto o dedicarle más alcance del validado | Alta. La verificación sostenida es host-side | Queda documentado su alcance actual, su deuda residual y qué validación adicional haría falta antes de elevar su estatus |
| Integración controlada OpenClaw ↔ vault | Ordenar el siguiente perímetro seguro de interacción con el vault | Mezcla entre incrementos controlados ya validados y aspiraciones de integración amplia o productiva | `mixto` | media | Saltar de integración controlada a sync productivo o escritura amplia del agente | Alta. Cualquier paso real debe contrastarse con checkpoint operativo | Quedan separadas zonas permitidas, no alcance, riesgos y gates previos a nuevas capacidades |
| Continuidad y recuperabilidad prudente | Ordenar qué continuidad mínima ya existe y qué sigue abierto | Confusión entre continuidad prudente validada y reconstrucción reproducible completa | `mixto` | baja | Presentar backups y rehearsal mínimos como cierre integral de continuidad | Alta. La verdad operativa sigue en el repo operativo | Queda separado lo ya validado de lo que sigue siendo deuda residual y de lo que no debe afirmarse todavía |
| Artefactos documentales de ejecución y gates | Preparar prompts, checklists y gates alineados con dominios reales | Riesgo de ejecutar trabajo mezclado, grande o ambiguo por falta de scaffolding documental | `repo-only` | media | Crear artefactos genéricos que no reflejen límites ni prioridades reales | Baja a media. Debe remitir al repo operativo cuando un dominio sea host-side | Existe un conjunto mínimo de artefactos reutilizables por dominio, con restricciones claras y salida auditable |

## Priorización

### Antes

1. Contratos del boundary y superficie expuesta
2. Drift inter-repo y lectura por checkpoints
3. Observabilidad controlada y helper readonly
4. State runtime, ownership y modelo `.lock`

### Después

5. Integración controlada OpenClaw ↔ vault
6. Estabilidad operativa de Telegram
7. Continuidad y recuperabilidad prudente
8. Artefactos documentales de ejecución y gates

## Dominios que no deben mezclarse todavía

- observabilidad controlada y helper readonly con ampliación real de superficie del helper;
- estabilidad operativa de Telegram con nuevos canales del broker o nuevas capacidades no verificadas;
- integración OpenClaw ↔ vault con Syncthing productivo o sincronización completa entre clientes;
- state runtime, ownership y modelo `.lock` con introducción de writers no root;
- continuidad y recuperabilidad prudente con reconstrucción reproducible completa o despliegues;
- drift inter-repo y lectura por checkpoints con negación del baseline prudente validado;
- contratos del boundary y superficie expuesta con nuevas features amplias de runtime.

## Nota transversal

El dominio **artefactos documentales de ejecución y gates** actúa como capa habilitadora para los demás dominios: ordena prompts, checklists, gates y formato de trabajo.

No sustituye trabajo host-side, no valida por sí mismo cambios operativos y no debe usarse para presentar como ejecutado lo que solo ha quedado preparado a nivel documental.

## Siguiente paso lógico

Esta matriz pasa a ser entrada directa del **Bloque 3** de la feature:

- separar, por dominio, qué trabajo es `repo-only`;
- separar, por dominio, qué queda `pendiente de validación o ejecución host-side`;
- definir los gates mínimos antes de cualquier paso operativo futuro.
