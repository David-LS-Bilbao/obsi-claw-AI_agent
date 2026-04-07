# Sprint 5 — Operador técnico semiautónomo útil, limitado y seguro

## 1. Propósito del sprint
- **Qué busca:** Definir y formalizar el marco operativo del agente como operador técnico semiautónomo. Centrado en la creación de skills internas, prompts reutilizables, catálogo de tareas delegables y una matriz de autonomía clara para garantizar la seguridad de la infraestructura y del vault.
- **Qué no busca:** No busca implementar automatización persistente (timers/watchers), ni ampliar la superficie de escritura fuera del perímetro validado, ni habilitar la lectura transversal del vault de Obsidian.

## 2. Estado heredado confirmado
El Sprint 5 hereda el estado consolidado al cierre de Sprint 4, diferenciando niveles de certeza técnica:

| Capacidad / Recurso | Nivel de Evidencia | Estado Host-side |
| :--- | :--- | :--- |
| `heartbeat.write` | Validado por evidencia S4 con indicios live parciales | Unidad `openclaw-vault-heartbeat-writer.service` existe; archivos recientes generados hoy en `Agent/Heartbeat/`. |
| `draft.write` | Validado por evidencia S4 con indicios live parciales | Unidad `openclaw-vault-draft-writer.service` existe; archivos recientes generados hoy en `Agent/Drafts_Agent/`. |
| `inference-gateway` | Indicios live parciales | Listener activo en puerto `11440` (vía `ss -tulpn`). Pendiente de verificación funcional desde el agente. |
| `restricted-broker` | Documentado | Estado "Verde" en semáforos históricos. No revalidado end-to-end recientemente. |
| `helper-readonly` | Documentado | Parte del baseline operativo de Sprint 1. |
| `openclaw-telegram-bot` | **Confirmado live** | Servicio `active running` verificado en sesión actual. |

> **IMPORTANTE:** La existencia técnica de una unidad o archivo no equivale a una capacidad validada operativamente para este sprint. Todo lo no revalidado explícitamente se marca como **pendiente de verificación en host**.

## 3. Principios rectores
- **Seguridad:** El boundary y el vault son intocables fuera de las zonas autorizadas.
- **Evidencia:** Toda afirmación de capacidad requiere contraste con el estado real del host.
- **Reversibilidad:** Todo cambio propuesto debe ser pequeño y reversible.
- **Trazabilidad:** Cada acción del agente debe dejar rastro en auditoría host-side (logs/hashes).
- **Mínima autonomía:** La autonomía se concede gradualmente y se limita por nivel de riesgo (HITL obligatorio para acciones sensibles).

## 4. Alcance del Sprint 5

### 4.1 MUST
- Definir la matriz final de capacidades y autonomía del agente.
- Formalizar el catálogo de tareas técnicas delegables.
- Redactar prompts operativos reutilizables (arranque, diagnóstico, ejecución).
- Definir las skills internas prioritarias (auditoría, redacción de evidencia, etc.).
- Establecer los límites claros entre tareas seguras, con HITL y prohibidas.

### 4.2 SHOULD
- Mejorar la trazabilidad entre el canal de control (Telegram/SSH) y los efectos en el vault.
- Preparar los prechecks basales para el inicio de sesiones de trabajo del agente.

### 4.3 WON'T
- **No** implementar timers, crons ni watchers (automatización persistente).
- **No** habilitar capacidades de borrado (`delete/purge`).
- **No** permitir escritura fuera del directorio `Agent/`.
- **No** habilitar lectura transversal del vault de Obsidian.
- **No** realizar cambios de red, firewall o allowlist de egress.

## 5. Capacidades baseline sobre las que sí puede trabajar Sprint 5

| Capacidad | Clase de evidencia | Alcance permitido | Límite explícito |
| :--- | :--- | :--- | :--- |
| `heartbeat.write` | Validada S4 / Indicios live | `Agent/Heartbeat/` | Solo creación de archivos `oneshot`. |
| `draft.write` | Validada S4 / Indicios live | `Agent/Drafts_Agent/` | Solo desde entrada en `Inbox_Agent/STAGED_INPUT.md`. |
| `inference-gateway` | Indicios live | Operación LLM interna | Sin salida a internet broad. Sin inyección de secretos. |
| Auditoría de logs | Documentada | `/var/log/openclaw-*` | Solo lectura de logs del propio agente. |

## 6. Canales permitidos y restricciones
- **Telegram:** Canal prioritario para estatus, auditoría pasiva y comandos cortos. Restricción: No se asume persistencia total; warnings de polling detectados históricamente.
- **Systemd Oneshot:** Canal para ejecución controlada de tareas de escritura. Restricción: Disparo manual; sin automatización al arranque.
- **SSH (devops):** Canal para administración técnica y auditoría profunda. Restricción: Bloqueo por ownership `root` en el árbol de archivos del repositorio; requiere prudencia en permisos.

Cualquier otro canal (p.ej. API externa no documentada) queda explícitamente **fuera de alcance**.

## 7. Política de autonomía

- **Tareas seguras:** Auditoría de estado, lectura de logs del agente, generación de heartbeats (trigger manual), redacción de drafts (trigger manual).
- **Tareas con HITL obligatorio:** Promoción de drafts a zonas productivas del vault, cambios en configuración de agentes, cambios en el entorno del VPS.
- **Tareas prohibidas:** Borrado de archivos, lectura del vault fuera de `Agent/`, ejecución de comandos de red, escalada de privilegios indiscriminada.

## 8. Skills internas a definir en Sprint 5
- **Skill de Auditoría de Drift:** Comparar el host con la documentación de forma sistemática.
- **Skill de Gestión de Staged Requests:** Transformar entradas de usuario en borradores siguiendo el contrato de Sprint 4.
- **Skill de Documentación de Evidencia:** Producir de forma autónoma el registro de lo realizado para mantener trazabilidad.

*Nota: Estas skills se definen documentalmente; su implementación como scripts ejecutables es objeto de validaciones futuras.*

## 9. Entregables del sprint
- Matriz final de capacidades y autonomía de Sprint 5.
- Catálogo operativo de tareas delegables.
- Prompt de arranque del sprint (`PROMPT_ARRANQUE_SPRINT_5.md`).
- Checklist de precheck basal para sesiones del agente.
- Documentación de skills prioritarias (Skill definitions).

## 10. Criterio de evidencia
Las afirmaciones sobre el estado del VPS deben clasificarse rigurosamente:
1. **Confirmado live:** Verificado en la sesión actual.
2. **Validado por evidencia canónica:** Basado en cierres de sprints previos documentados.
3. **Pendiente de verificación en host:** Todo aquello que no ha sido contrastado con la realidad del VPS en la sesión de trabajo.

## 11. Criterio de done
El Sprint 5 se considerará terminado documentalmente cuando:
- Los entregables de la sección 9 estén redactados, revisados y guardados en el repositorio local.
- La matriz de autonomía sea coherente con las restricciones técnicas observadas y documentadas.
- No existan contradicciones abiertas entre el borrador de Sprint 5 y los resultados reales del host (o queden marcadas como riesgo).
- El siguiente chat/agente pueda iniciar la operación siguiendo el prompt de arranque producido.

## 12. Riesgos y exclusiones
- **Riesgo:** Desincronía persistente entre `/opt/control-plane` y la realidad del host. Mitigación: Marcar siempre como "pendiente de verificación en host".
- **Riesgo:** Ownership `root` en VPS impide al agente como `devops` documentar sus propios hallazgos. Mitigación: Trabajar en workspace local hasta resolución de permisos.
- **Exclusión:** No se contempla la resolución de la sincronización bidireccional de Obsidian (Syncthing) ni la apertura de puertos públicos en este sprint. Todo lo referente a Syncthing se mantiene como baseline administrativo cerrado en Sprint 3.

## 13. Siguiente artefacto documental a producir
El siguiente documento a redactar tras la aprobación de este borrador será:
`docs/prompts/PROMPT_ARRANQUE_SPRINT_5.md`
