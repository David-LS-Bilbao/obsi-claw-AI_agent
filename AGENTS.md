# AGENTS.md

Instrucciones operativas para este repositorio.

## Alcance

Estas reglas aplican a todo el árbol salvo que exista un `AGENTS.md` más específico.

## Forma de trabajar

- Priorizar seguridad, evidencia, reversibilidad y claridad.
- Trabajar en pasos pequeños y auditables.
- No inventar estado del VPS ni del runtime.
- Escribir en español técnico, breve y accionable.
- Distinguir siempre entre diseño objetivo y estado real observado.

## Límites

- No tocar producción sin evidencia previa, plan, validación y rollback.
- No introducir secretos, tokens o credenciales.
- No asumir acceso root, conectividad libre ni permisos amplios.
- No modificar servicios ajenos al alcance del proyecto sin justificación explícita.

## Regla de precedencia documental

1. Evidencia verificable y estado real observado.
2. `davlos-control-plane` como referencia operativa del VPS.
3. Este repositorio como fuente de verdad de producto, diseño y documentación viva.

## Criterio de calidad

Antes de cerrar una tarea:

- dejar claros los supuestos;
- marcar lo no verificado como `pendiente de verificación en host`;
- explicar riesgos o divergencias;
- y asegurar que el siguiente paso lógico quede visible.
