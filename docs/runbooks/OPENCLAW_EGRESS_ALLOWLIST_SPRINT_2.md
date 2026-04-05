# OPENCLAW_EGRESS_ALLOWLIST_SPRINT_2.md

## Propósito

Aplicar el primer hardening real y reversible de `egress/allowlist` para `agents_net` sin replatforming del runtime ni cambios amplios sobre Docker, `systemd` o UFW.

## Estado

Preparado en este repositorio como runbook y script local.

Sigue `pendiente de verificación en host` hasta ejecutarse en una ventana operativa controlada.

## Cambio mínimo propuesto

Materializar una capa explícita en `DOCKER-USER` que:

- afecte solo a tráfico originado en `agents_net`;
- permita `ESTABLISHED,RELATED`;
- permita solo `172.22.0.1:11440/tcp` como upstream baseline aprobado;
- bloquee el resto del egress de `agents_net`.

Decisión actual:

- `11434/tcp` directo queda fuera por defecto;
- solo se reabre si aparece evidencia host-side nueva de que sigue siendo estrictamente necesario.

## Artefactos preparados

- `scripts/hardening/openclaw_egress_allowlist.sh`
- este runbook

## Alcance

- `DOCKER-USER`
- cadena dedicada `OPENCLAW-EGRESS`
- tráfico con origen `172.22.0.0/16`

## Exclusiones

- no cambia `docker-compose`;
- no toca el runtime OpenClaw;
- no modifica UFW;
- no introduce DNS ni HTTPS saliente genérico;
- no autoriza probes a Internet pública.

## Prechecks

Antes de aplicar en host:

1. Confirmar que `agents_net` sigue siendo `172.22.0.0/16` con gateway `172.22.0.1`.
2. Confirmar que `openclaw-gateway` sigue en esa red.
3. Confirmar que `172.22.0.1:11440/healthz` sigue siendo el único destino mínimo aprobado.
4. Revisar si `DOCKER-USER` contiene reglas ajenas a OpenClaw.
5. Asegurar acceso root y ventana con rollback inmediato.

## Backup

El script genera backup antes de `apply` y antes de `rollback` en:

- `/var/backups/openclaw-egress/`

Se guardan:

- `iptables-save`
- `docker network inspect agents_net`
- metadatos del cambio

## Ejecución prevista

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

## Validación mínima recomendada en host

Estructural:

- `iptables -S DOCKER-USER`
- `iptables -S OPENCLAW-EGRESS`

Funcional mínima:

- `docker exec openclaw-gateway node -e "fetch('http://172.22.0.1:11440/healthz').then(r => r.text()).then(t => console.log(t)).catch(err => { console.error(err); process.exit(1); })"`

Funcional negativa opcional:

- dejar cualquier prueba a Internet pública como `pendiente de verificación en host` si no existe ventana segura o justificación explícita.

## Rollback esperado

El rollback elimina solo lo introducido por este cambio:

- salto `DOCKER-USER -> OPENCLAW-EGRESS` para `agents_net`;
- cadena `OPENCLAW-EGRESS`.

No restaura de forma ciega un snapshot completo de firewall, aunque sí deja backup para auditoría manual.

## Riesgos y notas

- Si `DOCKER-USER` ya contiene reglas no previstas, el script debe abortar por defecto.
- Si `openclaw-gateway` necesitara realmente `11434/tcp` directo, este cambio podría romper reachability; por eso queda fuera del baseline y debe reabrirse solo con evidencia.
- Este runbook no cambia el estado semafórico por sí solo: `egress/allowlist` sigue en `ROJO` hasta validación host-side satisfactoria.

## Estado esperado si sale bien

- `agents_net` deja de depender solo de aislamiento parcial y pasa a tener enforcement explícito de salida;
- `172.22.0.1:11440/tcp` sigue operativo;
- el cambio es pequeño, localizado y reversible;
- el siguiente paso puede centrarse en decidir si `11434` directo se elimina definitivamente o se reautoriza con evidencia.
