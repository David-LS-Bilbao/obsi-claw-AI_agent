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
| Egress / allowlist | ROJO | `docs/evidence/AUDITORIA_EGRESS_ALLOWLIST_SPRINT_1.md` | Gap auditado: no hay allowlist real ni `deny-by-default` materializado |
| Coherencia documental | ROJO | `docs/COHERENCIA_DOCUMENTAL_BOUNDARY.md` | Deuda de gobernanza/documentación: `control-plane/README.md` y host alinean mejor que `control-plane/docs/AGENTS.md`; no implica fallo operativo del runtime |
| Vault / Obsidian design | ÁMBAR | `vault-design/README.md` | Postura de diseño prudente definida; sin sync bidireccional ni ownership agresivo del agente |
