# PACK_FINAL_PROMPTS_REUTILIZABLES — Feature `obsi-claw-optimization`

## Propósito

Este pack reúne prompts reutilizables para ejecutar trabajo futuro por bloques pequeños, con trazabilidad, límites explícitos y sin improvisación.

Su objetivo es permitir continuidad ordenada de la feature distinguiendo con claridad entre trabajo documental `repo-only` y trabajo de `preparación host-side`, sin convertir ninguno de estos prompts en autorización de ejecución real por sí misma.

## Regla de uso

### Prompts `repo-only`

Se usan para crear, revisar o refinar documentación, matrices, checklists, prompts y definición de alcance dentro de `obsi-claw-AI_agent`.

### Prompts de `preparación host-side`

Se usan para preparar análisis, criterios, gates o checklists previas a una intervención futura en host.
No autorizan ejecución real, no sustituyen evidencia operativa vigente y no reemplazan runbooks ni checkpoints de `davlos-control-plane`.

## Pack de prompts mínimo

### Prompt 1 — Alineación documental viva

**Cuándo usarlo**

Cuando haya que ajustar documentación viva de producto para mantenerla alineada con la baseline prudente validada.

**Tipo**

`repo-only`

**Objetivo**

Corregir drift documental de alto impacto sin duplicar detalle host-side ni reabrir auditorías cerradas.

**Entradas recomendadas**

- `README.md`
- `docs/ESTADO_GLOBAL.md`
- `docs/ESTADO_SEMAFORICO.md`
- `docs/BASELINE_OPENCLAW_VALIDADO_Y_SIGUIENTE_TRAMO.md`
- `docs/COHERENCIA_DOCUMENTAL_BOUNDARY.md`

**Prompt listo para copiar/pegar**

```text
Actúa como Tech Lead + Documentation Refactorer del repositorio `obsi-claw-AI_agent`.

Objetivo:
alinear documentación viva de producto con la baseline prudente validada de OpenClaw, sin tocar host y sin duplicar detalle operativo sensible.

Tipo de trabajo:
repo-only.

Restricciones:
- no tocar host, runtime, scripts ni `main`;
- no inventar estado del VPS;
- no tratar históricos como contradicción crítica si la línea validada ya está cerrada;
- mantener explícita la precedencia documental vigente.

Instrucciones:
1. revisa solo los documentos necesarios;
2. corrige afirmaciones desfasadas o ambiguas;
3. mantén la separación entre repo de producto y repo operativo;
4. marca todo lo dependiente de host como `pendiente de validación o ejecución host-side`;
5. limita el diff a cambios pequeños y auditables.

Salida esperada:
- Resumen
- Archivos tocados
- Cambios aplicados
- Riesgos abiertos
- Diff resumido
```

**Salida esperada**

- resumen ejecutivo;
- lista de archivos tocados;
- cambios aplicados;
- riesgos abiertos;
- diff resumido.

**Riesgos de uso incorrecto**

- convertir producto en copia del repo operativo;
- presentar como “cambio real” un ajuste solo documental.

### Prompt 2 — Matriz de dominios de optimización

**Cuándo usarlo**

Cuando haya que revisar o ampliar la clasificación de dominios sin inflar el alcance de la feature.

**Tipo**

`repo-only`

**Objetivo**

Mantener una matriz MVP de dominios claros, separados y priorizados.

**Entradas recomendadas**

- `docs/features/obsi-claw-optimization/OBJETIVOS_FINALES.md`
- `docs/features/obsi-claw-optimization/SPRINT_00_BACKLOG.md`
- `docs/features/obsi-claw-optimization/MATRIZ_DOMINIOS_OPTIMIZACION.md`

**Prompt listo para copiar/pegar**

```text
Actúa como Tech Lead + Architecture Reviewer + Documentation Planner del repositorio `obsi-claw-AI_agent`.

Objetivo:
revisar o refinar la matriz de dominios de optimización de Obsi-Claw sin convertirla en un roadmap grande ni en una reauditoría.

Tipo de trabajo:
repo-only.

Restricciones:
- no tocar host, runtime, scripts ni `main`;
- no inventar validaciones;
- no mezclar dominios demasiado amplios;
- no vender deuda residual como bloqueo total.

Instrucciones:
1. revisa la matriz vigente;
2. comprueba que cada dominio tenga propósito, problema, tipo, prioridad, riesgo, dependencia y done resumido;
3. elimina solapes o ambigüedades si aparecen;
4. mantén el enfoque MVP y la separación baseline/deuda/optimización futura.

Salida esperada:
- Resumen
- Ajustes propuestos
- Dominios afectados
- Riesgos de solape
- Siguiente paso lógico
```

**Salida esperada**

- resumen;
- ajustes de la matriz;
- dominios afectados;
- riesgos de solape;
- siguiente paso lógico.

**Riesgos de uso incorrecto**

- abrir demasiados dominios nuevos;
- degradar la matriz a una taxonomía difusa.

### Prompt 3 — Mapa repo-only vs host-side

**Cuándo usarlo**

Cuando haya que aclarar si un trabajo futuro es documental, mixto o dependiente de host.

**Tipo**

`repo-only`

**Objetivo**

Separar por dominio lo que puede prepararse en repo de lo que exige gates y evidencia host-side.

**Entradas recomendadas**

- `docs/features/obsi-claw-optimization/MATRIZ_DOMINIOS_OPTIMIZACION.md`
- `docs/features/obsi-claw-optimization/MAPA_REPO_ONLY_VS_HOST_SIDE.md`

**Prompt listo para copiar/pegar**

```text
Actúa como Tech Lead + Documentation Planner + Security Reviewer del repositorio `obsi-claw-AI_agent`.

Objetivo:
revisar o refinar el mapa repo-only vs host-side por dominio, sin convertirlo en un runbook operativo.

Tipo de trabajo:
repo-only.

Restricciones:
- no tocar host ni simular validación real;
- no convertir `repo-only` en cambio desplegado;
- no proponer ejecuciones sin gate;
- mantener el documento compacto y reutilizable.

Instrucciones:
1. revisa la clasificación por dominio;
2. confirma trabajo repo-only permitido, trabajo host-side potencial, gate mínimo, evidencia esperada y riesgo de mezcla;
3. corrige formulaciones ambiguas;
4. mantén visible que `davlos-control-plane` sigue siendo la verdad operativa.

Salida esperada:
- Resumen
- Dominios revisados
- Cambios aplicados
- Gates afectados
- Riesgos abiertos
```

**Salida esperada**

- resumen;
- dominios revisados;
- cambios aplicados;
- gates afectados;
- riesgos abiertos.

**Riesgos de uso incorrecto**

- tratar el mapa como permiso operativo;
- banalizar gates o evidencia requerida.

### Prompt 4 — Checklist mínima de preparación operativa

**Cuándo usarlo**

Cuando haya que revisar si una posible intervención futura está mínimamente preparada antes de hablar de ejecución.

**Tipo**

`repo-only`

**Objetivo**

Mantener una checklist mínima de preparación sin derivarla a runbook real.

**Entradas recomendadas**

- `docs/features/obsi-claw-optimization/MAPA_REPO_ONLY_VS_HOST_SIDE.md`
- `docs/features/obsi-claw-optimization/CHECKLIST_PREPARACION_OPERATIVA_MINIMA.md`

**Prompt listo para copiar/pegar**

```text
Actúa como Tech Lead + Security Reviewer + Documentation Planner del repositorio `obsi-claw-AI_agent`.

Objetivo:
revisar o refinar la checklist mínima de preparación operativa futura sin autorizar ejecuciones reales.

Tipo de trabajo:
repo-only.

Restricciones:
- no tocar host, runtime ni scripts;
- no convertir checklist en runbook;
- no borrar stop conditions ni límites explícitos;
- no asumir validaciones que no existan.

Instrucciones:
1. comprueba que la checklist cubra precondiciones, gates, stop conditions, límites y evidencia mínima esperada;
2. detecta huecos o redundancias;
3. mantén la checklist corta, prudente y reusable;
4. refuerza la diferencia entre preparación documental y ejecución real.

Salida esperada:
- Resumen
- Ajustes propuestos
- Stop conditions revisadas
- Límites confirmados
- Siguiente paso lógico
```

**Salida esperada**

- resumen;
- ajustes propuestos;
- stop conditions revisadas;
- límites confirmados;
- siguiente paso lógico.

**Riesgos de uso incorrecto**

- usar la checklist como autorización de cambio;
- eliminar límites para “ganar velocidad”.

### Prompt 5 — Helper y observabilidad prudente

**Cuándo usarlo**

Cuando haya que preparar una revisión futura del helper readonly y del modelo de observabilidad sin ampliar superficie.

**Tipo**

`preparación host-side`

**Objetivo**

Delimitar qué parte del helper y de la observabilidad puede revisarse, qué evidencia faltaría y qué gates aplican antes de tocar host.

**Entradas recomendadas**

- `docs/features/obsi-claw-optimization/MATRIZ_DOMINIOS_OPTIMIZACION.md`
- `docs/features/obsi-claw-optimization/MAPA_REPO_ONLY_VS_HOST_SIDE.md`
- `docs/features/obsi-claw-optimization/CHECKLIST_PREPARACION_OPERATIVA_MINIMA.md`
- `docs/BASELINE_OPENCLAW_VALIDADO_Y_SIGUIENTE_TRAMO.md`

**Prompt listo para copiar/pegar**

```text
Actúa como Tech Lead + Security Reviewer + Documentation Planner del repositorio `obsi-claw-AI_agent`.

Objetivo:
preparar una revisión futura del helper readonly y de la observabilidad controlada, sin tocar host ni ampliar superficie.

Tipo de trabajo:
preparación host-side.

Restricciones:
- no tocar host, runtime, helper real ni sudoers;
- no presentar la preparación como cambio aprobado;
- no proponer ampliaciones de superficie no aprobadas;
- usar `davlos-control-plane` como referencia operativa.

Instrucciones:
1. identifica qué se quiere revisar exactamente del helper o de la observabilidad;
2. clasifica qué parte es documental y qué parte exigiría host-side;
3. lista gates mínimos, evidencia previa exigible y stop conditions;
4. deja explícito el riesgo de ampliar superficie;
5. mantén el resultado pequeño y accionable.

Salida esperada:
- Resumen
- Alcance exacto
- Gates aplicables
- Evidencia previa exigida
- Stop conditions
- Riesgos de superficie
```

**Salida esperada**

- resumen;
- alcance exacto;
- gates aplicables;
- evidencia previa exigida;
- stop conditions;
- riesgos de superficie.

**Riesgos de uso incorrecto**

- normalizar una ampliación del helper;
- mezclar observabilidad prudente con acceso general a estado operativo.

### Prompt 6 — State, `.lock` y writers

**Cuándo usarlo**

Cuando haya que preparar una revisión futura del state runtime, ownership o compatibilidad de writers sin tocar el modelo vigente.

**Tipo**

`preparación host-side`

**Objetivo**

Preparar una revisión prudente del contrato actual de state y `.lock`, dejando claro qué no debe asumirse.

**Entradas recomendadas**

- `docs/features/obsi-claw-optimization/MATRIZ_DOMINIOS_OPTIMIZACION.md`
- `docs/features/obsi-claw-optimization/MAPA_REPO_ONLY_VS_HOST_SIDE.md`
- `docs/features/obsi-claw-optimization/CHECKLIST_PREPARACION_OPERATIVA_MINIMA.md`
- `docs/BASELINE_OPENCLAW_VALIDADO_Y_SIGUIENTE_TRAMO.md`

**Prompt listo para copiar/pegar**

```text
Actúa como Tech Lead + Security Reviewer + Documentation Planner del repositorio `obsi-claw-AI_agent`.

Objetivo:
preparar una revisión futura del state runtime, ownership y modelo `.lock`, sin tocar host y sin asumir writers no root compatibles.

Tipo de trabajo:
preparación host-side.

Restricciones:
- no tocar host, runtime, permisos ni writers reales;
- no suponer compatibilidad de writers no root;
- no convertir deuda residual en bloqueo total;
- no convertir esta preparación en runbook de cambio.

Instrucciones:
1. resume invariantes actuales y riesgos conocidos;
2. define qué evidencia previa haría falta antes de revisar state u ownership;
3. identifica gates aplicables y condiciones de parada;
4. exige reversibilidad mínima antes de cualquier cambio futuro;
5. mantén explícito qué no debe tocarse sin nueva validación.

Salida esperada:
- Resumen
- Invariantes actuales
- Evidencia previa exigida
- Gates aplicables
- Stop conditions
- Riesgos si se mezcla preparación con ejecución
```

**Salida esperada**

- resumen;
- invariantes actuales;
- evidencia previa exigida;
- gates aplicables;
- stop conditions;
- riesgos de mezcla.

**Riesgos de uso incorrecto**

- trivializar el modelo `.lock`;
- empujar cambios de ownership o writers sin no regresión.

### Prompt 7 — Integración controlada OpenClaw ↔ vault

**Cuándo usarlo**

Cuando haya que preparar una revisión futura del perímetro de integración con el vault sin saltar a integración amplia o productiva.

**Tipo**

`preparación host-side`

**Objetivo**

Delimitar el siguiente perímetro seguro de integración controlada y los gates antes de cualquier ampliación.

**Entradas recomendadas**

- `docs/features/obsi-claw-optimization/MATRIZ_DOMINIOS_OPTIMIZACION.md`
- `docs/features/obsi-claw-optimization/MAPA_REPO_ONLY_VS_HOST_SIDE.md`
- `docs/features/obsi-claw-optimization/CHECKLIST_PREPARACION_OPERATIVA_MINIMA.md`

**Prompt listo para copiar/pegar**

```text
Actúa como Tech Lead + Security Reviewer + Documentation Planner del repositorio `obsi-claw-AI_agent`.

Objetivo:
preparar una revisión futura del perímetro de integración controlada OpenClaw ↔ vault, sin tocar host y sin mezclarlo con vault productivo o sync completo.

Tipo de trabajo:
preparación host-side.

Restricciones:
- no tocar host, runtime, Syncthing ni vault real;
- no presentar integración controlada como integración amplia;
- no prometer escritura adicional del agente;
- no mezclar este análisis con sincronización productiva.

Instrucciones:
1. delimita qué parte de la integración ya está en baseline prudente y qué no;
2. define qué posible siguiente paso exigiría host-side;
3. asigna gates, evidencia previa y stop conditions;
4. deja explícitas las combinaciones prohibidas;
5. mantén el resultado pequeño y reutilizable.

Salida esperada:
- Resumen
- Perímetro permitido
- Perímetro fuera de alcance
- Gates aplicables
- Evidencia previa exigida
- Riesgos de mezcla
```

**Salida esperada**

- resumen;
- perímetro permitido;
- perímetro fuera de alcance;
- gates aplicables;
- evidencia previa exigida;
- riesgos de mezcla.

**Riesgos de uso incorrecto**

- deslizarse hacia vault productivo o Syncthing productivo;
- asumir nuevas capacidades por arrastre desde incrementos ya validados.

### Prompt 8 — Estabilidad mínima de Telegram

**Cuándo usarlo**

Cuando haya que preparar una revisión futura del estatus operativo de Telegram sin venderlo como canal plenamente fiable.

**Tipo**

`preparación host-side`

**Objetivo**

Ordenar qué significa hoy “estabilidad mínima” de Telegram y qué evidencia adicional haría falta antes de elevar su estatus.

**Entradas recomendadas**

- `docs/features/obsi-claw-optimization/MATRIZ_DOMINIOS_OPTIMIZACION.md`
- `docs/features/obsi-claw-optimization/MAPA_REPO_ONLY_VS_HOST_SIDE.md`
- `docs/features/obsi-claw-optimization/CHECKLIST_PREPARACION_OPERATIVA_MINIMA.md`
- `docs/ESTADO_GLOBAL.md`

**Prompt listo para copiar/pegar**

```text
Actúa como Tech Lead + Security Reviewer + Documentation Planner del repositorio `obsi-claw-AI_agent`.

Objetivo:
preparar una revisión futura del estatus operativo de Telegram como canal mínimo prudente, sin tocar host y sin presentarlo como canal plenamente fiable.

Tipo de trabajo:
preparación host-side.

Restricciones:
- no tocar host, servicio real ni runtime;
- no prometer fiabilidad sostenida;
- no usar esta preparación como sustituto de validación real;
- no mezclar Telegram con nuevas capacidades no verificadas del broker.

Instrucciones:
1. resume alcance actual y deuda residual conocida;
2. identifica qué evidencia previa faltaría para una revisión más fuerte;
3. asigna gates y stop conditions;
4. define qué no debe afirmarse todavía sobre Telegram;
5. deja el resultado en formato pequeño y reusable.

Salida esperada:
- Resumen
- Alcance actual
- Evidencia previa exigida
- Gates aplicables
- Qué no debe afirmarse todavía
- Riesgos de sobrerrepresentación
```

**Salida esperada**

- resumen;
- alcance actual;
- evidencia previa exigida;
- gates aplicables;
- qué no debe afirmarse todavía;
- riesgos de sobrerrepresentación.

**Riesgos de uso incorrecto**

- vender Telegram como estable por defecto;
- mezclar canal mínimo prudente con continuidad operativa fuerte.

### Prompt 9 — Continuidad y recuperabilidad prudente

**Cuándo usarlo**

Cuando haya que preparar una revisión futura de continuidad sin convertirla en promesa de reconstrucción reproducible completa.

**Tipo**

`preparación host-side`

**Objetivo**

Separar continuidad mínima ya validada de continuidad integral todavía no demostrada.

**Entradas recomendadas**

- `docs/features/obsi-claw-optimization/MATRIZ_DOMINIOS_OPTIMIZACION.md`
- `docs/features/obsi-claw-optimization/MAPA_REPO_ONLY_VS_HOST_SIDE.md`
- `docs/features/obsi-claw-optimization/CHECKLIST_PREPARACION_OPERATIVA_MINIMA.md`
- `docs/BASELINE_OPENCLAW_VALIDADO_Y_SIGUIENTE_TRAMO.md`

**Prompt listo para copiar/pegar**

```text
Actúa como Tech Lead + Security Reviewer + Documentation Planner del repositorio `obsi-claw-AI_agent`.

Objetivo:
preparar una revisión futura de continuidad y recuperabilidad prudente, sin tocar host y sin presentar backups mínimos o rehearsal como reconstrucción integral cerrada.

Tipo de trabajo:
preparación host-side.

Restricciones:
- no tocar host, runtime ni mecanismos reales de continuidad;
- no prometer reconstrucción reproducible completa;
- no presentar deuda residual como bloqueo total;
- no convertir el análisis en runbook operativo.

Instrucciones:
1. separa continuidad mínima ya validada de continuidad integral todavía pendiente;
2. identifica evidencia previa exigida para cualquier revisión futura;
3. asigna gates y stop conditions;
4. deja claro qué afirmaciones siguen prohibidas;
5. mantén el resultado corto y reutilizable.

Salida esperada:
- Resumen
- Continuidad mínima ya validada
- Continuidad todavía pendiente
- Gates aplicables
- Evidencia previa exigida
- Riesgos de sobrerrepresentación
```

**Salida esperada**

- resumen;
- continuidad mínima ya validada;
- continuidad todavía pendiente;
- gates aplicables;
- evidencia previa exigida;
- riesgos de sobrerrepresentación.

**Riesgos de uso incorrecto**

- vender continuidad prudente como cierre integral;
- abrir alcance de continuidad sin checkpoint operativo suficiente.

## Nota de fronteras

Este pack evita, sobre todo, estos errores:

- improvisar prompts demasiado amplios;
- mezclar `repo-only` con trabajo host-side;
- usar preparación documental como sustituto de validación real;
- arrastrar nuevas capacidades desde una baseline prudente que no las valida;
- convertir deuda residual en bloqueo total o en negación del baseline.

Todavía no debe pedirse con este pack:

- cambios reales de permisos, helper o sudoers;
- cambios reales del modelo `.lock` o de writers;
- integración amplia con vault;
- Syncthing productivo;
- nuevas features de runtime;
- despliegues.

Siguen prohibidas estas mezclas:

- helper/observabilidad con ampliación de superficie no aprobada;
- state/lock/writers con cambios de ownership no gateados;
- integración controlada con vault productivo o sync completo;
- Telegram mínimo prudente con fiabilidad sostenida no validada;
- continuidad prudente con reconstrucción integral cerrada.

## Cierre de la feature

Esta feature deja preparado:

- baseline documental alineado;
- matriz de dominios;
- mapa repo-only vs host-side;
- checklist mínima de preparación operativa;
- pack final de prompts reutilizables.

Lo que ya no debería improvisarse:

- la precedencia documental;
- la clasificación por dominios;
- la diferencia entre preparación y ejecución;
- los gates mínimos antes de tocar host.

El siguiente paso natural fuera de esta fase documental sería usar estos artefactos para abrir trabajo futuro por dominio, empezando por preparación controlada y no por ejecución host-side directa.
