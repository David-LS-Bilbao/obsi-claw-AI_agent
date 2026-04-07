# Sprint 5 — Catálogo de tareas delegables seguras

## 1. Propósito del catálogo
Este catálogo define el conjunto de tareas operativas que Obsi-Claw puede asumir durante el Sprint 5 con garantías de seguridad y trazabilidad. Su objetivo es evitar la improvisación operativa y asegurar que cada acción delegada cuenta con un soporte documental, técnico y de autonomía validado.

## 2. Principios de delegación segura
- **Control Humano:** El usuario delega la tarea, pero mantiene la responsabilidad del cierre y la promoción de resultados.
- **Solo Lectura por Defecto:** Se priorizan las tareas de inspección y diagnóstico sobre las de mutación.
- **Escritura Perimetrada:** El agente solo puede escribir en directorios autorizados (`Agent/` zones del vault).
- **Auditabilidad:** Cada tarea delegada debe generar evidencia (informes, logs, hashes).
- **Mínima superficie:** No se habilitan capacidades de red, borrado o privilegios elevados.

## 3. Alcance y exclusiones
El alcance se limita a las capacidades validadas en Sprint 4 y formalizadas en el arranque de Sprint 5.
- **Exclusiones Críticas:** No se delegan tareas de remediación automática, borrado de archivos, cambios de red, ni gestión de secretos del host.

## 4. Tabla principal de tareas delegables

| Tarea delegable | Objetivo práctico | Capacidad base / Skill | Canal recomendado | Nivel de autonomía | Condición previa | Límites explícitos | Salida esperada | Evidencia mínima | Estado actual |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Auditoría de Drift Doc ↔ Host** | Detectar desincronía entre repo y VPS | Skill 01 (Auditoría) | Consola (SSH) | Semiautónoma | Checklist de precheck aprobado | Solo lectura. No usar `sudo`. | Informe de Drift (Obsidian) | Comandos de inspección (`ls`, `cat`) | **Usable** |
| **Generación de Heartbeat de Salud** | Reportar estado del agente en vault | `heartbeat.write` | systemd (oneshot) | Segura | Servicio activo en host | Solo en zona `Agent/Heartbeat/`. | Archivo `.md` cronológico | Status de servicio y hash | **Usable** |
| **Redacción de Borrador (Draft)** | Crear nota desde STAGED_INPUT | `draft.write` | systemd (oneshot) | Segura | Existencia de `STAGED_INPUT.md` | Solo en zona `Agent/Drafts_Agent/`. | Nota `.md` con metadatos | Contrato de auditoría (JSONL) | **Usable** |
| **Auditoría Semafórica de Boundary** | Actualizar estado de servicios críticos | `helper-readonly` | Consola / Bot | Segura | Servicios en `active` | No reiniciar; solo consultar. | Informe de semáforo | Output de `systemctl` / `docker` | **Usable** |
| **Precheck de Skill Operativa** | Validar idoneidad de una tarea | Metodología de Precheck | Consola | Segura | Definición de skill previa | Solo lectura de entorno. | Checklist cumplimentado | Verificación de alcance | **Parcial** |
| **Investigación de Logs (Aislada)** | Analizar errores específicos del agente | `helper-readonly` | Consola / SSH | Semiautónoma | Log de error identificado | Solo logs bajo `/var/log/openclaw-*`. | Resumen técnico (MD) | Fragmento de log relevante | **Parcial** |

## 5. Tareas que NO son delegables en Sprint 5
- **Promoción automática de notas:** El agente no puede mover archivos a zonas del usuario fuera de `Agent/`.
- **Limpieza de historial/logs:** No se permite el borrado de archivos (delete).
- **Hardening de red:** Cambio de reglas UFW o iptables.
- **Actualización de software:** Ejecución de `apt upgrade`, `docker pull` sin supervisión total.

## 6. Tareas delegables con HITL obligatorio (Aprobación humana)
- **Generación de Runbooks de Remediación:** El agente propone pasos, el humano los valida.
- **Configuración de Variables de Entorno:** Solo lectura y propuesta, cambio manual por el usuario.
- **Pruebas de Conectividad Broad:** Solo se permiten en entornos controlados y con supervisión.

## 7. Riesgos de uso indebido del catálogo
- **Falsa Confianza:** Asumir que una tarea "Usable" está exenta de riesgo en cualquier condición del VPS.
- **Deriva de Privilegios:** Intentar usar una tarea delegada segura para escalar a zonas prohibidas.
- **Alucinación de Evidencia:** Aceptar un informe del agente sin verificar los hashes o logs asociados.

## 8. Criterio de uso correcto
Una tarea se considera ejecutada según este catálogo si se sigue el ciclo: **Precheck -> Ejecución -> Generación de Evidencia -> Revisión Humana**.

## 9. Siguiente artefacto recomendado
- **Catálogo de Tareas Delegables (Ampliación Sprint 6):** Para definir tareas de mutación controlada (remediación parcial).
- **Guía de Revisión de Evidencias (Humano):** Para que el usuario sepa qué buscar en los logs generados.
