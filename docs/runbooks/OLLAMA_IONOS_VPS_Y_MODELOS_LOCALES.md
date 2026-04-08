# OLLAMA EN VPS IONOS: DIMENSIONAMIENTO Y MODELOS RECOMENDADOS

**Fecha:** 2026-04-08

## Alcance

Este documento resume qué tipos de VPS de IONOS encajan mejor con inferencia local mediante Ollama y qué familias de modelos resultan más razonables para cada perfil. El foco principal es el encaje operativo para DAVLOS y para un uso futuro con OpenClaw, sin activar cambios de arquitectura ni introducir despliegues nuevos en este paso.

## Estado de referencia actual de DAVLOS

En la validación host-side reciente, DAVLOS presenta este perfil:

- VPS KVM sobre Ubuntu 24.04.4 LTS
- `6 vCPU`
- `7.7 GiB` de RAM total
- `4 GiB` de swap
- almacenamiento raíz con margen suficiente
- sin GPU NVIDIA
- Ollama `0.17.7`
- modelo local instalado: `qwen2.5:3b`

Conclusión base: DAVLOS es un host de inferencia **CPU-only** y hoy está bien alineado con modelos pequeños. No es un host prudente para Gemma 4 E4B como modelo principal local.

## Premisas de dimensionamiento

Para recomendar un VPS no basta con mirar el tamaño del modelo en disco. También hay que reservar margen para:

- sistema operativo
- cachés y page cache
- swap como red de seguridad, no como memoria de trabajo
- WireGuard, Syncthing y otros servicios del host
- contenedores y procesos auxiliares si el mismo VPS también aloja OpenClaw
- prompts largos, sesiones concurrentes y latencia aceptable

En este documento se usan dos criterios:

- **encaja**: el modelo puede funcionar de forma razonable sin depender estructuralmente de swap
- **óptimo**: el modelo deja margen suficiente para operar el VPS con estabilidad y latencia aceptables

## Referencias de modelos Ollama consideradas

Se toman como referencia tamaños publicados por la librería oficial de Ollama:

- `gemma3:1b` → `815 MB`
- `qwen2.5:3b` → `1.9 GB`
- `gemma3:4b` → `3.3 GB`
- `qwen2.5-coder:7b` → `4.7 GB`
- `gemma4:e2b` → `7.2 GB`
- `gemma4:e4b` → `9.6 GB`
- `qwen2.5:14b` → `9.0 GB`

## Planes VPS IONOS considerados

Se toman como base los planes VPS públicos actuales de IONOS:

- `VPS XS` → `1 vCore`, `1 GB RAM`, `10 GB NVMe`
- `VPS S` → `2 vCores`, `2 GB RAM`, `80 GB NVMe`
- `VPS M` → `2 vCores`, `4 GB RAM`, `120 GB NVMe`
- `VPS L` → `4 vCores`, `8 GB RAM`, `240 GB NVMe`
- `VPS XL` → `8 vCores`, `16 GB RAM`, `480 GB NVMe`
- `VPS XXL` → `12 vCores`, `24 GB RAM`, `720 GB NVMe`

## Tabla de encaje por tipo de VPS

| VPS | Características | Modelo local óptimo | Máximo prudente | Valoración operativa |
| --- | --- | --- | --- | --- |
| `VPS XS` | `1 vCore`, `1 GB RAM`, `10 GB NVMe` | ninguno para uso serio | `gemma3:1b` solo como prueba mínima | No recomendable para Ollama útil |
| `VPS S` | `2 vCores`, `2 GB RAM`, `80 GB NVMe` | `gemma3:1b` | `qwen2.5:3b` muy justo y no recomendable como baseline | Solo para experimentación ligera |
| `VPS M` | `2 vCores`, `4 GB RAM`, `120 GB NVMe` | `qwen2.5:3b` | `gemma3:4b` con margen corto | Punto de entrada barato para IA local pequeña |
| `VPS L` | `4 vCores`, `8 GB RAM`, `240 GB NVMe` | `gemma3:4b` | `qwen2.5-coder:7b` en uso dedicado | Opción equilibrada para inferencia local CPU-only |
| `VPS XL` | `8 vCores`, `16 GB RAM`, `480 GB NVMe` | `gemma4:e2b` | `gemma4:e4b` o `qwen2.5:14b` con margen justo | Válido para Gemma 4 pequeño y pruebas serias |
| `VPS XXL` | `12 vCores`, `24 GB RAM`, `720 GB NVMe` | `gemma4:e4b` | `qwen2.5:14b` cómodo | Mejor opción VPS cerrada para OpenClaw + IA local |

## Lectura práctica por objetivo

### 1. Opción barata

Si el objetivo es tener un Ollama funcional con el menor coste posible:

- plan sugerido: `VPS M`
- modelo óptimo: `qwen2.5:3b`
- uso recomendado: chat ligero, automatización básica, pruebas de prompts y validación inicial de pipeline

Motivo: `qwen2.5:3b` ya está validado en DAVLOS y representa un baseline razonable para hosts pequeños.

### 2. Opción equilibrada

Si el objetivo es un VPS usable de forma realista para IA local sin GPU:

- plan sugerido: `VPS L`
- modelo óptimo: `gemma3:4b`
- alternativa: mantener `qwen2.5:3b` si se prioriza estabilidad

Motivo: `8 GB RAM` ya permite trabajar con modelos pequeños/medios sin entrar inmediatamente en una zona frágil.

### 3. Opción orientada a Gemma 4

Si el objetivo es entrar en la familia Gemma 4 local:

- entrada prudente: `VPS XL` con `gemma4:e2b`
- opción correcta para `gemma4:e4b`: `VPS XXL`

Motivo: aunque Gemma 4 E2B y E4B estén pensados para edge, sus tamaños publicados en Ollama siguen siendo altos para hosts pequeños. Para `gemma4:e4b`, `24 GB RAM` es el umbral VPS sensato.

### 4. Opción para OpenClaw en el mismo host

Si además del modelo quieres alojar OpenClaw, gateway, WireGuard, Syncthing y servicios auxiliares en el mismo VPS:

- no usar menos de `VPS XL`
- recomendación real: `VPS XXL`
- modelo óptimo en ese escenario: `gemma4:e4b`

Motivo: OpenClaw no consume solo modelo; también exige margen para runtime, contenedores, proxy/gateway y estabilidad general del host.

## Valoración específica de Gemma 4 E4B

`gemma4:e4b` es interesante por calidad, razonamiento, workflows agentic, coding y ventana de contexto de `128K`. Aun así:

- no encaja de forma prudente en DAVLOS actual
- sí puede encajar en `VPS XXL`
- en `VPS XL` puede llegar a funcionar, pero con menos colchón operativo

Recomendación concreta:

- **no** migrarlo a DAVLOS actual
- **sí** evaluarlo si el salto de infraestructura es al menos a `16 GB RAM`
- **preferentemente** usar `24 GB RAM` si OpenClaw va a compartir host

## Valoración específica para OpenClaw

OpenClaw en el estado actual del proyecto está alineado con inferencia local controlada y provider explícito. Desde ese contexto:

- `qwen2.5:3b` sigue siendo el baseline más prudente para hosts pequeños
- `gemma4:e2b` es el siguiente salto razonable si el VPS sube a `16 GB RAM`
- `gemma4:e4b` tiene sentido si se quiere más calidad agentic y se asume una subida a `24 GB RAM`

Conclusión práctica para OpenClaw:

- `VPS M` o `VPS L` → mantener modelos pequeños
- `VPS XL` → empezar a plantear Gemma 4 E2B
- `VPS XXL` → Gemma 4 E4B ya tiene sentido operativo

## Nota sobre MiniMax

MiniMax aparece en la librería de Ollama principalmente en variantes `cloud`. Eso puede ser interesante si se acepta una arquitectura dependiente de proveedor externo, pero no es equivalente a sustituir un modelo local de Ollama por otro dentro del mismo boundary local. Para el proyecto actual, MiniMax debe tratarse como una decisión de arquitectura aparte, no como simple cambio de modelo.

## Recomendación final

### Si se mantiene DAVLOS actual

- seguir con `qwen2.5:3b`
- no intentar `gemma4:e4b` como modelo principal local

### Si se quiere una mejora contenida

- pasar a `VPS L`
- evaluar `gemma3:4b`

### Si el objetivo real es Gemma 4

- `VPS XL` si se quiere probar `gemma4:e2b`
- `VPS XXL` si se quiere alojar `gemma4:e4b` con una postura prudente

### Si el objetivo es OpenClaw + IA local seria

- `VPS XXL` es la mejor opción cerrada dentro de la línea VPS estándar de IONOS
- por debajo de ese nivel, el compromiso entre calidad, latencia y estabilidad empieza a ser visible

## Resumen ejecutivo

- DAVLOS actual sirve para `qwen2.5:3b`, no para `gemma4:e4b`
- `VPS M` es el punto barato y razonable para modelos pequeños
- `VPS L` es la mejor relación coste/uso real para IA local CPU-only
- `VPS XL` es la entrada prudente a Gemma 4 E2B
- `VPS XXL` es la opción correcta para Gemma 4 E4B y el mejor encaje si el mismo host también va a sostener OpenClaw

## Fuentes

- Librería oficial Ollama: `https://ollama.com/library`
- Gemma 4: `https://ollama.com/library/gemma4`
- Gemma 3: `https://ollama.com/library/gemma3`
- Qwen2.5: `https://ollama.com/library/qwen2.5`
- Qwen2.5 Coder: `https://ollama.com/library/qwen2.5-coder`
- IONOS VPS / Cloud VPS: `https://www.ionos.com/servers/cloud-vps`
