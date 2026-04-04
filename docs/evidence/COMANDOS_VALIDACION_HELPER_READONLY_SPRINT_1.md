# COMANDOS_VALIDACION_HELPER_READONLY_SPRINT_1.md

## Nota

Todos los comandos de esta validación fueron de inspección o ejecución readonly. No se modificó ninguna configuración, servicio, secreto ni artefacto fuera del repo del proyecto.

## Comandos ejecutados en orden

1. `stat -c '%F|%U|%G|%a|%s|%y|%n' /usr/local/sbin/davlos-openclaw-readonly /etc/sudoers.d/davlos-openclaw-readonly 2>/dev/null`
   Propósito: confirmar metadatos del helper y de su entrada `sudoers`.

2. `file /usr/local/sbin/davlos-openclaw-readonly /etc/sudoers.d/davlos-openclaw-readonly`
   Propósito: identificar el tipo de artefacto.

3. `sed -n '1,140p' /usr/local/sbin/davlos-openclaw-readonly`
   Propósito: inspección estática de cabecera, uso y dependencias.

4. `sed -n '1,120p' /etc/sudoers.d/davlos-openclaw-readonly`
   Propósito: verificar el cableado restrictivo de `sudoers`.

5. `rg -n "usage|runtime_summary|broker_state_console|broker_audit_recent|telegram_runtime_status|choose_policy|read_text|write|unlink|rm |mv |cp |systemctl|docker|journalctl|sudo|chmod|chown|touch|mkdir|open\\(|append|truncate|Path\\(|exists\\(|tail|audit" /usr/local/sbin/davlos-openclaw-readonly`
   Propósito: localizar interfaz, rutas de lectura y posibles señales de mutación.

6. `sed -n '141,320p' /usr/local/sbin/davlos-openclaw-readonly`
   Propósito: inspección estática del cuerpo y del `case` final.

7. `head -n 1 /usr/local/sbin/davlos-openclaw-readonly && tail -n 40 /usr/local/sbin/davlos-openclaw-readonly`
   Propósito: confirmar shebang y cierre del script.

8. `stat -c '%F|%U|%G|%a|%s|%y|%n' /usr/bin/python3 /usr/bin/date /opt/automation/agents/openclaw/broker/restricted_operator_policy.json /opt/control-plane/templates/openclaw/restricted_operator_policy.json 2>/dev/null`
   Propósito: verificar dependencias y rutas hardcodeadas críticas.

9. `timeout 2s /usr/local/sbin/davlos-openclaw-readonly --help`
   Propósito: descubrimiento pasivo de interfaz.

10. `timeout 2s /usr/local/sbin/davlos-openclaw-readonly -h`
    Propósito: descubrimiento pasivo de interfaz.

11. `timeout 2s /usr/local/sbin/davlos-openclaw-readonly help`
    Propósito: descubrimiento pasivo de interfaz.

12. `timeout 2s /usr/local/sbin/davlos-openclaw-readonly --version`
    Propósito: comprobar si expone versión o solo uso.

13. `id devops`
    Propósito: confirmar existencia del usuario previsto para la vía `sudo`.

14. `timeout 3s /usr/local/sbin/davlos-openclaw-readonly runtime_summary`
    Propósito: validar el modo readonly `runtime_summary`.

15. `timeout 3s /usr/local/sbin/davlos-openclaw-readonly broker_state_console`
    Propósito: validar el modo readonly `broker_state_console`.

16. `timeout 3s /usr/local/sbin/davlos-openclaw-readonly broker_audit_recent`
    Propósito: validar el modo readonly `broker_audit_recent`.

17. `timeout 3s /usr/local/sbin/davlos-openclaw-readonly telegram_runtime_status`
    Propósito: validar el modo readonly `telegram_runtime_status`.

18. `runuser -u devops -- sudo -n /usr/local/sbin/davlos-openclaw-readonly runtime_summary`
    Propósito: comprobar la ruta operativa prevista `devops -> sudo` sobre un modo readonly.
