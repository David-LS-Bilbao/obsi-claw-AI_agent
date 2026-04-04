# COMANDOS_PRUEBA_FUNCIONAL_READONLY_BROKER_SPRINT_1.md

Nota: en esta validación sí hubo una única ejecución funcional real del broker, limitada a una acción `readonly` sin parámetros y fuera de Telegram. No se ejecutó ninguna acción `restricted` ni se modificó configuración, runtime o servicios.

| Orden | Comando exacto | Propósito |
| --- | --- | --- |
| 1 | `rg -n "v1/actions/execute|BrokerRequest\\(|action.health.general.v1|action.logs.read.v1|RestrictedOperatorBroker\\(" /opt/control-plane/scripts /opt/control-plane/tests 2>/dev/null` | Localizar entrypoints reales del broker y referencias a acciones readonly |
| 2 | `sed -n '1,140p' /opt/control-plane/docs/BROKER_RESTRICTED_OPERATOR_MVP.md` | Contrastar la arquitectura documentada del broker |
| 3 | `sed -n '1,260p' /opt/control-plane/scripts/agents/openclaw/restricted_operator/actions.py` | Verificar implementación exacta de `HealthAction` y `LogsAction` |
| 4 | `sed -n '620,700p' /opt/control-plane/scripts/agents/openclaw/restricted_operator/telegram_bot.py` | Confirmar que Telegram llama al core `self.broker.execute(...)` |
| 5 | `sed -n '860,900p' /opt/control-plane/scripts/agents/openclaw/restricted_operator/telegram_bot.py` | Confirmar la misma llamada para `/execute` |
| 6 | `jq '{health_checks: .health_checks, log_streams: .log_streams}' /opt/automation/agents/openclaw/broker/restricted_operator_policy.json` | Verificar checks y streams permitidos por la policy runtime |
| 7 | `ss -lntp | rg ':18890\\b|:18789\\b|:11440\\b'` | Verificar listeners activos y descartar un server broker ya desplegado en `18890` |
| 8 | `runuser -u devops -- sudo -n /usr/local/sbin/davlos-openclaw-readonly broker_state_console` | Snapshot before del estado efectivo del broker |
| 9 | `runuser -u devops -- sudo -n /usr/local/sbin/davlos-openclaw-readonly broker_audit_recent` | Intento de snapshot before de auditoría por la vía `devops -> sudo`; falló por restricción de sandbox, sin implicar fallo del helper ni del broker |
| 10 | `/usr/local/sbin/davlos-openclaw-readonly broker_audit_recent` | Snapshot before de auditoría reciente |
| 11 | `timeout 5s python3 -c 'import json; from broker import RestrictedOperatorBroker; from models import BrokerRequest; policy="/opt/automation/agents/openclaw/broker/restricted_operator_policy.json"; result=RestrictedOperatorBroker(policy).execute(BrokerRequest(action_id="action.health.general.v1", params={}, actor="sprint1_readonly_probe")); print(json.dumps(result.to_dict(), sort_keys=True))'` | Única ejecución funcional readonly real del broker |
| 12 | `/usr/local/sbin/davlos-openclaw-readonly broker_state_console` | Snapshot after del estado efectivo del broker |
| 13 | `/usr/local/sbin/davlos-openclaw-readonly broker_audit_recent` | Snapshot after de auditoría reciente para confirmar el evento nuevo |
