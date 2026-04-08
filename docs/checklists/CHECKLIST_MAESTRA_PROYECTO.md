# CHECKLIST_MAESTRA_PROYECTO.md

Reconciliado al `2026-04-08`.

Contrato maestro prudente para Sprint 6.
Este archivo resume el estado útil del proyecto sin sustituir la verdad operativa del host.
Todo lo no cerrado por evidencia suficiente debe mantenerse como `pendiente de verificación en host`.

## Convención

- `[x]` cerrado
- `[~]` prudente, parcial o cerrable por checklist y evidencia
- `[ ]` pendiente o no cerrado

## Fuentes mínimas usadas para esta reconciliación

- `RESUMEN.md`
- `docs/ESTADO_GLOBAL.md`
- `docs/MAPA_DE_SPRINTS.md`
- `docs/sprints/SPRINT_2_CIERRE.md`
- `docs/sprints/SPRINT_4_CIERRE.md`
- `docs/sprints/CIERRE_SPRINT_5.md`

## 1. Estado global

### Estado de sprints

- [x] Sprint 1 cerrado.
- [x] Sprint 2 cerrado.
- [~] Sprint 3 cerrable por checklist y evidencia, sin cierre formal final.
- [x] Sprint 4 cerrado como MVP prudente.
- [x] Sprint 5 cerrado de forma prudente / no maximalista.
- [x] Sprint 6 cerrado de forma prudente / no maximalista.

### Hitos globales

- [x] Arquitectura del vault canónico / Obsidian cerrada formalmente a nivel documental y de ADRs, sin extrapolar a sincronización productiva validada.
- [x] Vault canónico en VPS definido y documentado como `/opt/data/obsidian/vault-main`.
- [~] Baseline mínima de vault + Syncthing documentada y sostenida por evidencia histórica de Sprint 3.
- [~] Sincronización remota con Syncthing validada mínimamente con Android en ambos sentidos, no como sync productivo completo; Windows sigue `pendiente de verificación en host`.
- [~] Integración controlada OpenClaw ↔ Vault validada solo en su MVP prudente.
- [x] `heartbeat.write` y `draft.write` mínimos forman parte de ese MVP prudente ya validado.
- [~] Telegram validado mínimamente para uso operativo prudente, con degradación observable conocida.
- [ ] Telegram validado como canal plenamente fiable.
- [~] Uso estable del sistema alcanzado en sentido prudente: capacidades mínimas validadas, continuidad mínima disponible y ámbar no bloqueantes aceptados para cierre.

## 2. Sprint 2 — Hardening real de egress / allowlist

- [x] Sprint 2 ya no debe tratarse como `pendiente de arranque`.
- [x] `egress/allowlist` quedó cerrado técnicamente.
- [x] Se definieron y documentaron política `deny-by-default`, allowlist mínima, prechecks, backup, rollback y validación.
- [x] Se dejó evidencia funcional suficiente y cierre documental del sprint.
- [x] El sprint quedó cerrado técnica y documentalmente.
- [~] Revisión de Telegram persistente quedó como trabajo secundario no bloqueante, no como validación funcional cerrada.
- [~] Health/readiness quedó como deuda secundaria no bloqueante.
- [~] Contrato final de secretos quedó como deuda secundaria no bloqueante.
- [~] Deuda documental menor de `davlos-control-plane` quedó fuera del cierre principal.

## 3. Sprint 3 — Vault canónico en VPS + Syncthing + ownership

- [~] Sprint 3 no está pendiente total: queda cerrable por checklist y evidencia dentro de su alcance real.
- [x] Ruta canónica del vault definida.
- [x] ADRs y runbooks de arquitectura, ownership, conflictos, exclusiones y backups preparados.
- [x] `vault-main` quedó definido como vault canónico en VPS.
- [x] Existe baseline mínima documentada de vault/Syncthing para Sprint 3.
- [x] Existe backup manual del vault y restore de prueba fuera del vault vivo como baseline prudente.
- [x] OpenClaw quedó separado del vault y de Syncthing en el alcance de Sprint 3.
- [ ] Pairing real con clientes.
- [ ] Validación de sincronización productiva con clientes.
- [ ] Cierre formal final del sprint en este repositorio.
- [ ] Alcance efectivo actual del listener Syncthing `22000`: `pendiente de verificación en host`.
- [ ] Estado exacto actual de carpetas activas, dispositivos remotos y pairing: `pendiente de verificación en host`.

## 4. Sprint 4 — Integración controlada OpenClaw ↔ Vault

- [x] Sprint 4 cerrado como MVP prudente.
- [x] `heartbeat.write` mínimo validado en host.
- [x] `draft.write` mínimo validado en host con contrato nuevo.
- [~] Reglas HITL y promoción quedaron documentadas de forma prudente, no validadas como capacidad operativa separada.
- [ ] `report.write`.
- [ ] watcher.
- [ ] timer.
- [ ] promoción automática.
- [ ] Cualquier ampliación fuera del perímetro ya validado.

## 5. Sprint 5 — Operador técnico semiautónomo

- [x] Sprint 5 cerrado de forma prudente / no maximalista.
- [x] Skill 01 validada con evidencia canónica.
- [x] Prompts operativos reutilizables presentes como insumo de gobierno.
- [x] Catálogo de tareas delegables seguras presente como baseline prudente.
- [x] Catálogo de tareas HITL y límites de autonomía presentes a nivel documental y operativo prudente.
- [x] Matriz final de autonomía disponible como criterio de gobierno del sprint.
- [~] Reutilización segura de `draft.write` demostrada para una segunda tarea real, sin arrastre a nuevas capacidades.
- [~] Telegram materializado y usable con degradación observable, pero no validado para cierre funcional del sprint.
- [ ] Skills adicionales validadas más allá de Skill 01.
- [ ] Validación funcional extremo a extremo del canal Telegram: `pendiente de verificación en host`.
- [ ] Alcance efectivo del listener `10.90.0.1:22000` fuera de `wg0`: `pendiente de verificación en host`.

## 6. Sprint 6 — Estabilización, observabilidad y continuidad

- [x] Sprint 6 puede cerrarse de forma prudente / no maximalista.
- [~] logs y observabilidad. Existe observabilidad real y helper readonly útil para `devops`; sigue siendo una observabilidad mínima y no general.
- [~] backups del vault. Existe backup diario mínimo automatizado con timer, `tar --zstd` y sidecar `.sha256`, validado con checksum.
- [~] backups del boundary. Existen bundle externo mínimo del boundary y backup root-only de secretos, ambos validados; la recuperabilidad integral sigue parcial.
- [~] rollback. Existe restore-check manual no destructivo del vault y rebuild rehearsal mínimo del boundary fuera de producción; no equivale a reconstrucción exacta completa.
- [~] políticas y permisos. La separación real existe, el acceso readonly a logs quedó acotado y el mínimo privilegio es operativo, no total.
- [~] ADRs y criterio de continuidad consolidados documentalmente para cierre prudente.
- [x] rutina diaria mínima definida y validada en una ejecución real.
- [x] rutina semanal mínima definida y validada en una primera ejecución real.
- [~] recuperación ante fallo. Vault y boundary quedan cubiertos en su baseline mínima; la continuidad integral final sigue abierta.
- [~] uso estable del sistema alcanzado en sentido prudente: capacidades mínimas validadas, Telegram y Syncthing con validación mínima suficiente y ámbar no bloqueantes aceptados.

Ámbar aceptado para cierre prudente:
- warning `Unexpected folder "Obsi-Claw"` acotado pero ámbar;
- `.obsidian/workspace.json` tratado como benigno probable, no como drift grave;
- Windows sigue `pendiente de verificación en host`;
- la continuidad integral exacta del boundary no queda cerrada en este sprint.

## Nota de uso

- No usar esta checklist para inflar Sprint 3 a cierre formal final.
- No usar esta checklist para vender Telegram como canal validado.
- No usar esta checklist para vender Syncthing como sincronización productiva ya cerrada.
- No cerrar ningún punto que siga `pendiente de verificación en host`.
