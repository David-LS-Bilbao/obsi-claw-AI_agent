# Obsi-Claw AI Agent

Second Brain vivo + operador técnico semiautónomo para DAVLOS VPS, basado en Obsidian, OpenClaw y una operación segura guiada por documentación, auditoría y mínimos privilegios.

## 1. Qué es este proyecto

**Obsi-Claw AI Agent** es la capa de proyecto donde se diseña, documenta y evoluciona un sistema híbrido con dos funciones integradas:

- **Segundo Cerebro persistente**: la bóveda de Obsidian actúa como base de conocimiento viva, con notas, memoria, resúmenes, enlaces y contexto operativo.
- **Operador técnico semiautónomo**: OpenClaw ejecuta tareas concretas, repetibles y auditables dentro de un perímetro controlado en el VPS DAVLOS.

La idea no es construir un “chatbot”, sino una plataforma local-first que:
- capture y organice información en Markdown,
- recuerde contexto relevante,
- automatice tareas operativas,
- y mantenga control humano en acciones sensibles.

## 2. Objetivo operativo

El objetivo de este repositorio es convertirse en la **fuente de verdad de producto** de Obsi-Claw, separada del repositorio de estado operativo del VPS.

### Repositorios relacionados

- **Producto / proyecto**: `obsi-claw-AI_agent`
- **Estado operativo del VPS**: `davlos-control-plane`

### Separación de responsabilidades

Este repositorio debe contener:
- visión del producto,
- roadmap,
- arquitectura funcional,
- prompts,
- estructura documental,
- políticas de trabajo con Codex CLI,
- skills y flujos repetibles,
- runbooks específicos de Obsi-Claw.

Este repositorio **no** debe contener:
- secretos,
- credenciales,
- tokens,
- dumps del servidor,
- cambios improvisados sobre producción,
- evidencia sensible copiada desde el VPS sin filtrado.

## 3. Estado actual de partida

El proyecto **no parte desde cero**.

En DAVLOS ya existe una base operativa previa de OpenClaw/OpenClaw boundary documentada en el repo `davlos-control-plane`, con un runtime MVP ya validado en host, red separada y gateway de inferencia interno.

Eso significa que este proyecto debe orientarse a:

1. **auditar lo ya desplegado**,
2. **consolidar y endurecer**,
3. **gobernar el vault canónico e integrar Obsidian de forma segura**,
4. **convertir el MVP en plataforma mantenible**.

## Decisión de arquitectura vigente

La arquitectura documental vigente del proyecto asume:

- vault canónico de Obsidian en el VPS DAVLOS;
- Syncthing como solución prevista de sincronización;
- copias locales del vault en los dispositivos del usuario;
- OpenClaw separado del runtime del vault;
- escritura del agente solo en zonas controladas.

Ruta objetivo recomendada para el vault:

- `/opt/data/obsidian/vault-main`

Esto **no** significa que Syncthing o el vault canónico ya estén desplegados.
Durante Sprint 2 siguen fuera de alcance operativo y cualquier activación real queda `pendiente de verificación en host`.

## 4. Visión del sistema

### Capa 1: Vault / Second Brain
La bóveda de Obsidian será el plano de conocimiento:
- captura rápida,
- proyectos,
- áreas,
- recursos,
- evidencias,
- resúmenes,
- memoria operativa,
- diarios y heartbeats.

### Capa 2: Control-plane del agente
OpenClaw actuará como motor operativo:
- lectura/escritura controlada de Markdown,
- automatización de tareas concretas,
- subagentes para trabajos lentos,
- heartbeats y rutinas periódicas,
- interacción por consola y, cuando proceda, por Telegram.

### Capa 3: Boundary de seguridad
Toda operación debe respetar:
- aislamiento por red,
- secretos host-side,
- bind local,
- mínimo privilegio,
- trazabilidad,
- revisión humana para acciones de impacto.

## 5. Principios del proyecto

1. **Local-first**
   La información vive bajo control del usuario y en formatos legibles.

2. **Markdown-first**
   El conocimiento debe quedar en `.md` siempre que sea razonable.

3. **Git-first**
   Todo cambio de diseño, documentación o automatización debe ser trazable.

4. **MVP antes que complejidad**
   Primero cerrar un flujo pequeño y fiable; luego ampliar.

5. **Seguridad por defecto**
   El agente se trata como software potencialmente peligroso hasta demostrar lo contrario.

6. **Human-in-the-loop**
   El sistema puede automatizar, pero no debe autonomizarse sin límites.

7. **Cambios pequeños y reversibles**
   Nada de saltos grandes sin rollback claro.

## 6. Roadmap maestro resumido

## Sprint 1 — Infraestructura core y privacy router
Objetivo:
- auditar el boundary actual,
- fijar baseline real,
- endurecer SSH/UFW/Fail2Ban,
- consolidar `agents_net`,
- preparar integración segura con Obsidian,
- definir la política de secretos y routing local.

## Sprint 2 — Hardening de egress / allowlist
**Estado:** cerrado técnicamente

Objetivo ejecutado:
- cerrar el gap técnico de `egress/allowlist`;
- validar un `deny-by-default` efectivo para `agents_net`;
- mantener allow explícito a `172.22.0.1:11440/tcp`;
- mantener fuera de alcance operativo a `vault canónico + Syncthing`.

No incluye:
- instalar Syncthing;
- activar el vault canónico;
- mezclar puertos o políticas de sync con el boundary OpenClaw.

## Sprint 3 — Vault canónico + Syncthing + ownership
Objetivo:
- definir arquitectura final del vault canónico,
- preparar Syncthing,
- definir ownership y conflictos,
- fijar exclusiones y backups,
- gobernar sincronización prudente sin corrupción.

## Sprint 4 — Integración controlada OpenClaw ↔ Vault + heartbeats
Objetivo:
- habilitar zonas controladas de escritura del agente,
- activar heartbeats seguros,
- promover borradores con HITL,
- validar que el agente no corrompe el vault.

## Sprint 5 — Operador técnico
Objetivo:
- crear habilidades/skills y prompts operativos,
- soportar tareas guiadas,
- runbooks accionables,
- paneles y salidas útiles para Obsidian.

## Sprint 6 — Auditoría y estabilización
Objetivo:
- observabilidad,
- documentación final,
- backups,
- recuperación,
- límites y deuda técnica.

## 7. Estructura recomendada del repositorio

```text
obsi-claw-AI_agent/
├─ README.md
├─ AGENTS.md
├─ SKILLS.md
├─ docs/
│  ├─ PLAN_DIRECTOR.md
│  ├─ ESTADO_GLOBAL.md
│  ├─ MAPA_DE_SPRINTS.md
│  ├─ RIESGOS_Y_DECISIONES.md
│  ├─ architecture/
│  ├─ runbooks/
│  ├─ prompts/
│  ├─ sprints/
│  └─ evidence/
├─ prompts/
│  ├─ sprint-starters/
│  ├─ codex/
│  └─ director/
├─ templates/
│  ├─ obsidian/
│  ├─ heartbeat/
│  └─ runbooks/
├─ vault-design/
│  ├─ structure/
│  ├─ conventions/
│  └─ workflows/
└─ scripts/
   ├─ audit/
   ├─ bootstrap/
   └─ helpers/
```

## 8. Convenciones documentales

### Archivos base
- `PLAN_DIRECTOR.md`
- `ESTADO_GLOBAL.md`
- `MAPA_DE_SPRINTS.md`
- `RIESGOS_Y_DECISIONES.md`
- `RESUMEN.md`

### Convención de sprints
- `docs/sprints/SPRINT-01-*.md`
- `docs/sprints/SPRINT-02-*.md`

### Convención de runbooks
- `docs/runbooks/NOMBRE_RUNBOOK.md`

### Convención de evidencia
- `docs/evidence/AAAA-MM-DD_DESCRIPCION.md`

## 9. Qué hará Codex CLI en este proyecto

Codex CLI se usará como copiloto operativo para:
- leer contexto del repo,
- generar y corregir documentación,
- preparar scripts,
- redactar runbooks,
- validar estructura,
- proponer cambios mínimos y revisables.

Codex **no** debe:
- inventar estado del VPS,
- asumir que la documentación equivale a despliegue real,
- tocar producción sin evidencia y sin un plan reversible,
- introducir secretos en el repo,
- abrir superficie de red sin justificación expresa.

## 10. Regla de oro de operación

**Primero auditar, luego documentar, después proponer, y solo al final ejecutar.**

## 11. Criterio de éxito del proyecto

El proyecto se considerará bien encaminado cuando tengamos:

- un boundary de OpenClaw consolidado y endurecido,
- una bóveda de Obsidian bien estructurada,
- heartbeats útiles y seguros,
- documentación suficiente para continuar en nuevos chats,
- prompts reutilizables para Codex y para sprints futuros,
- y un sistema que trabaje para el usuario sin comprometer el VPS.

## 12. Estado documental actual

Sprint 1 y Sprint 2 quedan cerrados documentalmente.

Documentos clave:

- [docs/sprints/SPRINT_1_CIERRE.md](docs/sprints/SPRINT_1_CIERRE.md)
- [docs/sprints/SPRINT_2_CIERRE.md](docs/sprints/SPRINT_2_CIERRE.md)
- [docs/ESTADO_SEMAFORICO.md](docs/ESTADO_SEMAFORICO.md)
- [docs/sprints/SPRINT_2_BORRADOR.md](docs/sprints/SPRINT_2_BORRADOR.md)
- [RESUMEN_SPRINT_1.md](RESUMEN_SPRINT_1.md)
- [RESUMEN_SPRINT_2.md](RESUMEN_SPRINT_2.md)

## 13. Próximo paso recomendado

Abrir Sprint 3 con foco en `vault canónico + Syncthing + ownership`, manteniendo ya cerrado el gap técnico de `egress/allowlist` y sin mezclar el trabajo futuro del vault con el hardening ya validado del boundary.
