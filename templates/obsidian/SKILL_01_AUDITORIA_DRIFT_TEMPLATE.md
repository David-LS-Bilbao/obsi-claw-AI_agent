# INFORME DE AUDITORIA DE DRIFT — {{FECHA}}

## 1. Información General
- **Fecha:** {{FECHA}}
- **Alcance:** {{ALCANCE}}
- **Canal usado:** {{CANAL}}
- **Operador / Sesión:** {{OPERADOR}}
- **Skill aplicada:** SKILL 01 — Auditoría de Drift Host ↔ Documentación

## 2. Resumen Ejecutivo
{{RESUMEN_CORTO}}

## 3. Confirmado (Hechos verificados)
*Solo elementos respaldados por evidencia directa en el host que coinciden con la documentación.*

- [ ] {{ELEMENTO_CONFIRMADO}}: {{EVIDENCIA_BREVE}}

## 4. No Confirmado
*Elementos documentados que no han sido localizados o cuya verificación no ha sido posible.*

- [ ] {{ELEMENTO_NO_LOCALIZADO}}: {{MOTIVO}}

## 5. Divergencias Detectadas (Drift)
| Elemento | Documentación de Referencia | Estado Observado | Impacto | Severidad |
| :--- | :--- | :--- | :--- | :--- |
| {{ELEMENTO}} | {{DOC_REF}} | {{ESTADO_REAL}} | {{IMPACTO}} | {{ALTA/MEDIA/BAJA}} |

## 6. Riesgo Operativo
{{DESCRIPCION_RIESGO}}

## 7. Evidencia Usada (Auditoría)
*Lista de comandos ejecutados, archivos consultados o artefactos inspeccionados.*

- `{{COMANDO}}` -> `{{HASH/RESULTADO_BREVE}}`

## 8. Pendiente de Verificación en Host
*Zonas fuera de alcance, que requieren privilegios elevados (sudo) o acceso denegado.*

- [ ] {{ZONA_PENDIENTE}}: {{MOTIVO_BLOQUEO}}

## 9. Inferencias Limitadas (Interpretación del Agente)
*Sección separada de los hechos. No son verdades totales, solo suposiciones basadas en indicios.*

> [!NOTE]
> {{SUPOSICION_BASADA_EN_INDICIOS}}

## 10. Recomendación Mínima (Hacia el Humano)
*Orientada exclusivamente a la revisión o acción manual por parte del usuario. El agente no realizará acciones correctivas.*

1. {{RECOMENDACION_01}}
2. {{RECOMENDACION_02}}

## 11. Criterio de Cierre del Informe
*Este informe se considera suficiente si los puntos críticos de alcance han sido auditados y el riesgo ha sido caracterizado para la toma de decisiones humana.*

---
**Nota:** Este informe sigue el principio de "existencia técnica no equivale a capacidad validada operativamente".
