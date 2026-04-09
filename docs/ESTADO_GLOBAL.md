# ESTADO_GLOBAL.md

## Precedencia documental vigente

Cuando un documento histórico, un resumen de producto y un checkpoint operativo no digan exactamente lo mismo, debe aplicarse este orden:

1. evidencia verificable;
2. checkpoint operativo vigente de `davlos-control-plane`;
3. documentación operativa no contradicha por evidencia más reciente;
4. `obsi-claw-AI_agent` como capa de producto;
5. propuestas futuras.

## Qué está confirmado

- Existe un clon de trabajo del proyecto en `/opt/automation/projects/obsi-claw-AI_agent`.
- Existe un clon local de referencia en `/opt/control-plane`, tratado en esta fase como solo lectura.
- La evidencia reciente de `davlos-control-plane` permite tratar hoy el boundary OpenClaw como **baseline prudente validado en host**.
- La fuente de verdad operativa de esa baseline sigue siendo `davlos-control-plane`; este repo conserva la fuente de verdad de producto, arquitectura, prompts y siguientes tramos.
- El runtime host-side, `openclaw-gateway`, `agents_net` e `inference-gateway.service` quedaron observados y documentados con evidencia suficiente para sostener esa baseline prudente.
- Broker restringido, Telegram persistente y helper readonly quedaron materializados por evidencia directa de host, con distintos niveles de confianza funcional.
- La validación funcional controlada del helper readonly confirma interfaz usable y cableado funcional por la vía `devops -> sudo` al menos para capacidades readonly acotadas.
- La prueba funcional readonly del broker core confirma ejecución real fuera de Telegram, con auditoría coherente y sin arrastre automático a canales o capacidades no verificadas.
- Sprint 2 cerró técnicamente `egress/allowlist` y dejó validación suficiente de su postura prudente.
- Sprint 3 dejó validación host-side mínima del plano vault/Syncthing; su detalle fino debe leerse con contexto de checkpoint y no como descripción viva inmutable.
- Sprint 4 y Sprint 5 dejaron evidencia repo-side de integración controlada OpenClaw ↔ vault mediante `heartbeat.write` y `draft.write`, sin prometer por ello nuevas capacidades.
- Sprint 6 dejó continuidad mínima del vault y del boundary, observabilidad mínima útil, rutina prudente de operación y validación mínima suficiente de uso estable en sentido no maximalista.
- Telegram quedó validado mínimamente mediante `/status`, pero sigue tratándose como canal prudente con warnings históricos de polling.
- Helper readonly, `.lock` root-only y ausencia de writers no root compatibles siguen siendo límites residuales visibles, no bloqueos totales del baseline.
- El repo ya dispone de `docs/PLAN_DE_PRUEBAS_FINAL_MVP_OBSI_CLAW.md` como soporte formal de validación final del MVP.
- El repo ya dispone de `docs/MEMORIA_TECNICA_FINAL_OBSI_CLAW.md` como memoria técnica final del producto en su cierre prudente.

## Semáforo actual del boundary

### Verde

- runtime host-side;
- `agents_net` y aislamiento visible;
- bind local del gateway;
- `inference-gateway.service`;
- hardening base del contenedor.
- `egress/allowlist` cerrado técnicamente en Sprint 2.
- helper readonly validado en modo readonly.
- broker restringido validado en su core de ejecución readonly.
- baseline prudente del boundary documentado y validado en el repo operativo.

### Ámbar

- Telegram persistente activo pero con warnings de polling;
- Telegram validado mínimamente para uso operativo prudente, con warnings históricos de polling y sin promesa de fiabilidad plena;
- contrato final de secretos y semántica final de health/readiness.
- coherencia histórica entre documentos y checkpoints: ya sin contradicción crítica viva en la línea validada, pero con posibilidad de drift menor o divergencia entre ramas, checkpoints e históricos.
- plano vault/Syncthing materializado y validado mínimamente con Android en ambos sentidos, pero con warning `Obsi-Claw` en ámbar y sin cierre de sync productivo completo.
- continuidad del vault fortalecida por backup diario mínimo y restore-check manual validados; el uso estable del sistema puede sostenerse en sentido prudente.
- continuidad del boundary fortalecida por bundle externo mínimo, backup de secretos y rebuild rehearsal mínimo ya validados; la reconstrucción exacta sigue abierta.

### Rojo

- cualquier supuesto de pairing, sincronización productiva o integración OpenClaw ↔ Vault más allá del plano administrativo local ya validado.

## Qué está pendiente de validar en host

- Coincidencia exacta entre ramas, checkpoints e históricos de `davlos-control-plane` y el estado actual del runtime real.
- Fiabilidad sostenida del canal Telegram más allá de su validación mínima actual.
- Si se quisiera declarar operativo un canal no-Telegram autenticado del broker, eso queda `pendiente de verificación en host`.
- Nivel de divergencia menor entre el árbol operativo real y documentos de checkpoints distintos del repo operativo.
- alcance efectivo actual del listener Syncthing `22000`;
- Si se quisiera ampliar la allowlist o reabrir `11434/tcp`, eso queda `pendiente de verificación en host`.
- postura final de exclusiones y ruido operativo de Syncthing por plataforma;
- exclusiones exactas de sync;
- recuperabilidad integral del boundary más allá del bundle externo, el backup de secretos y el rebuild rehearsal mínimo;
- pairing y validación adicional de clientes, especialmente Windows;
- postura final por plataforma, sobre todo iOS.
- sincronización host-side del helper instalado con la mejora menor del repo operativo sobre `broker_audit_recent`.

## Qué no debe asumirse aún

- Que toda la documentación histórica siga vigente sin contraste con el host.
- Que la cronología exacta de primera activación de la allowlist haya quedado demostrada al minuto.
- Que el cierre de egress autorice por sí solo cambios de vault, Syncthing u Obsidian operativo.
- Que exista ya un canal autenticado no-Telegram del broker desplegado y operativo.
- Que el listener Syncthing `22000` siga hoy limitado a loopback.
- Que el agente tenga ya permiso de escritura sobre una vault Obsidian productiva.
- Que exista una política resuelta para sync bidireccional o resolución de conflictos.
- Que Syncthing siga exactamente sin carpeta activa del vault o clientes remotos emparejados.
- Que el helper instalado en host coincida byte a byte con la última revisión del repo operativo.

## Divergencias documentales abiertas

- `davlos-control-plane` ya documenta el boundary OpenClaw como baseline prudente validado y sigue siendo la referencia operativa canónica.
- `obsi-claw-AI_agent` debe consumir esa baseline como punto de partida de producto y no como sustituto del estado real del VPS.
- la línea validada del proyecto ya no presenta una contradicción crítica viva sobre la existencia o forma general del boundary.
- puede persistir divergencia menor entre ramas, checkpoints e históricos del repo operativo sin que eso niegue la baseline prudente validada.
- persiste un drift menor repo ↔ host en el helper readonly del repo operativo; hoy no cambia la superficie expuesta ni bloquea el baseline prudente.
- Sprint 5 abrió tensión documental sobre el scope actual del listener Syncthing `22000`.
- Los documentos históricos de sprint deben leerse con contexto temporal y no como estado vivo permanente.
- Toda futura implementación debe contrastarse contra el estado real del VPS.

## Nota operativa

Toda incertidumbre relevante debe mantenerse etiquetada como `pendiente de verificación en host`.

## Criterio prudente de uso estable del sistema

En este proyecto, `uso estable del sistema` no significa perfección ni ausencia total de warnings.
Significa que las capacidades mínimas validadas permiten uso sostenido con ámbar conocido, acotado y no bloqueante:

- observabilidad mínima operativa;
- backup/restore mínimo del vault;
- continuidad mínima del boundary;
- Syncthing validado mínimamente con cliente real;
- Telegram validado mínimamente para uso operativo prudente.

## Siguiente tramo lógico

El siguiente tramo ya no consiste en reabrir auditorías ya cerradas, sino en consumir correctamente una **baseline prudente validada** en `davlos-control-plane`.

La preparación documental inicial de ese siguiente tramo queda aquí:

- `docs/BASELINE_OPENCLAW_VALIDADO_Y_SIGUIENTE_TRAMO.md`
- `docs/features/obsi-claw-optimization/OBJETIVOS_FINALES.md`
- `docs/features/obsi-claw-optimization/SPRINT_00_BACKLOG.md`
