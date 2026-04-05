# OPENCLAW_EGRESS_CHANGE_CHECKLIST_SPRINT_2.md

## Prechecks

- [ ] `agents_net` sigue siendo `172.22.0.0/16` con gateway `172.22.0.1`
- [ ] `openclaw-gateway` sigue vivo en `agents_net`
- [ ] `172.22.0.1:11440/healthz` responde desde host
- [ ] `openclaw-gateway` alcanza `172.22.0.1:11440/tcp`
- [ ] `DOCKER-USER` no contiene reglas ajenas no evaluadas
- [ ] existe ventana de cambio con root y rollback inmediato
- [ ] el directorio `/var/backups/openclaw-egress/` es utilizable

## Ejecución prevista

- [ ] `sudo bash scripts/hardening/openclaw_egress_allowlist.sh plan`
- [ ] revision humana del plan y de `iptables -S DOCKER-USER`
- [ ] `sudo bash scripts/hardening/openclaw_egress_allowlist.sh apply`
- [ ] `sudo bash scripts/hardening/openclaw_egress_allowlist.sh verify`

## Validación post-cambio

- [ ] `iptables -S DOCKER-USER`
- [ ] `iptables -S OPENCLAW-EGRESS`
- [ ] `172.22.0.1:11440` sigue reachable desde `openclaw-gateway`
- [ ] una prueba negativa controlada confirma bloqueo de egress no aprobado
- [ ] se guarda evidencia textual del before/after

## Rollback corto

- [ ] `sudo bash scripts/hardening/openclaw_egress_allowlist.sh rollback`
- [ ] el salto `DOCKER-USER -> OPENCLAW-EGRESS` desaparece
- [ ] la cadena `OPENCLAW-EGRESS` ya no existe
- [ ] `172.22.0.1:11440` vuelve a validar tras rollback
- [ ] se anota el backup generado durante rollback

## Fuera del Sprint 2

- [ ] no reabrir `11434` sin evidencia host-side
- [ ] no abrir DNS ni HTTPS saliente generico
- [ ] no tocar Syncthing, vault canonico ni Obsidian operativo
