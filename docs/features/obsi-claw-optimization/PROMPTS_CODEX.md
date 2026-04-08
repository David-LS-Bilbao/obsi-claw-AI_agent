# PROMPTS_CODEX — Feature `obsi-claw-optimization`

Uso recomendado: copiar un bloque completo y ejecutarlo en Codex CLI.
Todos los prompts de este archivo son documentales, acotados y compatibles con la regla de no inventar estado del host.

## Prompt 1 — Alineación del baseline y precedencia documental

```text
Actúa como Tech Lead + Documentation Refactorer del repositorio `obsi-claw-AI_agent`.

Objetivo:
alinear la documentación viva de producto con el hecho de que OpenClaw parte ya de un baseline prudente validado, sin salir del alcance repo-only.

Contexto obligatorio:
- `davlos-control-plane` es la fuente de verdad operativa;
- `obsi-claw-AI_agent` es la fuente de verdad de producto y documentación;
- no inventes estado del host ni des por hechas validaciones no ejecutadas.

Tipo de trabajo:
repo-only.

Archivos objetivo sugeridos:
- `README.md`
- `docs/ESTADO_GLOBAL.md`
- `docs/BASELINE_OPENCLAW_VALIDADO_Y_SIGUIENTE_TRAMO.md`
- `docs/MAPA_DE_SPRINTS.md`
- `docs/features/obsi-claw-optimization/`

Restricciones:
- no toques scripts, runtime, systemd, servicios ni `main`;
- no copies evidencia operativa sensible desde `davlos-control-plane`;
- no reescribas cierres históricos completos si bastan ajustes pequeños;
- limita el diff a documentación de alto impacto.

Instrucciones:
1. revisa solo los documentos necesarios para detectar drift documental vivo;
2. corrige afirmaciones que sigan presentando OpenClaw como un boundary incierto;
3. deja explícita la precedencia entre repo de producto y repo operativo;
4. si una afirmación depende de host-side, márcala como `pendiente de validación o ejecución host-side`;
5. mantén los cambios pequeños, trazables y fáciles de revisar.

Salida estructurada obligatoria:
1. Resumen ejecutivo
2. Archivos revisados
3. Drift detectado
4. Cambios aplicados
5. Riesgos o límites
6. Siguiente paso lógico
```

## Prompt 2 — Matriz de dominios de optimización

```text
Actúa como Tech Lead + Security Reviewer + Documentation Planner del repositorio `obsi-claw-AI_agent`.

Objetivo:
definir de forma concreta qué significa "optimizar Obsi-Claw" en la fase posterior al baseline prudente validado.

Tipo de trabajo:
repo-only, con clasificación explícita de dependencias host-side futuras.

Archivo objetivo sugerido:
- `docs/features/obsi-claw-optimization/MATRIZ_DOMINIOS_OPTIMIZACION.md`

Restricciones:
- no toques host, runtime, scripts ni `main`;
- no prometas hardening, estabilidad o despliegues no verificados;
- no mezcles varios dominios en una única categoría difusa;
- no hagas un documento inflado: prioriza MVP.

Instrucciones:
1. separa como mínimo estos dominios: boundary, observabilidad controlada, estabilidad Telegram, integración prudente con vault e higiene documental;
2. para cada dominio, define: valor esperado, alcance, no alcance, riesgos y dependencia con `davlos-control-plane`;
3. clasifica cada dominio como `repo-only`, mixto o `pendiente de validación o ejecución host-side`;
4. deja claro qué entra en la siguiente fase y qué queda fuera;
5. si el archivo no existe, créalo dentro de `docs/features/obsi-claw-optimization/`.

Salida estructurada obligatoria:
1. Resumen ejecutivo
2. Dominios definidos
3. Clasificación repo-only vs host-side
4. Qué entra ahora
5. Qué no entra todavía
6. Riesgos
7. Siguiente paso lógico
```

## Prompt 3 — Mapa repo-only vs host-side y gates de verificación

```text
Actúa como Tech Lead + Documentation Planner + Security Reviewer del repositorio `obsi-claw-AI_agent`.

Objetivo:
dejar una separación explícita entre trabajo resoluble solo en repo y trabajo que requerirá verificación posterior en host o en `davlos-control-plane`.

Tipo de trabajo:
documental con dependencias host-side futuras; no ejecutar ni simular verificación host-side.

Archivo objetivo sugerido:
- `docs/features/obsi-claw-optimization/MATRIZ_REPO_VS_HOST.md`

Restricciones:
- no ejecutes comandos contra host;
- no inventes evidencia ni validaciones;
- no toques scripts, runtime, servicios ni `main`;
- no conviertas este documento en un runbook de despliegue.

Instrucciones:
1. identifica tareas, afirmaciones o cambios que puedan resolverse solo en repo;
2. identifica tareas, afirmaciones o cambios que queden `pendiente de validación o ejecución host-side`;
3. para cada punto host-side, define un gate mínimo de verificación y el repo fuente de verdad;
4. deja visibles las afirmaciones que no deben hacerse sin evidencia nueva;
5. mantén el documento compacto y utilizable por otro chat o por otra rama.

Salida estructurada obligatoria:
1. Resumen ejecutivo
2. Tabla repo-only
3. Tabla host-side
4. Gates de verificación
5. Afirmaciones prohibidas sin evidencia
6. Riesgos
7. Siguiente paso lógico
```

## Prompt 4 — Checklist mínima de preparación operativa futura

```text
Actúa como Tech Lead + Documentation Planner del repositorio `obsi-claw-AI_agent`.

Objetivo:
preparar una checklist mínima de precondiciones y stop conditions para el siguiente tramo operativo, sin ejecutar cambios y sin inventar validaciones host-side.

Tipo de trabajo:
documental; dependiente de verificación host-side futura.

Archivo objetivo sugerido:
- `docs/features/obsi-claw-optimization/CHECKLIST_PREPARACION_OPERATIVA.md`

Restricciones:
- no toques host, runtime, scripts, servicios ni `main`;
- no escribas comandos nuevos de host si no están ya respaldados por documentación existente;
- no presentes una checklist como si fuera despliegue ejecutado;
- no abras nuevas superficies de permisos o red en la propuesta.

Instrucciones:
1. define una secuencia mínima de prechecks, condiciones de entrada y stop conditions;
2. indica qué componentes no deben tocarse sin nueva verificación;
3. añade una nota breve de rollback esperado a nivel documental;
4. cualquier paso dependiente de host debe quedar marcado como `pendiente de validación o ejecución host-side`;
5. mantén la checklist corta y orientada a reducir riesgo, no a describir una implementación completa.

Salida estructurada obligatoria:
1. Resumen ejecutivo
2. Precondiciones
3. Secuencia propuesta
4. Stop conditions
5. Rollback esperado
6. Límites
7. Siguiente paso lógico
```

## Prompt 5 — Pack de prompts Codex por bloque

```text
Actúa como Prompt Engineer + Tech Lead del repositorio `obsi-claw-AI_agent`.

Objetivo:
preparar o refinar el archivo `docs/features/obsi-claw-optimization/PROMPTS_CODEX.md` con un prompt reutilizable por cada bloque del backlog vigente.

Tipo de trabajo:
repo-only.

Archivo objetivo:
- `docs/features/obsi-claw-optimization/PROMPTS_CODEX.md`

Restricciones:
- redacta todos los prompts en español;
- cada prompt debe ser específico, pequeño y reutilizable;
- cada prompt debe prohibir inventar estado del host;
- cada prompt debe dejar claro si el trabajo es repo-only o depende de validación host-side;
- no mezcles varios bloques dentro del mismo prompt;
- no induzcas cambios grandes ni refactors amplios.

Instrucciones:
1. revisa el backlog vigente de `docs/features/obsi-claw-optimization/SPRINT_00_BACKLOG.md`;
2. redacta un prompt por bloque del backlog;
3. en cada prompt, incluye objetivo, tipo de trabajo, restricciones, instrucciones y formato de salida obligatorio;
4. si detectas ambigüedad entre bloques, corrígela con el mínimo cambio documental necesario;
5. deja el archivo listo para copiar y pegar en Codex CLI.

Salida estructurada obligatoria:
1. Resumen ejecutivo
2. Cobertura por bloque
3. Cambios aplicados
4. Riesgos o ambigüedades restantes
5. Siguiente paso lógico
```
