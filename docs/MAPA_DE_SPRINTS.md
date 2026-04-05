# MAPA_DE_SPRINTS.md

## Visión general

El proyecto se ejecuta en seis sprints secuenciales, con dependencia fuerte entre seguridad del boundary, gobierno del vault y automatización útil.

---

## Sprint 1 — Auditoría, baseline y gobierno técnico
**Estado:** cerrado

### Resultado esperado
- baseline real confirmada;
- semáforo de riesgos;
- helper readonly validado;
- broker core validado;
- gap principal caracterizado.

### Salida
- cierre formal de Sprint 1;
- resumen de relevo;
- documentación de semáforo;
- borrador de Sprint 2.

---

## Sprint 2 — Hardening real de egress / allowlist
**Estado:** cerrado

### MUST
- auditar egress actual real;
- diseñar allowlist mínima;
- definir deny-by-default;
- preparar backup, rollback y validación;
- ejecutar solo cambios pequeños y reversibles.

### SHOULD
- revisar Telegram persistente;
- consolidar health/readiness;
- aclarar deuda documental residual.

### WON'T
- instalar Syncthing;
- tocar el vault real;
- integrar Obsidian operativamente;
- ampliar superficie del boundary.

### Entregables
- runbook de cambio;
- evidencias pre y post;
- cierre formal del gap rojo o reducción material del riesgo.

### Resultado observado
- `egress/allowlist` queda cerrado técnicamente;
- `172.22.0.1:11440/tcp` sigue reachable desde `openclaw-gateway`;
- `1.1.1.1:443/tcp` queda bloqueado en prueba negativa controlada;
- la última ventana revisada no se toma como primera activación demostrable del hardening.

---

## Sprint 3 — Vault canónico en VPS + Syncthing + política de ownership
**Estado:** siguiente

### MUST
- decidir ruta canónica del vault en VPS;
- definir estructura base del vault;
- definir zonas de escritura del agente;
- definir exclusiones y conflictos;
- definir backups del vault;
- definir plan de instalación y servicio de Syncthing.

### SHOULD
- preparar guía de onboarding para escritorio y Android;
- definir política de promoción con HITL.

### WON'T
- automatización agresiva del agente sobre todo el vault;
- sync bidireccional total sin límites;
- reescritura de notas núcleo del usuario.

### Entregables
- ADR de arquitectura del vault;
- runbook de Syncthing;
- convención de carpetas;
- política de ownership y conflictos.

---

## Sprint 4 — Integración controlada OpenClaw ↔ Vault + heartbeats
**Estado:** pendiente

### MUST
- habilitar carpetas controladas de escritura del agente;
- activar heartbeats seguros;
- documentar reglas HITL;
- validar que no se corrompe el vault.

### SHOULD
- crear primeros flujos útiles:
  - inbox del agente;
  - borradores;
  - reportes;
  - resúmenes periódicos.

### WON'T
- escritura libre del agente sobre todo el vault;
- promoción automática a notas núcleo sin revisión.

### Entregables
- heartbeats documentados;
- evidencia de escritura segura;
- runbook de promoción con HITL.

---

## Sprint 5 — Operador técnico semiautónomo
**Estado:** pendiente

### MUST
- definir skills internas;
- definir prompts operativos;
- preparar casos de uso reales;
- limitar autonomía por riesgo.

### SHOULD
- paneles e informes para Obsidian;
- automatización de tareas delegables.

### Entregables
- catálogo operativo de tareas;
- documentación de skills;
- validaciones funcionales.

---

## Sprint 6 — Estabilización, observabilidad y continuidad
**Estado:** pendiente

### MUST
- revisar deuda técnica;
- cerrar runbooks;
- revisar backups y recuperación;
- dejar RESUMEN maestro y continuidad entre chats.

### Entregables
- operación estable;
- documentación suficiente;
- plataforma utilizable a medio plazo.
