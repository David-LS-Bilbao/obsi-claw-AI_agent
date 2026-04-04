# COMANDOS_VALIDACION_BROKER_RESTRINGIDO_SPRINT_1.md

## Nota

Todos los comandos de esta validación fueron de inspección o ejecución readonly. No se enviaron acciones al broker ni se dispararon flujos mutantes.

## Comandos ejecutados en orden

1. `command -v jq || true`
   Propósito: confirmar disponibilidad de `jq` para inspección segura de JSON.

2. `stat -c '%F|%U|%G|%a|%s|%y|%n' /opt/automation/agents/openclaw/broker/restricted_operator_policy.json /opt/automation/agents/openclaw/broker/state/restricted_operator_state.json /opt/automation/agents/openclaw/broker/audit/restricted_operator.jsonl /opt/control-plane/templates/openclaw/restricted_operator_policy.json 2>/dev/null`
   Propósito: confirmar artefactos, permisos, tamaños y timestamps relevantes.

3. `cmp -s /opt/automation/agents/openclaw/broker/restricted_operator_policy.json /opt/control-plane/templates/openclaw/restricted_operator_policy.json && echo POLICY_MATCH || echo POLICY_DIFFERS`
   Propósito: verificar si la policy runtime difiere del template.

4. `sha256sum /opt/automation/agents/openclaw/broker/restricted_operator_policy.json /opt/control-plane/templates/openclaw/restricted_operator_policy.json`
   Propósito: obtener confirmación inequívoca de diferencia entre runtime y template.

5. `jq -c '{top_keys:(keys), action_count:(.actions|length), enabled_true:([.actions[] | .enabled // false] | map(select(.==true)) | length), enabled_false:([.actions[] | .enabled // false] | map(select(.==false)) | length), mode_counts:([.actions[] | (.mode // "unset")] | group_by(.) | map({mode:.[0], count:length})), broker_keys:(.broker|keys), telegram_enabled:(.telegram.enabled // null), telegram_allowed_chats_count:((.telegram.allowed_chats // {})|length), telegram_allowed_users_count:((.telegram.allowed_users // {})|length), operator_count:((.operators // {})|length), role_count:((.roles // {})|length)}' /opt/automation/agents/openclaw/broker/restricted_operator_policy.json`
   Propósito: resumir la policy runtime sin exponer datos sensibles.

6. `jq -c '{top_keys:(keys), action_count:(.actions|length), enabled_true:([.actions[] | .enabled // false] | map(select(.==true)) | length), enabled_false:([.actions[] | .enabled // false] | map(select(.==false)) | length), mode_counts:([.actions[] | (.mode // "unset")] | group_by(.) | map({mode:.[0], count:length})), broker_keys:(.broker|keys), telegram_enabled:(.telegram.enabled // null), telegram_allowed_chats_count:((.telegram.allowed_chats // {})|length), telegram_allowed_users_count:((.telegram.allowed_users // {})|length), operator_count:((.operators // {})|length), role_count:((.roles // {})|length)}' /opt/control-plane/templates/openclaw/restricted_operator_policy.json`
   Propósito: resumir el template fallback de forma comparable.

7. `jq -r '[.actions | keys[]] | join("\n")' /opt/automation/agents/openclaw/broker/restricted_operator_policy.json`
   Propósito: listar el catálogo de acciones visibles de la policy runtime.

8. `jq -c '{top_keys:(keys), action_ids:(.actions|keys), state_action_count:((.actions // {})|length), state_keys:(keys)}' /opt/automation/agents/openclaw/broker/state/restricted_operator_state.json`
   Propósito: confirmar que el state store contiene override runtime.

9. `timeout 3s runuser -u devops -- sudo -n /usr/local/sbin/davlos-openclaw-readonly runtime_summary`
   Propósito: confirmar por la vía prevista que la policy runtime, el state y la auditoría son visibles.

10. `timeout 3s runuser -u devops -- sudo -n /usr/local/sbin/davlos-openclaw-readonly broker_state_console`
    Propósito: observar el estado efectivo del catálogo de capacidades del broker.

11. `timeout 3s runuser -u devops -- sudo -n /usr/local/sbin/davlos-openclaw-readonly broker_audit_recent`
    Propósito: observar si la auditoría reciente existe y es coherente.

12. `comm -3 <(jq -r '.actions | keys[]' /opt/automation/agents/openclaw/broker/restricted_operator_policy.json | sort) <(jq -r '.actions | keys[]' /opt/control-plane/templates/openclaw/restricted_operator_policy.json | sort)`
    Propósito: comprobar si el set de acciones difiere entre runtime y template.

13. `jq -c '{telegram_enabled:(.telegram.enabled // null), state_store_path:(.broker.state_store_path // null), audit_log_path:(.broker.audit_log_path // null), bind_host:(.broker.bind_host // null), bind_port:(.broker.bind_port // null)}' /opt/automation/agents/openclaw/broker/restricted_operator_policy.json`
    Propósito: resumir campos de cableado runtime del broker.

14. `jq -c '{telegram_enabled:(.telegram.enabled // null), state_store_path:(.broker.state_store_path // null), audit_log_path:(.broker.audit_log_path // null), bind_host:(.broker.bind_host // null), bind_port:(.broker.bind_port // null)}' /opt/control-plane/templates/openclaw/restricted_operator_policy.json`
    Propósito: resumir los mismos campos en el template fallback.

15. `ss -lntp | rg ':18890\\b' || true`
    Propósito: comprobar pasivamente si el `bind_port` del broker aparece en escucha.

16. `ps -ef | rg 'restricted_operator|telegram_bot|run_telegram_bot' | rg -v 'rg '`
    Propósito: buscar procesos visibles asociados al broker o Telegram.

17. `find /opt/automation/agents/openclaw/broker -maxdepth 2 -printf '%y|%M|%u|%g|%s|%TY-%Tm-%Td %TH:%TM|%p\n' 2>/dev/null | sort`
    Propósito: confirmar el árbol actual de artefactos del broker.

18. `rg -n 'bind_port|restricted_operator_policy|server.py|broker_state|audit_log_path|state_store_path|telegram_runtime_status|telegram_bot.py|from .*broker|import .*broker' /opt/control-plane/scripts/agents/openclaw/restricted_operator /opt/control-plane/templates/openclaw 2>/dev/null`
    Propósito: comprobar de forma estática si el flujo actual usa el broker como componente real y no solo documental.

19. `find /opt/control-plane/scripts/agents/openclaw/restricted_operator -maxdepth 1 -type f | sort`
    Propósito: confirmar los artefactos de código del restricted operator presentes en `control-plane`.
