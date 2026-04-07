# Sprint 5 — Tareas con HITL obligatorio

## 1. Propósito del documento
Este documento identifica las operaciones técnicas que, por su riesgo, impacto o falta de validación total, **prohíben la autonomía del agente**. Su objetivo es garantizar que el humano sea siempre el actor final en decisiones que afecten a la integridad del sistema, la persistencia de datos o la seguridad del boundary de Obsi-Claw.

## 2. Qué significa HITL en Sprint 5
HITL (*Human-In-The-Loop*) implica que el flujo de trabajo del agente se detiene obligatoriamente ante un hito crítico. El agente puede investigar, proponer o preparar el escenario, pero la ejecución real, la validación del cambio o la promoción del resultado debe ser realizada por una persona.

## 3. Principios de control humano
- **Responsabilidad Final:** El agente es un asistente; el humano es el operador responsable del VPS y del Vault.
- **Validación Pre-Ejecución:** No hay cambio de estado sin "ojo humano" previo.
- **Disparo Manual:** El agente no debe automatizar el "disparo" de scripts de mutación sin autorización explícita y síncrona.
- **Límite de Escritura:** Cualquier escritura fuera del perímetro `Agent/` del vault es, por definición, una tarea HITL (o prohibida).

## 4. Tabla principal de tareas con HITL obligatorio

| Tarea | Por qué requiere HITL | Riesgo principal | Capacidad o skill relacionada | Canal implicado | Qué puede preparar el agente | Qué debe decidir o ejecutar el humano | Evidencia mínima previa | Estado actual |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Promoción de Drafts** | El vault productivo es sagrado | Corrupción de notas del usuario | `draft.write` | Consola / Obsidian | Redactar el contenido en `Agent/Drafts_Agent/`. | Mover o copiar el archivo al directorio final. | Informe de validación del draft | **Aplicable** |
| **Cambios en Configuración (.env)** | Puede romper el boundary | Caída persistente de servicios | Inferencia / SSH | SSH | Proponer el nuevo valor o la línea a modificar. | Editar el archivo real y recargar el servicio. | Backup previo del archivo | **Aplicable** |
| **Acciones sobre Servicios (Start/Stop)** | Afecta disponibilidad | Pérdida de conectividad (SSH/Bot) | `operator.control` | SSH (devops) | Diagnosticar el fallo y proponer el comando. | Ejecutar `systemctl` o `docker compose`. | Log de error del servicio | **Aplicable** |
| **Cambios en Red / Firewall** | Esclusa de seguridad crítica | Bloqueo total del VPS (Lockout) | `sh` / `hardening` | SSH | Analizar el tráfico o la regla necesaria. | Aplicar el comando UFW o de red. | Prueba de conectividad local | **Parcial** |
| **Pairing / Ampliación Syncthing** | Abre superficie de sincronización | Fuga de datos / Conflicto de versiones | Syncthing Admin | SSH / GUI | Comprobar si el proceso está activo. | Iniciar el pairing y aceptar dispositivos. | Identificador del dispositivo | **Parcial** |
| **Acciones fuera de `Agent/`** | Perímetro de seguridad | Mutación no autorizada del Vault | Filesystem | SSH | Identificar la necesidad de cambio. | Realizar la operación de archivo. | Motivo de la intervención | **Aplicable** |

## 5. Tareas que nunca deben pasar a modo autónomo en Sprint 5
- **Borrado Masivo:** Cualquier operación de `rm -rf` o limpieza de logs antigua.
- **Cambio de Secretos:** Renovación de tokens de Telegram o claves SSH.
- **Actualizaciones de Seguridad:** Parcheo del SO o de imágenes Docker sin supervisión.
- **Movimiento de Datos Núcleo:** Reorganización de las carpetas `90_Notas_Nucleo_Usuario` o similares.

## 6. Señales de parada inmediata y escalado
- El agente detecta un comportamiento inesperado en un comando de `oneshot`.
- El agente recibe un error de `Permission denied` en una zona que creía controlada.
- El agente detecta una señal de compromiso (ej. logins inesperados en logs).
- El agente identifica una divergencia (Drift) crítica que afecta a la seguridad.

## 7. Relación con el catálogo de tareas delegables seguras
Esta tabla es el espejo restrictivo del catálogo de tareas delegables. Mientras que el catálogo dice "qué es seguro", este documento dice "dónde termina lo seguro y dónde empieza la responsabilidad humana". **Toda tarea no listada en el catálogo delegado se considera HITL o Prohibida por defecto.**

## 8. Criterio de uso correcto
Un cambio bajo HITL solo es válido si se documenta: **Propuesta del Agente -> Revisión Humana -> Ejecución Humana -> Validación Final del Agente**.

## 9. Siguiente artefacto recomendado
- **Protocolo de Promoción de Drafts (PPD):** Guía paso a paso para que el humano realice la promoción de forma segura y consistente con el Segundo Cerebro.
- **Checklist de Reequilibrio Semafórico:** Para cuando el humano deba intervenir tras un diagnóstico del agente.
