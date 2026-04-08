# CHECKLIST_PREPARACION_OPERATIVA_MINIMA — Feature `obsi-claw-optimization`

## Propósito

Esta checklist prepara futuras intervenciones host-side de forma prudente, pequeña y reutilizable.

Su función es ordenar precondiciones, gates, condiciones de parada y mínimos de reversibilidad antes de cualquier trabajo operativo real.
No autoriza ejecución por sí sola, no equivale a validación host-side y no sustituye runbooks ni checkpoints del repo operativo.

## Regla base

- no sustituye evidencia operativa vigente;
- no sustituye runbooks ni validaciones de `davlos-control-plane`;
- no convierte una idea documental en cambio real de host;
- no convierte una intervención potencial en trabajo aprobado;
- cualquier paso host-side sigue dependiendo de checkpoint operativo, gate suficiente y evidencia nueva.

## Checklist mínima

### 1. Precondiciones documentales

| Ítem | Qué se quiere tocar | Por qué | Tipo | Qué evidencia previa existe | Qué gate aplica | Qué condición obliga a parar | Qué rollback o reversibilidad mínima se exige |
| --- | --- | --- | --- | --- | --- | --- | --- |
| D1 — Definición del alcance | un dominio concreto y un componente concreto; no una zona difusa del sistema | evitar mezclar dominios o abrir trabajo no acotado | `repo-only` | matriz de dominios y mapa repo-only vs host-side vigentes | `G1` | el alcance sigue siendo ambiguo o mezcla varios dominios no aprobados | poder volver a la formulación anterior sin dejar supuestos operativos nuevos |
| D2 — Justificación mínima | una intervención potencial, no una mejora genérica | demostrar que resuelve un problema real y no una intuición vaga | `repo-only` | problema ya descrito en la matriz de dominios o en documentación viva | `G1` | no hay problema definido o se intenta "mejorar por mejorar" | dejar trazabilidad documental del motivo y poder descartar la intervención sin arrastre |
| D3 — Clasificación del nivel | si el trabajo es `repo-only`, `host-side` o `mixto` | evitar presentar preparación documental como cambio real | `repo-only` | mapa de niveles del Bloque 3 | `G1` | se intenta marcar como repo-only algo que depende de host | mantener separación explícita entre preparación y ejecución |

### 2. Precondiciones operativas

| Ítem | Qué se quiere tocar | Por qué | Tipo | Qué evidencia previa existe | Qué gate aplica | Qué condición obliga a parar | Qué rollback o reversibilidad mínima se exige |
| --- | --- | --- | --- | --- | --- | --- | --- |
| O1 — Checkpoint operativo vigente | el checkpoint operativo del dominio afectado | asegurar que no se trabaja con histórico viejo o ambiguo | `host-side` | referencia vigente en `davlos-control-plane` y evidencia reciente disponible | `G1` + `G2` | la referencia operativa es antigua, contradictoria o no vigente | no avanzar hasta disponer de checkpoint claro y trazable |
| O2 — No regresión del boundary | cualquier intervención potencial sobre boundary, helper, state, Telegram o vault | evitar reabrir riesgos ya acotados en la baseline prudente validada | `host-side` | baseline validado y límites residuales ya documentados | `G3` | aparece riesgo de degradar la baseline o de reabrir superficie | describir una reversión mínima comprensible antes de cualquier paso |
| O3 — Superficie afectada | permisos, helper, writers, red, Telegram o vault cuando aplique | detectar si el cambio toca una zona sensible del boundary | `host-side` | mapa repo-only vs host-side y límites explícitos vigentes | `G5` | la intervención ampliaría superficie no aprobada | poder abortar sin dejar nueva superficie persistente |

### 3. Gates mínimos previos

| Ítem | Qué se quiere tocar | Por qué | Tipo | Qué evidencia previa existe | Qué gate aplica | Qué condición obliga a parar | Qué rollback o reversibilidad mínima se exige |
| --- | --- | --- | --- | --- | --- | --- | --- |
| GATE-1 — Precedencia documental | la lectura vigente del dominio antes de proponer trabajo real | asegurar que producto, histórico y checkpoint se leen en el orden correcto | `repo-only` | precedencia documental ya fijada en la feature | `G1` | la propuesta contradice evidencia o ignora el checkpoint vigente | rehacer la propuesta antes de cualquier paso posterior |
| GATE-2 — Reversibilidad mínima | cualquier intervención host-side potencial | evitar cambios que no puedan describirse en pasos pequeños y reversibles | `host-side` | criterios previos de reversibilidad documentados | `G4` | no se puede explicar rollback mínimo o reversión razonable | no avanzar mientras no exista reversibilidad mínima entendible |
| GATE-3 — No ampliación no aprobada | helper, sudoers, writers, red o interacción con vault | impedir que un ajuste puntual se convierta en expansión de superficie | `host-side` | límites del boundary y no alcance vigentes | `G5` | la propuesta introduce nueva superficie o nuevas capacidades por arrastre | dejar la propuesta fuera de alcance hasta nueva decisión explícita |

### 4. Stop conditions

- drift documental no resuelto en el dominio que se quiere tocar;
- falta de evidencia host-side vigente o dependencia de un checkpoint ambiguo;
- riesgo de ampliación de superficie no aprobada;
- cambio no reversible o sin rollback mínimo inteligible;
- mezcla de dominios no aprobada;
- suposición no verificada sobre writers, helper, sudoers, Telegram o vault;
- intento de tratar `repo-only` como si fuera cambio ya desplegado;
- necesidad de tocar runtime, permisos o integración amplia fuera del alcance declarado.

### 5. Límites explícitos

Esta checklist no autoriza por sí sola:

- cambios de permisos;
- cambios de helper o sudoers;
- cambios de writers efectivos o del modelo `.lock`;
- integración amplia con vault;
- Syncthing productivo;
- nuevas features de runtime;
- despliegues;
- validaciones host-side sin evidencia nueva.

### 6. Evidencia mínima esperada post-validación

Si una intervención llegara a validarse después en host, el cierre mínimo esperado debería poder responder, como poco:

- qué se tocó realmente;
- por qué se tocó;
- qué checkpoint operativo se usó;
- qué evidencia nueva quedó producida;
- qué no cambió;
- si hubo no regresión observable del boundary;
- qué rollback mínimo seguiría disponible si hiciera falta.

## Nota de uso

Antes de cualquier propuesta host-side futura, esta checklist debe rellenarse al menos a nivel de dominio, componente afectado y gates aplicables.

Si no puede rellenarse de forma corta, precisa y coherente, la intervención todavía no está lista.

## Siguiente paso lógico

Esta checklist debe alimentar el **Bloque 5** de la feature:

- consolidar el pack final de prompts reutilizables por dominio;
- separar prompts de trabajo `repo-only` frente a prompts de preparación para trabajo host-side;
- mantener explícita la diferencia entre preparación documental y ejecución real.
