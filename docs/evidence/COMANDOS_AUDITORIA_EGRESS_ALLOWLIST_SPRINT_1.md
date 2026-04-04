# COMANDOS_AUDITORIA_EGRESS_ALLOWLIST_SPRINT_1.md

## Nota

Todos los comandos de esta auditoría fueron de inspección readonly. No se modificó ninguna regla de `UFW`, `iptables`, Docker o `systemd`, y no se lanzaron probes a Internet pública desde el contenedor.

## Comandos ejecutados en orden

1. `sed -n '1,260p' README.md`
   Propósito: releer las reglas base del proyecto antes de continuar la tarea.

2. `sed -n '1,260p' AGENTS.md`
   Propósito: releer la política operativa específica del repo.

3. `find . -name 'SKILLS.md' -o -name 'skills.md'`
   Propósito: verificar si el repo contiene el `SKILLS.md` pedido antes de editar.
   Resultado: no se encontró ningún `SKILLS.md` en el árbol del repo.

4. `sed -n '1,260p' AGENTS_OBSI_CLAW_DAVLOS_VPS.md`
   Propósito: releer la política ampliada de agentes específica del proyecto.

5. `sed -n '1,320p' SKILLS_OBSI_CLAW_DAVLOS_VPS.md`
   Propósito: releer el catálogo operativo de skills deseadas y sus restricciones.

6. `sed -n '1,260p' docs/evidence/AUDITORIA_HOST_BOUNDARY_SPRINT_1.md`
   Propósito: recuperar la baseline host-side ya confirmada del boundary OpenClaw.

7. `sed -n '1,260p' docs/evidence/VALIDACION_HELPER_READONLY_SPRINT_1.md`
   Propósito: reutilizar la validación previa del helper readonly como fuente segura de contexto.

8. `sed -n '1,260p' docs/evidence/VALIDACION_BROKER_RESTRINGIDO_SPRINT_1.md`
   Propósito: recuperar el estado previo del broker restringido dentro del Sprint 1.

9. `sed -n '1,220p' docs/evidence/PRUEBA_FUNCIONAL_READONLY_BROKER_SPRINT_1.md`
   Propósito: confirmar el paso ya cerrado antes de abrir la auditoría específica de egress.

10. `sed -n '1,260p' docs/sprints/SPRINT_1.md`
   Propósito: recuperar el objetivo exacto del sprint y el siguiente paso declarado.

11. `sed -n '1,260p' docs/GAP_ANALYSIS_SPRINT_1.md`
   Propósito: confirmar cómo estaba clasificado el gap de `egress/allowlist` antes de esta auditoría.

12. `sed -n '1,220p' docs/BACKLOG_MOSCOW_SPRINT_1.md`
   Propósito: verificar la tarea pendiente específica asociada al Sprint 1.

13. `ss -lntp`
   Propósito: identificar listeners host-side relevantes para el boundary y posibles superficies accesibles desde `agents_net`.

14. `sed -n '1,260p' /opt/automation/agents/openclaw/compose/docker-compose.yaml`
   Propósito: revisar el contrato runtime real de redes, puertos y mounts.

15. `sed -n '1,260p' /opt/automation/agents/openclaw/config/openclaw.json`
   Propósito: confirmar el upstream efectivo configurado para OpenClaw.

16. `docker inspect openclaw-gateway --format '{{.Name}}|{{.State.Status}}|{{json .NetworkSettings.Networks}}|{{json .HostConfig.PortBindings}}|NetworkMode={{.HostConfig.NetworkMode}}|Dns={{json .HostConfig.DNS}}|ExtraHosts={{json .HostConfig.ExtraHosts}}'`
    Propósito: verificar el cableado real de red y publicación de puertos del contenedor.

17. `docker network inspect agents_net --format '{{.Name}}|{{json .IPAM.Config}}|{{json .Containers}}'`
    Propósito: confirmar subnet, gateway y contenedores conectados a `agents_net`.

18. `iptables -vnL`
    Propósito: obtener una vista global inicial de las reglas `filter` relevantes para el boundary.

19. `iptables -t nat -vnL`
    Propósito: obtener una vista global inicial de `nat` y detectar `DNAT`/`MASQUERADE` relevantes.

20. `iptables -vnL FORWARD`
    Propósito: focalizar el camino real de forwarding que afecta a `agents_net`.

21. `iptables -vnL DOCKER-USER`
    Propósito: comprobar si existe capa explícita de restricción de egress en Docker.

22. `iptables -vnL DOCKER-FORWARD`
    Propósito: comprobar si Docker está aceptando forwarding amplio desde la bridge de OpenClaw.

23. `iptables -vnL ufw-user-input`
    Propósito: revisar únicamente las reglas UFW de entrada relevantes para `172.22.0.0/16`.

24. `iptables -t nat -vnL POSTROUTING`
    Propósito: verificar si `agents_net` usa `MASQUERADE` al salir del bridge.

25. `ufw status numbered`
    Propósito: confirmar estado activo de `UFW` y reglas visibles relacionadas con `172.22.0.0/16`, `11434/tcp` y `11440/tcp`.

26. `ufw status verbose`
    Propósito: intentar extraer postura detallada de UFW.
    Resultado: falló dentro del sandbox con `Couldn't determine iptables version`; no era imprescindible para concluir.

27. `iptables --version`
    Propósito: intentar confirmar la variante exacta del frontend `iptables`.
    Resultado: falló dentro del sandbox con `Failed to initialize nft: Operation not permitted`; no era imprescindible para concluir.

28. `rg -n 'egress|allowlist|deny|ufw|iptables|172\.22\.0\.1:11440|127\.0\.0\.1:18789|network|ports|extra_hosts|dns|cap_drop|security_opt|no-new-privileges' /opt/control-plane/README.md /opt/control-plane/docs /opt/control-plane/scripts /opt/control-plane/templates /opt/automation/agents/openclaw/compose/docker-compose.yaml /opt/automation/agents/openclaw/config/openclaw.json 2>/dev/null`
    Propósito: localizar rápidamente los documentos y artefactos de referencia que hablan de `egress/allowlist` o del contrato de red observado.

29. `nl -ba /opt/control-plane/README.md | sed -n '50,110p'`
    Propósito: contrastar el checkpoint documental principal sobre `agents_net`, `172.22.0.1:11440`, `127.0.0.1:18789` y el estado declarado del hardening de egress.

30. `test -f /opt/control-plane/docs/AGENTS.md && sed -n '1,220p' /opt/control-plane/docs/AGENTS.md || true`
    Propósito: revisar el contrato operativo histórico de `control-plane` y detectar claims desalineados o útiles para egress.

31. `nl -ba /opt/control-plane/docs/AGENT_ZONE_EGRESS_ALLOWLIST_MVP.md | sed -n '1,220p'`
    Propósito: contrastar la política prevista de allowlist con el estado real observado.

32. `nl -ba /opt/control-plane/docs/OPENCLAW_SECURITY_BOOTSTRAP_MVP.md | sed -n '1,160p'`
    Propósito: contrastar la política MVP de red/egress deseada con la postura efectiva del host.

33. `nl -ba /opt/control-plane/docs/reports/OPENCLAW_PHASE_9_TIMEBOXED_HARDENING_2026-04-01.md | sed -n '1,120p'`
    Propósito: confirmar si la propia evidencia histórica de `control-plane` ya dejaba abierto este gap.

34. `nl -ba /opt/control-plane/docs/reports/OPENCLAW_BOUNDARY_RUNTIME_FIX_2026-04-01.md | sed -n '140,190p'`
    Propósito: revisar el hallazgo histórico sobre reachability desde `openclaw-gateway` hacia `172.22.0.1:11440`.
