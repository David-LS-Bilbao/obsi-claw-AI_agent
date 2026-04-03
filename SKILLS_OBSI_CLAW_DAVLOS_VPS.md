# SKILLS.md

Catálogo operativo inicial de habilidades deseadas para Codex CLI en el proyecto Obsi-Claw AI Agent.

## 1. Propósito

Este archivo no contiene skills ejecutables por sí mismo.  
Su función es servir como **registro de habilidades deseadas, patrones reutilizables y flujos de trabajo** para agentes Codex que trabajen en este proyecto.

Úsalo como guía para:
- prompts recurrentes,
- tareas de documentación,
- auditorías,
- bootstrap,
- y futuras skills empaquetables.

## 2. Principio de uso

Cada skill debe cumplir estas reglas:
- ser pequeña,
- tener objetivo único,
- ser segura,
- ser auditable,
- y producir salidas reutilizables.

## 3. Skills prioritarias

## SKILL 01 — Auditoría de estado del VPS
### Objetivo
Comparar documentación, evidencias y realidad operativa antes de proponer cambios.

### Entrada típica
- README operativo
- docs de arquitectura
- runbooks
- inventario de rutas y servicios

### Salida esperada
- tabla de hallazgos,
- divergencias,
- riesgos,
- siguientes pasos.

### Regla
No asumir que “documentado” = “desplegado”.

---

## SKILL 02 — Generación de runbooks
### Objetivo
Crear runbooks cortos, claros y reversibles.

### Debe incluir
- propósito,
- prechecks,
- ejecución,
- validación,
- rollback,
- riesgos.

### Casos
- despliegue,
- hardening,
- backup,
- restore,
- validación post-cambio.

---

## SKILL 03 — Bootstrap documental de sprint
### Objetivo
Preparar el paquete de documentación inicial de cada sprint.

### Salida mínima
- prompt de arranque,
- objetivo,
- alcance,
- criterio de done,
- riesgos,
- checklist de cierre.

---

## SKILL 04 — Revisión de seguridad de cambios
### Objetivo
Revisar un cambio propuesto con foco en:
- secretos,
- red,
- privilegios,
- exposición de puertos,
- impacto lateral.

### Preguntas obligatorias
- ¿abre superficie?
- ¿requiere rollback?
- ¿puede afectar a Verity/n8n/NPM/WireGuard?
- ¿existe evidencia del estado actual?

---

## SKILL 05 — Diseño del vault de Obsidian
### Objetivo
Definir estructuras, convenciones y flujos del Second Brain.

### Entregables
- árbol de carpetas,
- convención de nombres,
- plantillas de notas,
- reglas de enlace,
- reglas de archivos temporales e inbox.

---

## SKILL 06 — Diseño de heartbeats
### Objetivo
Crear rutinas periódicas seguras y útiles.

### Ejemplos
- organizar inbox,
- resumir cambios,
- consolidar notas,
- generar revisión diaria,
- detectar deuda documental.

### Restricción
Nada irreversible sin validación humana.

---

## SKILL 07 — Prompt engineering para chats de sprint
### Objetivo
Redactar prompts de arranque para chats especializados.

### Debe incluir
- contexto suficiente,
- límites de seguridad,
- modo de trabajo paso a paso,
- formato de salida,
- criterio de cierre con `RESUMEN.md`.

---

## SKILL 08 — Refactor documental
### Objetivo
Reordenar documentación sin perder trazabilidad.

### Salida
- propuesta de nueva estructura,
- mapeo viejo → nuevo,
- lista de archivos a mover o fusionar,
- riesgo de drift.

---

## SKILL 09 — Preparación de scripts de hardening
### Objetivo
Redactar scripts o comandos seguros para:
- UFW,
- Fail2Ban,
- permisos,
- estructura `/opt`,
- validaciones.

### Restricción
No ejecutar automáticamente.
Primero documentar y validar.

---

## SKILL 10 — Auditoría de third-party skills
### Objetivo
Revisar skills externas antes de adoptarlas.

### Checklist mínimo
- qué toca,
- qué instala,
- qué lee,
- qué escribe,
- qué exfiltra potencialmente,
- si requiere red,
- si es auditable.

## 4. Skills futuras deseadas

Más adelante este proyecto puede materializar skills para:
- mantenimiento del vault,
- generación de dashboards en HTML para Obsidian,
- preparación de dailies y resúmenes,
- investigación técnica guiada,
- auditoría de scripts del VPS,
- preparación de ADRs,
- organización automática de evidencias.

## 5. Convención para diseñar nuevas skills

Cada nueva skill deberá documentarse así:

```md
## SKILL XX — Nombre
### Objetivo
### Cuándo usarla
### Entradas
### Salidas
### Riesgos
### Restricciones
### Prompt base
### Checklist de validación
```

## 6. Prompt base reutilizable para una skill

```text
Actúa como copiloto técnico del proyecto Obsi-Claw AI Agent.

Objetivo de esta skill:
[describir objetivo]

Contexto:
- repositorio: obsi-claw-AI_agent
- estado operativo del VPS documentado en davlos-control-plane
- no asumir que documentación = despliegue real
- no introducir secretos
- priorizar cambios pequeños y reversibles

Necesito que produzcas:
- [salida 1]
- [salida 2]
- [salida 3]

Restricciones:
- no inventar estado
- marcar supuestos
- separar hallazgos, propuestas y riesgos
- escribir en español técnico claro
```

## 7. Regla final

Las skills de este proyecto deben aumentar capacidad sin aumentar caos.
Si una skill no mejora seguridad, claridad o repetibilidad, no merece entrar en el catálogo.
