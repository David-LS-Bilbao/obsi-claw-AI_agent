# BACKLOG_MOSCOW_SPRINT_1.md

| ID | Tarea | Motivo | Riesgo si no se hace | Dependencia | Tipo | Estado |
| --- | --- | --- | --- | --- | --- | --- |
| S1-01 | Fijar baseline documental oficial del boundary en el repo del proyecto | Evitar que el sprint siga apoyándose en textos históricos mezclados | Decisiones sobre una fuente equivocada | Auditoría host-side readonly | documental | done |
| S1-02 | Documentar la precedencia entre evidencia de host, `control-plane` y repo de proyecto | Reducir drift entre producto y operación | Contradicciones y discusiones improductivas en siguientes chats | S1-01 | documental | done |
| S1-03 | Preparar runbook readonly para validar `davlos-openclaw-readonly` | Abrir una vía segura de observabilidad validada | Seguir auditando con confianza parcial sobre helper y estado efectivo | Auditoría host-side readonly | documental | done |
| S1-04 | Validar funcionalmente el helper readonly con subcomandos de lectura | Confirmar que la vía segura de inspección realmente funciona | Bloqueo o falsa confianza antes de validar broker/Telegram | S1-03 | verificación | done |
| S1-05 | Ejecutar verificación mínima no mutante del broker restringido | Pasar broker de ámbar fuerte a verde o mantenerlo en ámbar con evidencia trazable | Asumir operativo algo que no fue ejercitado por su propio camino de ejecución | S1-04 | verificación | done |
| S1-06 | Revisar la salud funcional del canal Telegram a partir de warnings observados | Distinguir servicio activo de servicio sano | Degradación silenciosa del canal corto operativo | Auditoría host-side readonly | verificación | carry_to_sprint_2 |
| S1-07 | Auditar egress/allowlist efectiva frente a la declarada | Cerrar el principal gap de hardening todavía abierto | Superficie no normalizada o no documentada de forma fiable | Baseline documental oficial | verificación | done |
| S1-08 | Normalizar la semántica de healthcheck del gateway OpenClaw | Evitar falsas validaciones por HTTP donde solo existe check TCP | Monitoreo y documentación engañosos | S1-01 | documental | done |
| S1-09 | Definir policy inicial de escritura del agente sobre la vault Obsidian | Preparar integración segura sin invadir notas del usuario | Corrupción o sobreescritura prematura de la vault | Baseline documental oficial | documental | done |
| S1-10 | Diseñar layout mínimo de la vault con zonas controladas | Hacer operable el diseño sin activar sync todavía | Mezcla caótica entre notas manuales, evidencias y borradores del agente | S1-09 | documental | done |
| S1-11 | Formalizar el cierre del Sprint 1 y preparar el arranque limpio de Sprint 2 | Evitar reaperturas caóticas o deriva entre chats | Pérdida de continuidad y deuda mal transferida | S1-07, S1-09, S1-10 | documental | done |
