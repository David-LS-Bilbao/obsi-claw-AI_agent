# Prompt operativo — Skill 01 Auditoría de Drift

## 1. Objetivo
Detectar y reportar de forma segura, estructurada y en modo **solo lectura** cualquier divergencia (drift) entre el estado real observado en el host (VPS) y la documentación operativa o de producto almacenada en el repositorio.

## 2. Cuándo usar esta skill
- Al inicio de una sesión de trabajo para validar que la documentación es fiel a la realidad.
- Tras sospechar una intervención manual previa de otro usuario en el host.
- Antes de proponer cambios técnicos que dependan del estado real del sistema.
- Periódicamente para detectar deuda técnica o documental.

## 3. Cuándo NO usar esta skill
- Para realizar cambios correctivos en el host.
- Si el objetivo requiere `sudo` (privilegios elevados) para acceder a zonas críticas.
- Si se busca monitorización en tiempo real (esta skill es puntual).
- Para auditar zonas de datos personales o secretos del usuario fuera de `/opt`.

## 4. Canal principal permitido
- **Consola operativa / SSH (`devops`):** Es el canal con mayor capacidad de inspección y trazabilidad.

## 5. Inputs mínimos esperados
- Ruta del repositorio en el VPS para lectura de docs (`/opt/automation/projects/obsi-claw-AI_agent/docs/`).
- Referencia operativa previa (`docs/ESTADO_GLOBAL.md` y `docs/ESTADO_SEMAFORICO.md`).
- Acceso de lectura al árbol de archivos relevante en `/opt`.

## 6. Reglas de seguridad
- **No usar `sudo`** bajo ninguna circunstancia.
- No modificar el sistema de archivos (create/update/delete).
- **Prohibido volcar secretos**, tokens, claves o contenido sensible en la salida. Redactar como `[REDACTED]` si es necesario mostrar la estructura.
- No realizar cambios de red o reglas de firewall.
- No instalar ni habilitar nuevos servicios.

## 7. Comandos permitidos orientativos
- `ls -la`: Inspección de directorios específicos (evitar recursividad ciega `-R`).
- `cat`: Lectura de archivos específicos y conocidos. No usar en archivos de datos masivos o binarios.
- `ss -tulpn`: Verificar listeners de red (modo solo lectura).
- `systemctl status --no-pager`: Consultar estado de unidades sin bloqueo de terminal.
- `find -maxdepth 2`: Localizar archivos en rutas acotadas.
- `git log -1`: Verificar la última sincronización del repositorio.

## 8. Acciones prohibidas
- Edición de archivos en el VPS (`sed`, `vim`, `nano`).
- Movimiento o borrado de archivos (`mv`, `rm`).
- Cambios de ownership o permisos (`chown`, `chmod`).
- Reinicio o detención de servicios de producción (`systemctl stop/restart`).
- Creación de automatizaciones persistentes (`timer`, `cron`).

## 9. Proceso de ejecución paso a paso
1. **Delimitar el alcance:** Define qué documento de referencia y qué zona del host específica vas a comparar.
2. **Prechecks:** Verifica que tienes permisos de lectura y que la conexión es estable.
3. **Inspección:** Ejecuta los comandos de solo lectura acotados para obtener la evidencia.
4. **Comparación:** Contrasta los resultados obtenidos contra la documentación del repositorio.
5. **Clasificación:** Etiqueta cada hallazgo como Hecho (Confirmado/Divergencia), Inferencia o Pendiente.
6. **Redacción:** Genera el informe siguiendo la plantilla canónica.
7. **Recomendación:** Indica al usuario qué discrepancias requieren su atención manual.

## 10. Regla de clasificación de evidencia
- **Confirmado:** Coincide letra por letra o semánticamente con la documentación; respaldado por un output de comando literal.
- **No confirmado:** El documento indica que existe un elemento, pero el comando no devuelve evidencia.
- **Divergencias:** El estado real es distinto al documentado (ej. puerto, versión o permisos distintos).
- **Pendiente de verificación en host:** Zonas que requieren privilegios de los que no dispones.
- **Inferencias limitadas:** Interpretaciones no probadas (ej. suponer que un servicio corre porque su puerto está abierto).

## 11. Formato obligatorio de salida
Utiliza exclusivamente la plantilla:
`templates/obsidian/SKILL_01_AUDITORIA_DRIFT_TEMPLATE.md`

## 12. Criterio de parada y escalado a HITL
- Detén la ejecución ante cualquier hallazgo que sugiera una intrusión o compromiso de datos.
- Detén la ejecución ante divergencias que afecten a la disponibilidad de servicios esenciales.
- Escala a HITL (Human-In-The-Loop) antes de plantear cualquier plan de remediación.
