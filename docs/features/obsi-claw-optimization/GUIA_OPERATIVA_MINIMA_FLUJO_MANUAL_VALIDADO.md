# GUIA_OPERATIVA_MINIMA_FLUJO_MANUAL_VALIDADO

## Propósito

Usar de forma breve, segura y sin improvisación el flujo manual validado de Obsi-Claw sobre zonas seguras del vault.

## Alcance

Esta guía cubre únicamente el flujo manual ya validado:

- captura mínima en `Agent/Inbox_Agent`
- promoción manual a `Agent/Drafts_Agent`
- promoción manual a `Agent/Reports_Agent`

El flujo sigue siendo manual, con intervención humana explícita en cada paso.

## Precondiciones mínimas

- Existe acceso operativo al entorno ya validado.
- Las capacidades `inbox.write`, `draft.write` y `report.write` ya están disponibles en su forma validada.
- La persona operadora revisa el contenido antes de cada promoción.
- La persona operadora acepta que el flujo no es automático.

## Flujo manual paso a paso

1. Preparar una captura mínima y controlada para `Inbox_Agent`.
2. Ejecutar la captura y comprobar que aparece exactamente un artefacto nuevo en `Agent/Inbox_Agent`.
3. Revisar manualmente la captura antes de continuar.
4. Preparar un `STAGED_INPUT.md` nuevo y explícito para `draft.write`, referenciando la captura validada.
5. Ejecutar `draft.write` y comprobar que aparece exactamente un artefacto nuevo en `Agent/Drafts_Agent`.
6. Revisar manualmente el draft antes de continuar.
7. Preparar un `REPORT_INPUT.md` nuevo y explícito para `report.write`, referenciando el draft validado.
8. Ejecutar `report.write` y comprobar que aparece exactamente un artefacto nuevo en `Agent/Reports_Agent`.
9. Revisar el report preparado antes de cualquier uso posterior.

## Validaciones humanas esperadas

- Confirmar que cada artefacto cae en el dominio correcto.
- Confirmar que el contenido es el esperado antes de promoverlo al siguiente paso.
- Confirmar que la trazabilidad en `source_refs` es explícita y coherente.
- Confirmar que no se está reutilizando un input ambiguo o antiguo por error.

## Evidencias mínimas a revisar

Antes de pasar al siguiente paso, revisar como mínimo:

- existencia del artefacto nuevo esperado;
- dominio correcto del artefacto;
- auditoría del writer correspondiente;
- ausencia de efectos laterales fuera de `Inbox_Agent`, `Drafts_Agent` o `Reports_Agent`;
- posibilidad de rollback simple del artefacto recién generado.

## Stop conditions

Detener el flujo si ocurre cualquiera de estas condiciones:

- el artefacto no aparece en el dominio esperado;
- aparece más de un artefacto nuevo no previsto;
- falta trazabilidad explícita entre pasos;
- la auditoría no refleja correctamente la operación;
- el contenido requiere revisión adicional antes de seguir;
- hay cualquier duda sobre si el siguiente paso sería ya una automatización no validada.

## Límites explícitos

Esta guía no cubre ni autoriza:

- automatización del flujo;
- promoción automática;
- broker write;
- Telegram write;
- cierre editorial automático;
- orquestación autónoma;
- apertura de nuevos dominios técnicos.

## Siguiente paso lógico

Mantener este flujo como operación manual prudente y reutilizable. Si más adelante se quiere mejorar ergonomía o reducir fricción operativa, debe hacerse en una iteración separada, sin reinterpretar este flujo como automatización implícita.
