# AUDITORIA_HOST_BOUNDARY_SPRINT_1.md

## Resumen ejecutivo

La auditoría host-side readonly confirma que el boundary base de OpenClaw está materializado en el VPS y no se limita a documentación histórica. Existe runtime host-side en `/opt/automation/agents/openclaw`, contenedor `openclaw-gateway` activo y sano, red dedicada `agents_net`, bind local exclusivo en `127.0.0.1:18789` y `inference-gateway.service` activo en host con reachability confirmada en `127.0.0.1:11440` y `172.22.0.1:11440`.

También hay evidencia directa de broker restringido en disco, de canal Telegram persistente activo por `systemd` y de helper readonly instalado en host. La parte menos sólida no es la materialización del boundary, sino la coherencia documental: algunos documentos recientes de `control-plane` confirman un checkpoint avanzado, mientras otros textos históricos siguen pidiendo no dar por implementados broker y Telegram.

No se ha tocado producción, no se han reiniciado servicios y no se ha leído contenido sensible.

## Semáforo de confianza

- Verde: confirmado por evidencia directa de host.
- Ámbar: parcialmente confirmado o instalado sin prueba funcional explícita en esta auditoría.
- Rojo: no confirmado o contradicho.

## Tabla de checkpoints auditados

| Checkpoint | Semáforo | Estado | Evidencia directa |
| --- | --- | --- | --- |
| Runtime host-side | Verde | Confirmado | Ruta, árbol, ownership y archivos de runtime presentes |
| Secretos host-side | Verde | Confirmado | `/etc/davlos/secrets/openclaw` existe y contiene `telegram-bot.env` y backups |
| Red Docker `agents_net` | Verde | Confirmado | Red bridge dedicada con subnet `172.22.0.0/16` y solo `openclaw-gateway` conectado |
| Bind `127.0.0.1:18789` | Verde | Confirmado | `ss` y `docker inspect` muestran publicación solo en loopback |
| Reachability `172.22.0.1:11440` | Verde | Confirmado | `curl` a `/healthz` responde correctamente |
| `inference-gateway.service` | Verde | Confirmado | Unit cargada, activa y con upstream Ollama documentable desde código |
| Broker restringido | Ámbar | Materializado y con estado persistente | Policy, auditoría y state store presentes; no se ejecutó prueba funcional |
| Telegram persistente | Verde | Confirmado | Servicio `systemd` activo, secreto presente y archivos de estado recientes |
| Helper readonly | Ámbar | Instalado y cableado | Binario y sudoers presentes; no se ejecutó el helper |
| Hardening básico del contenedor | Verde | Parcialmente completo pero real | `cap_drop: ALL`, `no-new-privileges`, mounts `ro/rw` y sin bind público |

## Evidencia por bloque

### 1. Runtime host-side de OpenClaw

Confirmado:

- existe `/opt/automation/agents/openclaw` con owner `root:root` y modo `0755`;
- existen `compose/`, `config/`, `state/`, `logs/`, `broker/` y `dropzone/`;
- `compose/docker-compose.yaml` existe y está acompañado por `.env` root-owned;
- `config/openclaw.json` existe;
- `broker/restricted_operator_policy.json` existe;
- `broker/audit/restricted_operator.jsonl` y varios ficheros de estado existen con timestamps recientes.

Archivos y rutas relevantes observados:

- `compose/docker-compose.yaml`
- `compose/.env`
- `config/openclaw.json`
- `broker/restricted_operator_policy.json`
- `broker/audit/restricted_operator.jsonl`
- `broker/state/restricted_operator_state.json`
- `broker/state/telegram_offset.json`
- `broker/state/telegram_runtime_status.json`

### 2. Ruta de secretos

Confirmado:

- existe `/etc/davlos/secrets/openclaw` con owner `root:root` y modo `0750`;
- existe `telegram-bot.env` con owner `root:root` y modo `0600`;
- existen backups adicionales del mismo secreto, también con modo `0600`.

No se ha leído contenido de secretos.

### 3. Docker y separación de red

Confirmado:

- el contenedor activo es `openclaw-gateway`;
- imagen: `ghcr.io/openclaw/openclaw:2026.2.3`;
- estado: `Up ... (healthy)`;
- publicación de puertos: `127.0.0.1:18789->18789/tcp`;
- `agents_net` existe con `Subnet=172.22.0.0/16` y `Gateway=172.22.0.1`;
- `openclaw-gateway` está conectado a `agents_net` con IP `172.22.0.2`;
- `verity_network` existe aparte con subnet `172.19.0.0/16` y contenedores distintos;
- no se ha observado solapamiento de `openclaw-gateway` con `verity_network`.

### 4. Bind local y health/reachability

Confirmado:

- `ss -lntp` muestra `docker-proxy` escuchando en `127.0.0.1:18789`;
- `ss -lntp` muestra `python3` escuchando en `127.0.0.1:11440` y `172.22.0.1:11440`;
- `curl http://127.0.0.1:11440/healthz` responde `{"status":"ok",...,"upstream":"ollama"}`;
- `curl http://172.22.0.1:11440/healthz` responde `{"status":"ok",...,"upstream":"ollama"}`.

Hallazgo importante:

- `curl http://127.0.0.1:18789/healthz` no devuelve un JSON de health, sino el HTML base de la UI de OpenClaw;
- el `healthcheck` real del contenedor es un TCP check a `127.0.0.1:18789`, no una comprobación HTTP de readiness.

### 5. `inference-gateway.service`

Confirmado:

- la unit existe en `/etc/systemd/system/inference-gateway.service`;
- `systemctl is-active inference-gateway.service` devuelve `active`;
- `ExecStart` apunta a `/opt/automation/inference-gateway/bin/ollama-proxy.py`;
- el runtime vive en `/opt/automation/inference-gateway`;
- el script fija por defecto `BIND_PORT=11440` y `UPSTREAM_BASE=http://127.0.0.1:11434`;
- el script expone `GET /healthz` y `GET /v1/models`.

### 6. Broker restringido

Clasificación: Ámbar.

Confirmado por evidencia directa:

- existe la policy viva `broker/restricted_operator_policy.json`;
- existe auditoría persistida `broker/audit/restricted_operator.jsonl`;
- existe store de estado `broker/state/restricted_operator_state.json`;
- existe `telegram_runtime_status.json`.

Límite de la auditoría:

- no se ha ejecutado ninguna acción del broker;
- por tanto, se confirma materialización host-side, pero no se ha revalidado funcionalidad end-to-end en esta sesión.

### 7. Telegram persistente

Clasificación: Verde.

Confirmado:

- `openclaw-telegram-bot.service` existe y está `active`;
- usa como `ExecStart` el wrapper de `control-plane` con la policy viva del broker;
- usa `TELEGRAM_BOT_ENV_FILE=/etc/davlos/secrets/openclaw/telegram-bot.env`;
- `telegram_runtime_status.json` tiene timestamp reciente;
- el journal visible desde `systemctl status` muestra actividad reciente y también warnings de polling `HTTP 502`/timeout.

Interpretación:

- el runtime persistente de Telegram está materializado y activo;
- hay que revisar la salud funcional del canal en un paso posterior, porque actividad no implica ausencia de degradación.

### 8. Helper readonly

Clasificación: Ámbar.

Confirmado:

- existe `/usr/local/sbin/davlos-openclaw-readonly` con owner `root:root`, modo `0750`;
- existe `/etc/sudoers.d/davlos-openclaw-readonly` con owner `root:root`, modo `0440`.

Límite de la auditoría:

- no se ejecutó el helper, por prudencia;
- se confirma instalación y cableado, no su comportamiento funcional en esta sesión.

### 9. Contrato básico de hardening

| Control | Estado | Evidencia |
| --- | --- | --- |
| `no-new-privileges` | Confirmado | `docker inspect` muestra `SecurityOpt=[\"no-new-privileges:true\"]` |
| `cap_drop: ALL` | Confirmado | `docker inspect` muestra `CapDrop=[\"ALL\"]` |
| Config mount readonly | Confirmado | `/opt/automation/agents/openclaw/config -> /workspace/config:ro` |
| Secrets mount readonly | Confirmado | `/etc/davlos/secrets/openclaw -> /run/secrets/openclaw:ro` |
| State mount read-write | Confirmado | `state -> /workspace/state` con `RW=true` |
| Logs mount read-write | Confirmado | `logs -> /workspace/logs` con `RW=true` |
| Sin bind público del gateway | Confirmado | solo `127.0.0.1:18789->18789/tcp` |
| `ReadonlyRootfs` | Parcial | `docker inspect` devuelve `ReadonlyRootfs=false`; no formaba parte del claim mínimo revisado |
| Healthcheck endurecido | Parcial | existe healthcheck TCP, pero no readiness HTTP específica confirmada para `18789` |

## Contraste documental mínimo

Claims alineados con la evidencia:

- [README.md](/opt/control-plane/README.md#L45) documenta runtime host-side, `agents_net`, `127.0.0.1:18789`, `172.22.0.1:11440/v1`, broker, Telegram y helper readonly.
- [docs/OPENCLAW_SECURITY_BOOTSTRAP_MVP.md](/opt/control-plane/docs/OPENCLAW_SECURITY_BOOTSTRAP_MVP.md#L9) alinea bind local, red dedicada y endpoint aprobado.
- [docs/TELEGRAM_OPENCLAW_RUNTIME_FINAL.md](/opt/control-plane/docs/TELEGRAM_OPENCLAW_RUNTIME_FINAL.md#L7) alinea unit `systemd`, secreto, policy viva, auditoría, offset y helper readonly.

Documentación divergente o claramente histórica:

- [docs/AGENTS.md](/opt/control-plane/docs/AGENTS.md#L134) indica que no debe darse por implementado broker restringido o integración Telegram;
- esa cautela queda contradicha por la evidencia actual de host y por documentos más recientes del propio `control-plane`.

## Divergencias documentales abiertas

- El checkpoint avanzado del [README.md](/opt/control-plane/README.md#L45) sí está respaldado por evidencia real del host en esta auditoría.
- [docs/AGENTS.md](/opt/control-plane/docs/AGENTS.md#L134) ha quedado desactualizado respecto al estado real en broker y Telegram.
- La semántica de “health MVP correcto en `127.0.0.1:18789`” debe interpretarse como TCP healthcheck del contenedor, no como endpoint HTTP `/healthz` estable.
- El contrato histórico que dejaba `/etc/davlos/secrets/openclaw` “reservado” o potencialmente vacío ya no describe el estado actual: hoy contiene secreto Telegram y backups.

## Conclusión

Listo para pasar a gap analysis de seguridad y consolidación documental:

- runtime OpenClaw base;
- red `agents_net` y separación respecto a `verity_network`;
- bind local exclusivo;
- `inference-gateway.service`;
- hardening mínimo del contenedor;
- materialización de broker, Telegram y helper readonly.

No listo para dar por cerrado sin un siguiente paso:

- salud funcional real de Telegram, por warnings observados;
- revisión de coherencia documental en `control-plane`;
- validación específica de egress/allowlist y auth/policy end-to-end;
- definición segura de la futura integración con Obsidian.
