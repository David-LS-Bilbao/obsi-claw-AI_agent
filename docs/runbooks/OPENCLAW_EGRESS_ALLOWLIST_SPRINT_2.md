# OPENCLAW_EGRESS_ALLOWLIST_SPRINT_2.md

## Objetivo

Preparar la ejecucion segura del primer hardening real y reversible de `egress/allowlist` para `agents_net`, sin replatforming del runtime ni cambios amplios sobre Docker, `systemd` o UFW.

## Estado

Runbook preparado en este repositorio junto al script local de cambio.

Sigue `pendiente de verificación en host` hasta ejecutarse en una ventana operativa controlada.

## Qué se toca

- cadena `DOCKER-USER`;
- cadena dedicada `OPENCLAW-EGRESS`;
- trafico con origen `172.22.0.0/16` en `agents_net`;
- enforcement de salida para `openclaw-gateway`.

## Qué no se toca

- no cambia `docker-compose`;
- no toca la configuracion de OpenClaw;
- no reinicia servicios;
- no modifica el runtime del helper readonly;
- no rediseña UFW;
- no abre DNS ni HTTPS saliente generico;
- no activa Syncthing ni el vault canonico;
- no toca produccion fuera del boundary OpenClaw.

## Baseline usada

### Hechos confirmados

- `agents_net` existe como bridge `172.22.0.0/16` y no es `internal`;
- `openclaw-gateway` corre en `172.22.0.2`;
- OpenClaw esta configurado contra `http://172.22.0.1:11440/v1`;
- `172.22.0.1:11440/tcp` responde y es reachable desde el contenedor;
- `DOCKER-USER` esta vacia;
- `DOCKER-FORWARD` permite salida desde `br-0759beecc34d`;
- existe `MASQUERADE` para `172.22.0.0/16`;
- se confirmo egress publico real desde `openclaw-gateway` hacia `1.1.1.1:443`.

### Hipótesis técnicas

- el endurecimiento minimo debe materializarse en `DOCKER-USER`, porque el gap confirmado esta en forwarding/NAT de Docker;
- `11434/tcp` no forma parte del baseline permitido mientras no aparezca evidencia nueva de necesidad real.

### Pendiente de verificación en host

- si existe alguna dependencia saliente legitima adicional;
- si `11434/tcp` debe conservarse por uso real vigente;
- si existe alguna persistencia externa que reinyecte permisividad tras reboot o redeploy.

## Cambio minimo propuesto

Materializar una capa explicita en `DOCKER-USER` que:

- afecte solo a tráfico originado en `agents_net`;
- permita `ESTABLISHED,RELATED`;
- permita solo `172.22.0.1:11440/tcp` como upstream baseline aprobado;
- bloquee el resto del egress de `agents_net`.

Decision actual:

- `11434/tcp` directo queda fuera por defecto;
- solo se reabre si aparece evidencia host-side nueva de que sigue siendo estrictamente necesario;
- toda salida publica no aprobada pasa a considerarse bloqueo esperado.

## Artefactos preparados

- `scripts/hardening/openclaw_egress_allowlist.sh`
- este runbook
- `docs/checklists/OPENCLAW_EGRESS_CHANGE_CHECKLIST_SPRINT_2.md`

## Alcance

- `DOCKER-USER`;
- cadena dedicada `OPENCLAW-EGRESS`;
- trafico con origen `172.22.0.0/16`.

## Prechecks

Checklist minima antes de aplicar en host:

- confirmar que `agents_net` sigue siendo `172.22.0.0/16` con gateway `172.22.0.1`;
- confirmar que `openclaw-gateway` sigue en esa red;
- confirmar que `172.22.0.1:11440/healthz` sigue operativo desde host y desde contenedor;
- revisar si `DOCKER-USER` contiene reglas ajenas a OpenClaw;
- asegurar acceso root y ventana con rollback inmediato;
- asegurar que el backup logico puede escribirse en `/var/backups/openclaw-egress/`.

## Backup lógico

El script genera backup antes de `apply` y antes de `rollback` en:

- `/var/backups/openclaw-egress/`

Se guardan:

- `iptables-save`
- `docker network inspect agents_net`
- metadatos del cambio

El backup es para auditoria y recuperacion manual del contexto, no para restauracion ciega de todo el firewall.

## Punto de inserción

- `DOCKER-USER`

Justificacion:

- se evalua antes de `DOCKER-FORWARD`;
- permite acotar el cambio al bridge de `agents_net`;
- es el punto donde hoy existe el gap real de enforcement.

## Ejecución prevista

Orden recomendado:

1. `plan`
2. revision humana del plan y de `DOCKER-USER`
3. `apply`
4. `verify`
5. validacion funcional corta
6. rollback inmediato si falla cualquier check critico

Modo plan:

```bash
sudo bash scripts/hardening/openclaw_egress_allowlist.sh plan
```

Aplicación:

```bash
sudo bash scripts/hardening/openclaw_egress_allowlist.sh apply
```

Verificación estructural:

```bash
sudo bash scripts/hardening/openclaw_egress_allowlist.sh verify
```

Rollback:

```bash
sudo bash scripts/hardening/openclaw_egress_allowlist.sh rollback
```

## Validación post-cambio

### Estructural

- `iptables -S DOCKER-USER`
- `iptables -S OPENCLAW-EGRESS`
- `sudo bash scripts/hardening/openclaw_egress_allowlist.sh verify`

### Funcional positiva minima

- `curl -fsS --max-time 2 http://172.22.0.1:11440/healthz`
- `docker exec openclaw-gateway node -e "const net=require('net'); const s=net.connect({host:'172.22.0.1',port:11440}); s.on('connect',()=>{console.log('connect-ok'); s.end(); process.exit(0)}); s.on('error',(e)=>{console.error(e.code||e.message); process.exit(1)}); setTimeout(()=>process.exit(2),2000)"`

### Funcional negativa controlada

- comprobar que un destino publico no aprobado deja de ser reachable desde el contenedor;
- ejemplo sugerido: `1.1.1.1:443/tcp`;
- ejecutar solo dentro de ventana controlada y dejar evidencia.

## Rollback corto

Si falla cualquier check critico:

1. ejecutar `sudo bash scripts/hardening/openclaw_egress_allowlist.sh rollback`;
2. confirmar que desaparece el salto `DOCKER-USER -> OPENCLAW-EGRESS`;
3. confirmar que la cadena `OPENCLAW-EGRESS` ya no existe;
4. revalidar reachability de `172.22.0.1:11440`;
5. guardar referencia del backup generado en rollback.

## Riesgos y notas

- Si `DOCKER-USER` ya contiene reglas no previstas, el script debe abortar por defecto.
- Si `openclaw-gateway` necesitara realmente `11434/tcp` directo, este cambio podria romper reachability; por eso queda fuera del baseline y debe reabrirse solo con evidencia.
- Si el nombre del bridge Docker cambia tras recrear la red, la evidencia y la validacion deben rehacerse antes de aplicar.
- Este runbook no cambia el estado semaforico por si solo: `egress/allowlist` sigue en `ROJO` hasta validacion host-side satisfactoria.

## Qué queda fuera del sprint

- rediseño completo de politicas UFW;
- allowlist general para otros bridges Docker;
- integracion operativa Obsidian o Syncthing;
- cambios de vault, ownership o sync multiplataforma;
- cualquier apertura adicional por conveniencia.

## Estado esperado si sale bien

- `agents_net` deja de depender solo de aislamiento parcial y pasa a tener enforcement explícito de salida;
- `172.22.0.1:11440/tcp` sigue operativo;
- el cambio es pequeño, localizado y reversible;
- el siguiente paso puede centrarse en decidir si `11434` directo se elimina definitivamente o se reautoriza con evidencia.
