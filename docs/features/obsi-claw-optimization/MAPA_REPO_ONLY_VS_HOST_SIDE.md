# MAPA_REPO_ONLY_VS_HOST_SIDE — Feature `obsi-claw-optimization`

## Propósito

Este documento separa, por dominio, el trabajo que puede prepararse o resolverse solo en repo del trabajo que exigiría validación o ejecución host-side posterior.

Su función no es describir una intervención operativa real, sino evitar que la preparación documental se confunda con despliegue, cambio efectivo en host o validación ya ejecutada.

## Regla base

- `repo-only` no equivale a cambio desplegado ni a capacidad validada en host.
- `host-side` no debe ejecutarse sin gate previo suficiente.
- `davlos-control-plane` sigue siendo la verdad operativa del boundary y de cualquier checkpoint real.
- Este mapa ordena trabajo y dependencias; no sustituye evidencias, prechecks ni rollback operativo.

## Mapa por dominio

| Dominio | Trabajo repo-only permitido | Trabajo host-side potencial | Gate mínimo previo a tocar host | Evidencia esperada para darlo por válido | Riesgo de mezclar niveles |
| --- | --- | --- | --- | --- | --- |
| Contratos del boundary y superficie expuesta | aclarar límites del boundary validado, separar baseline/deuda/optimización y documentar qué no debe afirmarse todavía | contraste de contratos reales del boundary si hubiera que ajustar bind, helper o superficie observable | `G1` + `G2` + `G3` | checkpoint operativo vigente y evidencia suficiente de que el contrato real no contradice lo documentado | convertir una aclaración de contrato en una promesa de cambio real |
| Observabilidad controlada y helper readonly | documentar usos válidos, límites y no alcance del helper readonly | sincronización host-side del helper o cualquier ajuste real de observabilidad | `G1` + `G2` + `G3` + `G5` | evidencia host-side de helper vigente, alcance real y ausencia de ampliación no aprobada | tratar una mejora documental como si autorizara ampliar superficie del helper |
| Drift inter-repo y lectura por checkpoints | clasificar divergencias menores, ordenar históricos y fijar precedencia documental | ninguno por defecto; solo contraste puntual si una divergencia afectara a una afirmación operativa viva | `G1` + `G2` | evidencia reciente o checkpoint operativo que permita cerrar la divergencia | sobredramatizar históricos o usar drift documental como sustituto de validación real |
| State runtime, ownership y modelo `.lock` | documentar invariantes actuales, riesgos y condiciones bajo las que haría falta reabrir análisis | cualquier revisión real de ownership, writers efectivos o comportamiento del `.lock` | `G1` + `G2` + `G3` + `G4` + `G5` | evidencia host-side actual del state, ownership y writer efectivo, más criterio de reversibilidad | presentar como cambio inocuo algo que puede romper invariantes del boundary |
| Estabilidad operativa de Telegram | delimitar alcance actual, deuda residual y qué no debe afirmarse sobre fiabilidad sostenida | validación adicional, ajuste o intervención real sobre el servicio o su operación | `G1` + `G2` + `G3` + `G4` | evidencia host-side reciente de comportamiento, warnings y resultado de validación mínima | vender Telegram como canal estable por defecto desde documentación de producto |
| Integración controlada OpenClaw ↔ vault | documentar perímetro permitido, no alcance y gates antes de nuevas capacidades | cualquier ampliación real de integración, escritura o interacción adicional con el vault | `G1` + `G2` + `G3` + `G5` | evidencia host-side o checkpoint operativo que pruebe compatibilidad con el perímetro validado | mezclar integración controlada con vault productivo o sync completo |
| Continuidad y recuperabilidad prudente | separar continuidad mínima validada de reconstrucción integral pendiente | cualquier prueba adicional, rebuild o ajuste real de continuidad fuera de lo ya validado | `G1` + `G2` + `G3` + `G4` | checkpoint operativo vigente, evidencia de no regresión y criterio de reversibilidad | presentar backups o rehearsal mínimos como cierre integral de continuidad |
| Artefactos documentales de ejecución y gates | preparar prompts, checklists, matrices y criterios de entrada por dominio | ninguno por sí mismo; solo habilita trabajo posterior de otros dominios | `G1` | artefactos coherentes con la baseline validada y con la precedencia documental vigente | usar artefactos documentales como sustituto de una validación host-side que no ocurrió |

## Gates mínimos reutilizables

### G1 — Gate de precedencia documental

Antes de mover un dominio hacia trabajo operativo, debe confirmarse que la lectura vigente respeta este orden:

1. evidencia verificable;
2. checkpoint operativo vigente de `davlos-control-plane`;
3. documentación operativa no contradicha por evidencia más reciente;
4. `obsi-claw-AI_agent` como capa de producto;
5. propuestas futuras.

### G2 — Gate de evidencia operativa vigente

No debe proponerse una intervención real si el dominio depende de un checkpoint antiguo, ambiguo o no contrastado con la línea operativa vigente.

### G3 — Gate de no regresión del boundary

Todo trabajo host-side potencial debe pasar por una comprobación previa de que no degrada la baseline prudente validada ni reabre riesgos ya acotados.

### G4 — Gate de reversibilidad

Si un posible cambio no puede describirse en pasos pequeños, reversibles y con rollback entendible, no está listo para avanzar.

### G5 — Gate de no ampliación de superficie no aprobada

Ningún trabajo debe ampliar helper, permisos, writers efectivos, superficie de red o interacción con vault si esa ampliación no ha sido justificada, acotada y validada como siguiente paso explícito.

## Casos que no deben cruzarse

- tratar un ajuste `repo-only` como si ya fuera un cambio real en host;
- vender la baseline prudente validada como cierre integral del sistema;
- tocar helper, sudoers, state o `.lock` sin evidencia vigente y sin gate previo;
- mezclar vault productivo con integración controlada OpenClaw ↔ vault;
- usar históricos o ramas antiguas como si anularan por sí solos el checkpoint operativo vigente;
- presentar prompts, matrices o checklists como sustituto de validación host-side real.

## Siguiente paso lógico

Este mapa debe alimentar el **Bloque 4** de la feature:

- preparar una checklist mínima de preparación operativa futura;
- ordenar precondiciones y stop conditions;
- dejar explícito qué no debe tocarse sin nueva validación.
