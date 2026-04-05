# ESTADO_SEMAFORICO.md

| Área | Estado | Evidencia base | Nota operativa corta |
| --- | --- | --- | --- |
| Runtime host-side | VERDE | `docs/evidence/AUDITORIA_HOST_BOUNDARY_SPRINT_1.md` | Runtime real confirmado y tratado como baseline no tocable sin plan explícito |
| Red `agents_net` | VERDE | `docs/evidence/AUDITORIA_HOST_BOUNDARY_SPRINT_1.md`, `docs/evidence/AUDITORIA_EGRESS_ALLOWLIST_SPRINT_1.md` | Aislamiento Docker visible frente a `verity_network`; no equivale a allowlist final |
| Bind gateway local | VERDE | `docs/evidence/AUDITORIA_HOST_BOUNDARY_SPRINT_1.md` | Publicación limitada a `127.0.0.1:18789`; healthcheck real TCP, no `/healthz` HTTP estable |
| `inference-gateway` | VERDE | `docs/evidence/AUDITORIA_HOST_BOUNDARY_SPRINT_1.md` | Componente host-side confirmado y upstream interno aprobado del boundary |
| Helper readonly | VERDE | `docs/evidence/VALIDACION_HELPER_READONLY_SPRINT_1.md` | Vía preferente de observabilidad controlada |
| Broker restringido | VERDE | `docs/evidence/PRUEBA_FUNCIONAL_READONLY_BROKER_SPRINT_1.md` | Core readonly ejercitado; cualquier canal alternativo sigue `pendiente de verificación en host` |
| Telegram persistente | ÁMBAR | `docs/evidence/AUDITORIA_HOST_BOUNDARY_SPRINT_1.md` | Servicio activo y materializado, pero con warnings de polling y salud funcional no cerrada |
| Egress / allowlist | VERDE | `docs/sprints/SPRINT_2_CIERRE.md`, `docs/evidence/VALIDACION_EGRESS_ALLOWLIST_SPRINT_2_2026-04-05.md`, `docs/runbooks/OPENCLAW_EGRESS_ALLOWLIST_SPRINT_2.md` | `DOCKER-USER -> OPENCLAW-EGRESS` activo, allow efectivo a `172.22.0.1:11440/tcp`, bloqueo probado de `1.1.1.1:443`; la última ventana fue validación/reaplicación idempotente, no primera activación demostrable |
| Coherencia documental | ROJO | `docs/COHERENCIA_DOCUMENTAL_BOUNDARY.md` | Deuda de gobernanza/documentación: `control-plane/README.md` y host alinean mejor que `control-plane/docs/AGENTS.md`; no implica fallo operativo del runtime |
| Vault / Obsidian design | ÁMBAR | `vault-design/README.md` | Postura de diseño prudente definida; sin sync bidireccional ni ownership agresivo del agente |
