# ESTADO_GLOBAL.md

## Qué está confirmado

- Existe un clon de trabajo del proyecto en `/opt/automation/projects/obsi-claw-AI_agent`.
- Existe un clon local de referencia en `/opt/control-plane`, tratado en esta fase como solo lectura.
- El `README` y la evidencia reciente de `davlos-control-plane` describen un boundary OpenClaw operativo con runtime en `/opt/automation/agents/openclaw`, red `agents_net`, bind local `127.0.0.1:18789`, upstream `http://172.22.0.1:11440/v1` y componentes host-side asociados.
- El repo `obsi-claw-AI_agent` estaba en fase semilla y sin estructura documental mínima para Sprint 1.
- La auditoría host-side readonly confirma runtime real bajo `/opt/automation/agents/openclaw`.
- La auditoría host-side readonly confirma `openclaw-gateway` activo y sano.
- La auditoría host-side readonly confirma `agents_net` separada de `verity_network`.
- La auditoría host-side readonly confirma `inference-gateway.service` activo con `/healthz` correcto en `127.0.0.1:11440` y `172.22.0.1:11440`.
- La auditoría host-side readonly confirma broker, Telegram y helper readonly materializados por evidencia directa de host, con distintos niveles de confianza funcional.
- La validación funcional controlada del helper `davlos-openclaw-readonly` confirma interfaz usable, subcomandos readonly operativos y cableado funcional por la vía `devops -> sudo` al menos para `runtime_summary`.
- La prueba funcional readonly del broker core confirma ejecución real de `action.health.general.v1` fuera de Telegram, con auditoría before/after coherente y sin cambios de estado efectivo.
- Sprint 2 cerró técnicamente `egress/allowlist` con evidencia suficiente: hoy existe `DOCKER-USER -> OPENCLAW-EGRESS`, allow efectivo a `172.22.0.1:11440/tcp`, `DROP` final y bloqueo funcional probado de `1.1.1.1:443/tcp`.
- La validación final consolidada del cierre quedó registrada en `docs/evidence/VALIDACION_EGRESS_ALLOWLIST_SPRINT_2_2026-04-05.md`.
- Sprint 3 ya añadió validación host-side mínima del plano vault/Syncthing, registrada en `docs/evidence/VALIDACION_HOST_VAULT_SYNCTHING_SPRINT_3_2026-04-05.md`.
- Existe `/opt/data/obsidian/vault-main` materializado con ownership `devops:obsidian` y permisos base `2770`.
- `syncthing@syncthing.service` existe y está activo como servicio dedicado con config bajo `/var/lib/syncthing`.
- Sprint 3 dejó documentada una baseline con GUI de Syncthing en `127.0.0.1:8384`, auth local y listener TCP en `127.0.0.1:22000`.
- Sprint 5 abrió una tensión documental por observación de `10.90.0.1:22000`; el alcance efectivo actual del listener queda `pendiente de verificación en host`.
- La vigencia exacta de la afirmación de Sprint 3 sobre carpetas activas, dispositivos remotos y pairing queda `pendiente de verificación en host`.
- Sprint 4 y Sprint 5 ya dejaron evidencia repo-side de integración controlada OpenClaw ↔ vault mediante `heartbeat.write` y `draft.write`, sin arrastre automático a capacidades posteriores.
- Sprint 6 ya dejó automatización mínima diaria del backup del vault canónico con `systemd` timer, `tar --zstd` y sidecar `.sha256`, validada en host.
- Sprint 6 ya dejó restore-check manual no destructivo del vault, validado fuera del vault vivo con comparación prudente y limpieza temporal.
- Sprint 6 ya dejó backup externo mínimo del boundary con config efectiva, compose, policy efectiva, unit Telegram, runbooks mínimos y snapshot externo de egress, validado en host.
- Sprint 6 ya dejó backup root-only manual de `/etc/davlos/secrets/openclaw`, validado en host sin exponer contenidos.
- Sprint 6 ya dejó rebuild rehearsal mínimo del boundary fuera de producción, validado sin tocar el runtime vivo ni arrancar producción.
- Sprint 6 ya dejó observabilidad mínima útil para `devops` mediante helper readonly acotado sobre units operativas clave.
- Sprint 6 ya dejó rutina diaria mínima y rutina semanal mínima definidas y validadas en una primera ejecución real.
- Sprint 6 ya dejó Syncthing validado mínimamente con Android en ambos sentidos; el warning `Unexpected folder "Obsi-Claw"` queda acotado pero ámbar y Windows queda `pendiente de verificación en host`.
- Sprint 6 ya dejó Telegram con validación mínima suficiente mediante `/status`, con degradación observable histórica pero sin caída total en la prueba.
- El repo ya dispone de `docs/PLAN_DE_PRUEBAS_FINAL_MVP_OBSI_CLAW.md` como soporte formal de validación final del MVP.
- El repo ya dispone de `docs/MEMORIA_TECNICA_FINAL_OBSI_CLAW.md` como memoria técnica final del producto en su cierre prudente.

## Semáforo actual del boundary

### Verde

- runtime host-side;
- `agents_net` y aislamiento visible;
- bind local del gateway;
- `inference-gateway.service`;
- hardening base del contenedor.
- `egress/allowlist` cerrado técnicamente en Sprint 2.
- helper readonly validado en modo readonly.
- broker restringido validado en su core de ejecución readonly.

### Ámbar

- Telegram persistente activo pero con warnings de polling;
- Telegram validado mínimamente para uso operativo prudente, con warnings históricos de polling y sin promesa de fiabilidad plena;
- contrato final de secretos y semántica final de health/readiness.
- plano vault/Syncthing materializado y validado mínimamente con Android en ambos sentidos, pero con warning `Obsi-Claw` en ámbar y sin cierre de sync productivo completo.
- continuidad del vault fortalecida por backup diario mínimo y restore-check manual validados; el uso estable del sistema puede sostenerse en sentido prudente.
- continuidad del boundary fortalecida por bundle externo mínimo, backup de secretos y rebuild rehearsal mínimo ya validados; la reconstrucción exacta sigue abierta.

### Rojo

- coherencia documental global entre fuentes de `control-plane`;
- cualquier supuesto de pairing, sincronización productiva o integración OpenClaw ↔ Vault más allá del plano administrativo local ya validado.

## Qué está pendiente de validar en host

- Coincidencia exacta entre toda la documentación de `davlos-control-plane` y el estado actual del runtime real.
- Fiabilidad sostenida del canal Telegram más allá de su validación mínima actual.
- Si se quisiera declarar operativo un canal no-Telegram autenticado del broker, eso queda `pendiente de verificación en host`.
- Nivel de divergencia entre el árbol operativo real y los documentos del checkpoint.
- alcance efectivo actual del listener Syncthing `22000`;
- Si se quisiera ampliar la allowlist o reabrir `11434/tcp`, eso queda `pendiente de verificación en host`.
- postura final de exclusiones y ruido operativo de Syncthing por plataforma;
- exclusiones exactas de sync;
- recuperabilidad integral del boundary más allá del bundle externo, el backup de secretos y el rebuild rehearsal mínimo;
- pairing y validación adicional de clientes, especialmente Windows;
- postura final por plataforma, sobre todo iOS.

## Qué no debe asumirse aún

- Que toda la documentación histórica siga vigente sin contraste con el host.
- Que la cronología exacta de primera activación de la allowlist haya quedado demostrada al minuto.
- Que el cierre de egress autorice por sí solo cambios de vault, Syncthing u Obsidian operativo.
- Que exista ya un canal autenticado no-Telegram del broker desplegado y operativo.
- Que el listener Syncthing `22000` siga hoy limitado a loopback.
- Que el agente tenga ya permiso de escritura sobre una vault Obsidian productiva.
- Que exista una política resuelta para sync bidireccional o resolución de conflictos.
- Que Syncthing siga exactamente sin carpeta activa del vault o clientes remotos emparejados.

## Divergencias documentales abiertas

- `davlos-control-plane` presenta un checkpoint operativo avanzado.
- `obsi-claw-AI_agent` todavía está en fase semilla y acaba de recibir su baseline documental mínimo.
- `control-plane/README.md` queda alineado con la evidencia reciente de host.
- `control-plane/docs/AGENTS.md` conserva afirmaciones históricas desalineadas sobre broker y Telegram.
- Sprint 5 abrió tensión documental sobre el scope actual del listener Syncthing `22000`.
- Toda futura implementación debe contrastarse contra el estado real del VPS.

## Nota operativa

Toda incertidumbre relevante debe mantenerse etiquetada como `pendiente de verificación en host`.

## Criterio prudente de uso estable del sistema

En este proyecto, `uso estable del sistema` no significa perfección ni ausencia total de warnings.
Significa que las capacidades mínimas validadas permiten uso sostenido con ámbar conocido, acotado y no bloqueante:

- observabilidad mínima operativa;
- backup/restore mínimo del vault;
- continuidad mínima del boundary;
- Syncthing validado mínimamente con cliente real;
- Telegram validado mínimamente para uso operativo prudente.
