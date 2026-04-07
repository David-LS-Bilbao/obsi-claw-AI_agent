# Sprint 5 — Matriz final de autonomía

## 1. Propósito del documento
Este documento consolida la política de autonomía de Obsi-Claw para el Sprint 5. Sirve como la fuente de verdad definitiva sobre qué puede hacer el agente por sí solo, qué requiere intervención humana (HITL) y qué está estrictamente prohibido, garantizando un entorno operativo seguro y auditable.

## 2. Principios de autonomía limitada
- **Seguridad por Diseño:** El agente no tiene permisos de escritura fuera de su zona designada (`Agent/`).
- **Verificación ante Acción:** El agente debe auditar el estado del host antes de proponer cambios.
- **Responsabilidad HITL:** El humano es el único autorizado para realizar cambios persistentes en el VPS o promover contenido al vault productivo.
- **Transparencia:** Cada acción debe estar respaldada por evidencia técnica (logs, outputs, hashes).

## 3. Canales permitidos y nivel de confianza
- **Consola operativa / SSH (`devops`):** Confianza Alta (Principal). Uso para auditoría y diagnóstico profundo.
- **Systemd Oneshot:** Confianza Alta (Ejecución). Uso para tareas de escritura perimetrada y grabada.
- **Telegram Bot:** Confianza Media (Informativo). Uso para alertas y consultas de estatus rápidas.

## 4. Tabla consolidada de autonomía

| Tarea o capacidad | Categoría | Objetivo práctico | Capacidad / Skill | Canal principal | Nivel de evidencia | Condición previa | Qué hace el agente | Qué hace el humano | Estado actual |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Auditoría de Drift** | **Segura** | Detectar desincronía Host/Docs | Skill 01 (Auditoría) | SSH (devops) | Confirmado live (parcial) | Precheck aprobado | Inspeccionar y reportar divergencias | Revisar informe y decidir acción | **Usable** |
| **Generación de Heartbeat** | **Segura** | Reportar salud en Vault | `heartbeat.write` | systemd (oneshot) | Validado S4 | Servicio activo | Crear reporte .md en Heartbeat zone | Consultar integridad en Obsidian | **Usable** |
| **Redacción de Borrador** | **Segura** | Crear notas desde Inbox | `draft.write` | systemd (oneshot) | Validado S4 | `STAGED_INPUT.md` presente | Crear borrador en Drafts_Agent zone | Revisar contenido para promoción | **Usable** |
| **Promoción de Drafts** | **HITL** | Incorporar notas al Vault | Inferencia / Manual | Obsidian / SSH | Documentado (PPD) | Borrador validado | Preparar el archivo y proponer ruta | Mover el archivo a carpeta núcleo | **Aplicable** |
| **Cambios en Config.** | **HITL** | Ajustar parámetros (.env) | Inferencia / SSH | SSH | Documentado | Backup realizado | Proponer nueva configuración | Editar archivo y reiniciar servicio | **Aplicable** |
| **Acciones en Servicios** | **HITL** | Gestionar disponibilidad | `operator.control` | SSH | Indicios live | Log de error previo | Diagnosticar y proponer comando | Ejecutar `systemctl` / `docker` | **Aplicable** |
| **Reglas de Red/Firewall**| **HITL** | Hardening de boundary | `hardening` / `sh` | SSH | Pendiente de verificación | Análisis de impacto | Proponer reglas UFW/Egress | Aplicar y validar bloqueo | **Parcial** |
| **Lectura transversal** | **Prohibida** | Escaneo total del Vault | N/A | N/A | N/A | N/A | NADA | Mantener privacidad del Vault | **Cerrado** |
| **Borrado de archivos** | **Prohibida** | Limpieza de logs/history | N/A | N/A | N/A | N/A | NADA | Gestionar higiene del host | **Cerrado** |

## 5. Tareas prohibidas en Sprint 5
- **Uso de `sudo`:** El agente no debe invocar privilegios de superusuario.
- **Acceso a Secretos:** El agente no debe leer ni volcar tokens o claves privadas.
- **Remediación Autónoma:** El agente no debe intentar corregir fallos del sistema por sí solo.
- **Escritura fuera de `Agent/`:** Prohibido tocar cualquier archivo fuera del perímetro de confianza.

## 6. Reglas de escalado a HITL
El agente debe detenerse y pedir intervención humana inmediatamente si:
1. Detecta un error de `Permission denied` en una zona supuestamente accesible.
2. Encuentra una divergencia (Drift) en archivos de seguridad o red.
3. El output de un comando sugiere un compromiso del sistema (ej. procesos extraños).
4. El usuario solicita una acción que no figura en la columna "Segura" de la matriz.

## 7. Relación con skills y artefactos existentes
Esta matriz integra los límites definidos en:
- `Skill 01 (Auditoría de Drift)`
- `SPRINT_4_CIERRE.md` (Writers de Heartbeat y Draft)
- `docs/catalogs/SPRINT_5_TAREAS_DELEGABLES_SEGURAS.md`
- `docs/catalogs/SPRINT_5_TAREAS_HITL_OBLIGATORIO.md`

## 8. Riesgos residuales
- **Drift Operativo:** Que el host cambie y la matriz no se actualice. Mitigación: Ejecutar Skill 01 al inicio de sesión.
- **Error de Juicio:** Que el agente clasifique erróneamente un cambio como "Seguro". Mitigación: Uso obligatorio de Checklists de Precheck.
- **Permisos de Root en VPS:** La propiedad de archivos por `root` en el repo del VPS sigue siendo un riesgo de bloqueo para la documentación directa.

## 9. Criterio de uso correcto
La autonomía solo es válida si se mantiene la **Trazabilidad Total**: entrada humana -> precheck -> ejecución del agente -> reporte de salida -> revisión humana.

## 10. Siguiente artefacto recomendado
- **Prompt de Arranque del Sprint 5:** (`PROMPT_ARRANQUE_SPRINT_5.md`) para cargar esta política en el contexto de la sesión del agente.
