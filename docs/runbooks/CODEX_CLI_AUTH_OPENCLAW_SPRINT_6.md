# RUNBOOK — Autenticación Codex CLI y integración con OpenClaw
**Sprint:** 6  
**Fecha:** 2026-04-08  
**Autor:** Antigravity  
**Estado:** HITL — requiere VPN activa y presencia del operador  
**Versión Codex CLI verificada en host:** `codex-cli 0.118.0`

---

## 1. Propósito

Autenticar el `codex-cli` ya instalado en el VPS con la cuenta de ChatGPT del operador
y validar que OpenClaw puede usar Codex como proveedor de IA mediante OAuth,
sin necesidad de API key de pago de `platform.openai.com`.

---

## 2. Prerrequisitos

- [ ] VPN WireGuard activa (`10.90.0.1` alcanzable desde la máquina local)
- [ ] SSH operativo como `devops@10.90.0.1`
- [ ] `codex-cli 0.118.0` confirmado en VPS (`codex --version`)
- [ ] Cuenta ChatGPT Plus o con acceso Codex activo
- [ ] Navegador disponible en la máquina local para completar el flujo OAuth
- [ ] Bloqueos 1 y 2 resueltos (owner de STAGED_INPUT y grupo systemd-journal)
  — si no están resueltos, completar primero `RUNBOOK_REMEDIACION_BLOQUEOS_SPRINT_6.md`

---

## 3. Riesgo

| Riesgo | Nivel | Mitigación |
|:---|:---|:---|
| El token OAuth expira (vida ~24-72h) | Medio | Monitorear con heartbeat; renovar manualmente |
| Contenido del agente sale a `chatgpt.com` | Medio | No procesar datos sensibles hasta definir política |
| El flujo OAuth requiere HTTPS y redirección | Bajo | Tunelizar si el VPS no tiene GUI |
| El token se almacena en el filesystem del VPS | Bajo | Verificar permisos del fichero de credenciales |

---

## 4. Egress que se abre

Antes de ejecutar, verificar que `chatgpt.com:443` esté permitido en UFW o añadirlo:

```bash
# Verificar estado actual
sudo ufw status numbered | grep -E "443|chatgpt"

# Si no está, añadir (HITL obligatorio):
sudo ufw allow out to any port 443 proto tcp comment "HTTPS egress general"
# O si se quiere acotar a chatgpt.com (requiere resolución DNS previa):
# sudo ufw allow out to 104.18.0.0/16 port 443 proto tcp
```

> **Nota:** Si ya existe una regla UFW para HTTPS saliente genérica, no es necesario añadir nada.  
> `pendiente de verificación en host` — estado actual de UFW no confirmado en esta sesión.

---

## 5. Paso 1 — Autenticar Codex CLI con ChatGPT OAuth

```bash
ssh devops@10.90.0.1
codex login
```

El comando abrirá un flujo OAuth que generará una URL.  
Copiar esa URL en el navegador de tu máquina local para autenticarte con tu cuenta ChatGPT.

Si el entorno no tiene display, el flujo es:
```bash
codex login --no-browser
# El CLI mostrará una URL. Abrirla en el navegador local.
# Tras autenticarte, pegará un código de vuelta en la terminal.
```

### Verificación Paso 1
```bash
codex auth status
# Debe mostrar: logged in as <tu email>
```

---

## 6. Paso 2 — Primer test de inferencia con Codex

Con la autenticación activa, verificar que el modelo responde:

```bash
echo "Di 'hola' en JSON con campo 'mensaje'" | codex -q
```

Salida esperada (aproximada):
```json
{"mensaje": "hola"}
```

> Si falla con error de autorización, el OAuth no completó bien. Repetir Paso 1.  
> Si falla con timeout de red, revisar egress UFW para `chatgpt.com:443`.

---

## 7. Paso 3 — Localizar el fichero de credenciales de Codex

El token OAuth se almacena en disco. Verificar ubicación y permisos:

```bash
# Ubicaciones habituales de codex-cli:
ls -la ~/.codex/
ls -la ~/.config/codex/
ls -la ~/.local/share/codex/

# Buscar fichero de auth/token:
find ~ -name "*.json" -path "*/codex/*" 2>/dev/null | head -10
```

Verificar que el fichero de credenciales solo sea legible por `devops`:
```bash
# Si no, corregir:
chmod 600 ~/.codex/auth.json  # ajustar ruta real
```

---

## 8. Paso 4 — Integración con OpenClaw Gateway

OpenClaw puede configurarse para usar Codex como proveedor primario o secundario.

### Opción A — Codex como proveedor secundario (failover respecto a Ollama local)

En el fichero `/opt/openclaw/config/openclaw.json` o equivalente:

```json
{
  "agents": {
    "defaults": {
      "model": {
        "primary": "ollama/qwen2.5:3b",
        "fallback": ["openai-codex/gpt-5.4"]
      }
    }
  }
}
```

> `pendiente de verificación en host` — ruta exacta del openclaw.json y su estructura actual.

### Opción B — Codex como proveedor primario

```json
{
  "agents": {
    "defaults": {
      "model": {
        "primary": "openai-codex/gpt-5.4"
      }
    }
  }
}
```

### Verificación Paso 4
```bash
sudo systemctl restart openclaw-gateway.service
# O equivalente según el nombre del servicio en este VPS
journalctl -u openclaw-gateway.service -n 30 --no-pager
```

---

## 9. Paso 5 — Verificación end-to-end

Enviar un mensaje por Telegram al bot (si el canal está activo):
```
/status
```

O ejecutar un draft de prueba:
```bash
systemctl start openclaw-draft-writer.service
# Verificar que el draft generado en Agent/Drafts_Agent/ usa el nuevo modelo
```

---

## 10. Rollback

Si algo sale mal:

```bash
# Revertir openclaw.json a modelo Ollama local
# (editar el fichero y reiniciar el gateway)

# Desautenticar Codex si es necesario:
codex logout
# o eliminar el fichero de credenciales manualmente
```

---

## 11. Estado post-ejecución esperado

- `codex auth status` → logged in
- OpenClaw draft writer usando `openai-codex/gpt-5.4` como modelo
- Heartbeat incluye campo `ai_provider: codex-oauth`
- `pendiente de verificación en host` — ruta real del openclaw.json y nombre exacto del servicio gateway

---

## 12. Siguiente paso recomendado

Si este runbook tiene éxito:
- Documentar en `ESTADO_GLOBAL.md`: proveedor de IA = `openai-codex/gpt-5.4` vía OAuth
- Abrir ADR sobre estrategia de renovación del token OAuth
- Evaluar si se activa Codex Spark (`openai-codex/gpt-5.3-codex-spark`) si tu cuenta tiene acceso
