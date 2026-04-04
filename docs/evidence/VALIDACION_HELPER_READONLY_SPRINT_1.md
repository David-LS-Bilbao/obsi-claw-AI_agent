# VALIDACION_HELPER_READONLY_SPRINT_1.md

## Resumen ejecutivo

El helper `/usr/local/sbin/davlos-openclaw-readonly` queda validado como interfaz readonly utilizable para observabilidad controlada del boundary OpenClaw. La validación confirma artefacto, cableado por `sudoers`, interfaz explícita de cuatro modos, ausencia visible de lógica mutante y ejecución correcta de todos los subcomandos listados, además de una comprobación por la vía prevista `devops -> sudo`.

No se han observado señales de escritura en disco, control de servicios ni llamadas a `docker` o `systemctl` dentro del helper. El principal límite no es de mutación, sino de alcance: solo cubre cuatro vistas concretas y expone metadatos operativos que deben tratarse como salida interna.

## Tabla de validación

| Bloque | Resultado | Evidencia | Observación |
| --- | --- | --- | --- |
| Artefacto | OK | Script Bash root-owned `0750`, shebang `#!/usr/bin/env bash` | Instalado correctamente |
| Cableado sudoers | OK | Alias con cuatro modos exactos y permiso `NOPASSWD` para `devops` | Cableado restrictivo y explícito |
| Dependencias | OK | `python3` y `date` existen; policy runtime y fallback presentes | Dependencias mínimas y visibles |
| Interfaz | OK | `Usage` explícito con cuatro subcomandos | No se observan flags avanzados ni inputs ambiguos |
| Lógica readonly | OK | Inspección estática solo muestra lecturas JSON, `Path.exists`, `read_text` y redacción de payload | No se observaron escrituras ni side effects |
| `runtime_summary` | OK | Salida consistente y rápida | Confirma policy, state, audit y telegram runtime |
| `broker_state_console` | OK | Salida consistente y rápida | Resume capacidades y estados efectivos |
| `broker_audit_recent` | OK | Salida consistente y rápida | Devuelve cola reciente de auditoría |
| `telegram_runtime_status` | OK | Salida consistente y rápida | Devuelve JSON redactado |
| Ruta `devops -> sudo` | OK parcial | `runtime_summary` ejecutado con `runuser -u devops -- sudo -n ...` | Cableado operativo confirmado al menos para un modo |

## Interfaz descubierta

Uso expuesto por el propio helper:

```text
Usage: /usr/local/sbin/davlos-openclaw-readonly {runtime_summary|broker_state_console|broker_audit_recent|telegram_runtime_status}
```

Subcomandos disponibles:

- `runtime_summary`
- `broker_state_console`
- `broker_audit_recent`
- `telegram_runtime_status`

## Clasificación final del helper

`VALIDADO READONLY`

## Riesgos o límites observados

- el helper requiere root; la vía prevista es `sudo` restringido para `devops`;
- la validación de la ruta `devops -> sudo` se comprobó funcionalmente en un modo, no en los cuatro;
- `broker_audit_recent` expone metadatos operativos como `operator_id`, eventos y errores; sigue siendo readonly, pero su salida no debe tratarse como material público;
- el helper no sustituye validaciones funcionales de broker o Telegram; solo mejora la observabilidad controlada.

## Decisión recomendada para el sprint

Tratar el helper como canal verde de observabilidad readonly y usarlo como vía preferente antes de inspecciones más sensibles del boundary.

Siguiente paso recomendado:

- preparar y ejecutar una verificación mínima no mutante del broker restringido, apoyándose en esta vía readonly ya validada.
