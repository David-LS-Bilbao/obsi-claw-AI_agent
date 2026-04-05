# VALIDACION_EGRESS_ALLOWLIST_SPRINT_2_2026-04-05.md

## Propósito

Dejar una evidencia textual corta y suficiente del estado final verificado de `egress/allowlist` al cierre de Sprint 2.

Fecha de validación:

- `2026-04-05`

## Hechos confirmados

- `agents_net` sigue siendo `172.22.0.0/16` con gateway `172.22.0.1`;
- `scripts/hardening/openclaw_egress_allowlist.sh plan` pasa;
- `scripts/hardening/openclaw_egress_allowlist.sh verify` pasa;
- `DOCKER-USER` salta a `OPENCLAW-EGRESS` para `172.22.0.0/16`;
- `OPENCLAW-EGRESS` permite `ESTABLISHED,RELATED`;
- `OPENCLAW-EGRESS` permite `172.22.0.1:11440/tcp`;
- `OPENCLAW-EGRESS` termina en `DROP`;
- `openclaw-gateway` alcanza `http://172.22.0.1:11440/healthz`;
- una prueba negativa controlada a `1.1.1.1:443/tcp` queda bloqueada por timeout;
- `curl http://127.0.0.1:11440/healthz` sigue respondiendo `status=ok` en host.

## Comandos ejecutados

### Validación estructural

```bash
bash scripts/hardening/openclaw_egress_allowlist.sh plan
bash scripts/hardening/openclaw_egress_allowlist.sh verify
iptables -S DOCKER-USER
iptables -S OPENCLAW-EGRESS
```

### Validación funcional positiva

```bash
docker exec openclaw-gateway node -e "const http=require('http'); const req=http.get('http://172.22.0.1:11440/healthz',(res)=>{let data=''; res.on('data',(c)=>data+=c); res.on('end',()=>{console.log('ALLOW_OK',res.statusCode,data.trim()); process.exit(0);});}); req.on('error',(err)=>{console.error('ALLOW_ERR',err.code||err.message); process.exit(1);}); req.setTimeout(2000,()=>{console.error('ALLOW_TIMEOUT'); req.destroy(); process.exit(2);});"
curl -fsS --max-time 2 http://127.0.0.1:11440/healthz
```

### Validación funcional negativa controlada

```bash
docker exec openclaw-gateway node -e "const net=require('net'); const socket=net.connect({host:'1.1.1.1',port:443}); socket.on('connect',()=>{console.log('BLOCK_FAIL_CONNECT'); socket.end(); process.exit(1);}); socket.on('error',(err)=>{console.log('BLOCK_OK',err.code||err.message); process.exit(0);}); socket.setTimeout(2000,()=>{console.log('BLOCK_OK','TIMEOUT'); socket.destroy(); process.exit(0);});"
```

## Salida relevante observada

### `verify`

```text
-N DOCKER-USER
-A DOCKER-USER -s 172.22.0.0/16 -j OPENCLAW-EGRESS

-N OPENCLAW-EGRESS
-A OPENCLAW-EGRESS -m comment --comment openclaw-egress-allowlist -m conntrack --ctstate RELATED,ESTABLISHED -j RETURN
-A OPENCLAW-EGRESS -d 172.22.0.1/32 -p tcp -m comment --comment openclaw-egress-allowlist -m tcp --dport 11440 -j RETURN
-A OPENCLAW-EGRESS -m comment --comment openclaw-egress-allowlist -j DROP
```

### Prueba positiva

```text
ALLOW_OK 200 {"status": "ok", "northbound_api": "minimal_openai_compatible_v1", "upstream": "ollama", "allowed_model": "qwen2.5:3b"}
```

### Prueba negativa

```text
BLOCK_OK TIMEOUT
```

## Juicio técnico

Con esta validación, el cierre de Sprint 2 queda soportado así:

- existe enforcement explícito de egress para `agents_net`;
- la ruta baseline aprobada a `172.22.0.1:11440/tcp` sigue operativa;
- el bloqueo de salida no aprobada queda probado al menos para `1.1.1.1:443/tcp`;
- no hizo falta rollback en esta validación final.
