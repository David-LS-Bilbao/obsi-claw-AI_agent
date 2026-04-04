# COMANDOS_AUDITORIA_SPRINT_1.md

## Comandos ejecutados en orden

1. `sed -n '1,220p' /opt/automation/projects/obsi-claw-AI_agent/AGENTS.md`
   Propósito: releer la instrucción operativa canónica del repo de trabajo.

2. `sed -n '1,260p' /opt/automation/projects/obsi-claw-AI_agent/README.md`
   Propósito: releer el contexto funcional y arquitectónico del proyecto.

3. `sed -n '1,260p' /opt/automation/projects/obsi-claw-AI_agent/SKILLS_OBSI_CLAW_DAVLOS_VPS.md`
   Propósito: releer el catálogo operativo interno del proyecto.

4. `stat -c '%F|%U|%G|%a|%s|%y|%n' /opt/automation/agents/openclaw /opt/automation/agents/openclaw/compose /opt/automation/agents/openclaw/config /opt/automation/agents/openclaw/state /opt/automation/agents/openclaw/logs 2>/dev/null`
   Propósito: confirmar existencia, ownership y permisos de las rutas principales del runtime.

5. `find /opt/automation/agents/openclaw -maxdepth 2 -printf '%y|%M|%u|%g|%s|%TY-%Tm-%Td %TH:%TM|%p\n' 2>/dev/null | sort`
   Propósito: listar de forma prudente el árbol principal del runtime.

6. `find /opt/automation/agents/openclaw/broker -maxdepth 2 -printf '%y|%M|%u|%g|%s|%TY-%Tm-%Td %TH:%TM|%p\n' 2>/dev/null | sort`
   Propósito: confirmar artefactos de broker, auditoría y estado persistente.

7. `stat -c '%F|%U|%G|%a|%s|%y|%n' /etc/davlos/secrets/openclaw /usr/local/sbin/davlos-openclaw-readonly /etc/sudoers.d/davlos-openclaw-readonly 2>/dev/null`
   Propósito: verificar rutas sensibles sin leer secretos.

8. `find /etc/davlos/secrets/openclaw -maxdepth 2 -printf '%y|%M|%u|%g|%s|%TY-%Tm-%Td %TH:%TM|%p\n' 2>/dev/null | sort`
   Propósito: listar nombres y metadatos de ficheros de secretos sin mostrar contenido.

9. `docker ps -a --format '{{.ID}}|{{.Names}}|{{.Image}}|{{.Status}}|{{.Ports}}'`
   Propósito: listar contenedores relevantes.
   Resultado: falló por permisos del sandbox; reejecutado con elevación readonly.

10. `docker network ls --format '{{.ID}}|{{.Name}}|{{.Driver}}|{{.Scope}}'`
    Propósito: listar redes Docker.
    Resultado: falló por permisos del sandbox; reejecutado con elevación readonly.

11. `ss -lntp`
    Propósito: detectar listeners y binds visibles desde host.

12. `docker ps -a --format '{{.ID}}|{{.Names}}|{{.Image}}|{{.Status}}|{{.Ports}}'`
    Propósito: relanzar la consulta de contenedores con acceso readonly al daemon.

13. `docker network ls --format '{{.ID}}|{{.Name}}|{{.Driver}}|{{.Scope}}'`
    Propósito: relanzar la consulta de redes Docker con acceso readonly al daemon.

14. `curl -fsS --max-time 2 http://127.0.0.1:18789/healthz`
    Propósito: comprobar pasivamente el endpoint local del gateway.
    Resultado: falló dentro del sandbox; reejecutado con elevación readonly.

15. `curl -fsS --max-time 2 http://127.0.0.1:11440/healthz`
    Propósito: comprobar pasivamente el health del inference-gateway en loopback.
    Resultado: falló dentro del sandbox; reejecutado con elevación readonly.

16. `curl -fsS --max-time 2 http://172.22.0.1:11440/healthz`
    Propósito: comprobar pasivamente reachability desde la IP gateway de `agents_net`.
    Resultado: falló dentro del sandbox; reejecutado con elevación readonly.

17. `systemctl is-active inference-gateway.service && systemctl status inference-gateway.service --no-pager && systemctl cat inference-gateway.service`
    Propósito: verificar existencia, estado y definición de la unit del gateway de inferencia.

18. `systemctl is-active openclaw-telegram-bot.service && systemctl status openclaw-telegram-bot.service --no-pager && systemctl cat openclaw-telegram-bot.service`
    Propósito: verificar existencia, estado y definición de la unit de Telegram.

19. `docker network inspect agents_net --format '{{.Name}}|{{json .IPAM.Config}}|{{json .Containers}}'`
    Propósito: confirmar subnet, gateway y contenedores conectados a `agents_net`.

20. `docker network inspect verity_network --format '{{.Name}}|{{json .IPAM.Config}}|{{json .Containers}}'`
    Propósito: contrastar la separación visible frente a `verity_network`.

21. `docker inspect openclaw-gateway --format '{{.Name}}|{{.State.Status}}|{{json .State.Health}}|{{json .NetworkSettings.Networks}}|{{json .HostConfig.PortBindings}}'`
    Propósito: confirmar estado del contenedor, health, redes y published ports.

22. `docker inspect openclaw-gateway --format '{{.Name}}|ReadonlyRootfs={{.HostConfig.ReadonlyRootfs}}|CapDrop={{json .HostConfig.CapDrop}}|SecurityOpt={{json .HostConfig.SecurityOpt}}|Mounts={{json .Mounts}}'`
    Propósito: confirmar hardening base y mounts efectivos del contenedor.

23. `curl -fsS --max-time 2 http://127.0.0.1:18789/healthz`
    Propósito: relanzar comprobación pasiva del bind local de OpenClaw con acceso fuera del sandbox.

24. `curl -fsS --max-time 2 http://127.0.0.1:11440/healthz`
    Propósito: relanzar comprobación pasiva del inference-gateway en loopback.

25. `curl -fsS --max-time 2 http://172.22.0.1:11440/healthz`
    Propósito: relanzar comprobación pasiva de reachability por la IP de `agents_net`.

26. `rg -n '172\.22\.0\.1:11440|127\.0\.0\.1:18789|agents_net|cap_drop|no-new-privileges|/run/secrets/openclaw|/workspace/config|/workspace/state|/workspace/logs' /opt/automation/agents/openclaw/compose/docker-compose.yaml /opt/automation/agents/openclaw/config/openclaw.json`
    Propósito: contrastar el contrato real de compose/config sin leer secretos.

27. `stat -c '%F|%U|%G|%a|%s|%y|%n' /opt/automation/inference-gateway /opt/automation/inference-gateway/bin/ollama-proxy.py /opt/automation/inference-gateway/host.env /etc/systemd/system/inference-gateway.service /etc/systemd/system/openclaw-telegram-bot.service 2>/dev/null`
    Propósito: recoger metadatos del runtime y de las unit files relacionadas.

28. `rg -n '11440|11434|ollama|healthz|127\.0\.0\.1|172\.22\.0\.1' /opt/automation/inference-gateway/bin/ollama-proxy.py`
    Propósito: verificar binds y upstream del proxy sin leer secretos del `host.env`.

29. `docker inspect openclaw-gateway --format '{{json .Config.Healthcheck}}'`
    Propósito: entender el healthcheck real del contenedor.

30. `nl -ba /opt/control-plane/README.md | sed -n '45,90p'`
    Propósito: extraer el checkpoint documental principal a contrastar.

31. `nl -ba /opt/control-plane/docs/AGENTS.md | sed -n '1,140p'`
    Propósito: revisar el contrato operativo histórico y detectar claims obsoletos.

32. `nl -ba /opt/control-plane/docs/OPENCLAW_SECURITY_BOOTSTRAP_MVP.md | sed -n '1,120p'`
    Propósito: contrastar el contrato mínimo de seguridad del boundary.

33. `nl -ba /opt/control-plane/docs/TELEGRAM_OPENCLAW_RUNTIME_FINAL.md | sed -n '1,130p'`
    Propósito: contrastar el claim documental del runtime persistente de Telegram.
