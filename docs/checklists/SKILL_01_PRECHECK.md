# Checklist / Precheck — Skill 01 Auditoría de Drift

## 1. Objetivo del precheck
Garantizar que la ejecución de la auditoría de drift se realiza bajo condiciones de seguridad, solo lectura y con un alcance técnico bien definido, minimizando el riesgo de error operativo o exposición de datos sensibles.

## 2. Condiciones previas mínimas
- [ ] Conexión SSH operativa con el usuario `devops`.
- [ ] Acceso de lectura al repositorio local/remoto de `obsi-claw-AI_agent`.
- [ ] Identificación de la documentación de referencia (ej. `ESTADO_GLOBAL.md`).
- [ ] Espacio de trabajo (workspace) limpio para la redacción del informe.

## 3. Alcance de la auditoría
- [ ] Directorio(s) del host a inspeccionar definidos (ej. `/opt/...`).
- [ ] Archivo(s) de configuración específicos a validar identificados.
- [ ] Servicios o puertos a contrastar listados.
- [ ] **Exclusión confirmada:** No se inspeccionarán datos personales ni secretos fuera de `/opt`.

## 4. Canal y contexto operativo
- [ ] Canal: Consola / SSH (Canal principal verificado).
- [ ] El agente entiende que no debe usar `sudo`.
- [ ] El agente entiende que no debe mutar el sistema de archivos.

## 5. Reglas de seguridad antes de empezar
- [ ] Confirmado: Se Redactará (`[REDACTED]`) cualquier secreto o token detectado.
- [ ] Confirmado: No se usarán comandos recursivos ciegos (`-R` sin límites).
- [ ] Confirmado: No se realizarán reinicios ni cambios en el firewall.

## 6. Confirmaciones sobre evidencia y trazabilidad
- [ ] Se adjuntará el output literal de los comandos de inspección relevantes.
- [ ] Se usará la nomenclatura: Hecho / Inferencia / Pendiente.
- [ ] Se utilizará la plantilla canónica de salida en `templates/obsidian/`.

## 7. Criterios de parada
- [ ] Si se detecta un error de `Permission denied`, se marcará como **Pendiente** y se pasará al siguiente punto.
- [ ] Si se detecta una anomalía de seguridad grave, se detendrá la ejecución y se escalará a HITL.
- [ ] Si la salida del comando es masiva (>800 líneas), se acotará el alcance antes de continuar.

## 8. Criterio de "listo para ejecutar"
- [ ] El alcance es puntual y descriptivo.
- [ ] No existe solapamiento con tareas de remediación o escritura.
- [ ] El operador entiende la distinción entre "existencia técnica" y "capacidad validada".

## 9. Resultado del precheck
- **Apto / No apto:** [POR COMPLETAR]
- **Motivos:** [POR COMPLETAR]
- **Pendiente de verificación en host:** [POR COMPLETAR]
