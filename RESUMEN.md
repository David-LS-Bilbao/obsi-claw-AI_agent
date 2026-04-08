# RESUMEN MAESTRO DEL PROYECTO

## 1. Qué es este proyecto

Obsi-Claw AI Agent es la capa de producto y documentación de un sistema híbrido con dos planos:

- un segundo cerebro persistente basado en Obsidian y Markdown;
- un operador técnico semiautónomo basado en OpenClaw dentro de un boundary de seguridad en DAVLOS.

Este repositorio no es la verdad operativa del VPS. Es la fuente de verdad de producto, diseño, roadmap, runbooks, límites, prompts y continuidad documental del proyecto.

## 2. Fuentes de verdad y precedencia

Orden de precedencia para trabajar con prudencia:

1. evidencia verificable y estado real observado del host;
2. `davlos-control-plane` como fuente de verdad operativa del VPS;
3. `obsi-claw-AI_agent` como fuente de verdad de producto y evolución documental.

Regla práctica:

- si un documento entra en tensión con estado observado o con evidencia más reciente, no se fuerza la narrativa;
- se redacta con cautela y se marca como `pendiente de verificación en host` todo lo que no quede cerrado por evidencia suficiente.

## 3. Estado global real y prudente

### Confirmado documentalmente

- Sprint 1 quedó cerrado como sprint de auditoría, baseline y gobierno técnico.
- Sprint 2 quedó cerrado con `egress/allowlist` validado funcionalmente y clasificado `VERDE`.
- Sprint 3 dejó una baseline host-side mínima documentada para vault canónico + Syncthing, suficiente para considerarlo cerrable por checklist y evidencia dentro de su alcance.
- Sprint 4 quedó cerrado como MVP prudente de integración controlada OpenClaw ↔ vault.
- Sprint 5 quedó cerrado de forma prudente / no maximalista.
- El vault canónico de diseño sigue siendo `/opt/data/obsidian/vault-main`.
- Sprint 6 ya dejó backup diario mínimo automatizado del vault con `systemd` timer, `tar --zstd` y sidecar `.sha256`, validado en host.
- Sprint 6 ya dejó restore-check manual no destructivo del vault, validado fuera del vault vivo.
- Sprint 6 ya dejó backup externo mínimo del boundary OpenClaw, validado en host.
- Sprint 6 ya dejó backup root-only manual de secretos del boundary y rebuild rehearsal mínimo fuera de producción, ambos validados en host.
- Sprint 6 ya dejó observabilidad mínima operativa para `devops`, rutina diaria mínima, rutina semanal mínima y validación mínima de Syncthing con Android en ambos sentidos.
- Sprint 6 ya dejó Telegram con validación mínima suficiente mediante `/status`, sin venderlo como canal perfecto.
- `heartbeat.write` y `draft.write` quedaron validados en su perímetro mínimo.
- Skill 01 — Auditoría de Drift Host ↔ Documentación quedó validada con evidencia canónica.

### Cerrado de forma prudente

- Sprint 3 no está formalmente cerrado en este repositorio, pero sí queda presentado como cerrable por checklist y evidencia.
- La baseline Syncthing de Sprint 3 sigue siendo útil como referencia documental, pero ya no debe leerse como fotografía host-side cerrada de todos los detalles actuales.
- Telegram queda validado mínimamente para uso operativo prudente, con degradación observable y sin cierre como canal plenamente fiable.
- Sprint 6 puede cerrarse de forma prudente / no maximalista.
- Sprint 5 queda cerrado porque ya deja una capacidad interna claramente validada, una segunda tarea real segura y una reconciliación documental útil, no porque todo el operador técnico haya quedado validado.
- La postura de continuidad del vault mejora de forma material en Sprint 6, pero eso no equivale a recuperabilidad integral del boundary.
- La continuidad del sistema mejora más allá del vault con un bundle externo mínimo del boundary, pero eso no equivale a reconstrucción exacta ni a continuidad integral cerrada.
- El uso estable del sistema puede afirmarse en sentido prudente: capacidades mínimas sostenidas, ámbar acotados y continuidad mínima suficiente para uso operable, no ausencia total de warnings ni perfección.

### Pendiente de verificación en host

- el alcance efectivo actual del listener Syncthing `22000`;
- la vigencia exacta de la afirmación de Sprint 3 sobre pairing, dispositivos remotos y estado efectivo de sincronización;
- la validación funcional extremo a extremo del canal Telegram;
- cualquier afirmación fuerte sobre sincronización productiva con clientes;
- recuperabilidad integral del boundary y continuidad operativa completa de Sprint 6, más allá del backup diario mínimo del vault, del restore-check manual, del bundle externo mínimo, del backup de secretos y del rebuild rehearsal ya validados.

## 4. Resumen por sprint

- Sprint 1: cerrado.
  Alcance real: auditoría del boundary, baseline confirmada, helper readonly validado, broker core readonly validado y gap de `egress/allowlist` caracterizado.
- Sprint 2: cerrado.
  Alcance real: hardening de `egress/allowlist` con evidencia funcional suficiente, sin mezclar Syncthing ni vault operativo.
- Sprint 3: cerrable por checklist y evidencia, pero sin cierre formal final en este paso.
  Alcance real: arquitectura del vault, baseline mínima de Syncthing y vault, ownership, conflictos, exclusiones, backups y flujos futuros sin activarlos.
- Sprint 4: cerrado como MVP prudente.
  Alcance real: `heartbeat.write` mínimo, `draft.write` mínimo con contrato nuevo y límites HITL sin arrastre a capacidades posteriores.
- Sprint 5: cerrado de forma prudente / no maximalista.
  Alcance real: Skill 01 validada, segunda tarea real segura mediante `draft.write`, investigación acotada sobre Syncthing `22000` y cierre prudente del sprint sin inflar Telegram ni skills adicionales.
- Sprint 6: cerrado de forma prudente / no maximalista.
  Alcance real: observabilidad mínima operativa, continuidad mínima de vault y boundary, rutinas diaria/semanal y cierre prudente con ámbar no bloqueantes aceptados.

## 5. Capacidades realmente validadas

- helper readonly como vía verde de observabilidad controlada;
- broker core readonly en su alcance realmente ejercitado;
- `egress/allowlist` del boundary con evidencia funcional suficiente;
- baseline vault/Syncthing mínima de Sprint 3, con cautela documental actual sobre el alcance efectivo de `22000` y sobre pairing/sync, que siguen `pendiente de verificación en host`;
- backup diario mínimo del vault con timer y checksum sidecar, validado en host;
- restore-check manual no destructivo del vault, validado fuera del vault vivo;
- backup externo mínimo del boundary con config efectiva, compose, policy efectiva, unit Telegram, runbooks mínimos y snapshot de egress;
- backup root-only manual de secretos del boundary, validado en host;
- rebuild rehearsal mínimo del boundary fuera de producción, validado sin tocar el runtime vivo;
- `heartbeat.write` mínimo como writer controlado y validado en host;
- `draft.write` mínimo con `STAGED_INPUT.md` canónico, un draft nuevo y sin promoción automática;
- Skill 01 — Auditoría de Drift Host ↔ Documentación como capacidad interna validada con evidencia canónica;
- canal Telegram validado mínimamente para uso operativo prudente:
- servicio activo y runtime `running`;
- `/status` ejecutado con `ok=true` en audit host-side;
- degradación observable histórica, sin cierre como canal plenamente fiable.
- Syncthing validado mínimamente con Android en ambos sentidos, sin vender sync productivo completo; Windows sigue `pendiente de verificación en host`.

## 6. Riesgos abiertos

- drift documental entre `obsi-claw-AI_agent` y `davlos-control-plane`;
- alcance efectivo actual del listener Syncthing `22000`;
- Telegram no validado como canal plenamente fiable;
- pairing y validación real adicional de clientes Syncthing, en especial Windows;
- recuperabilidad integral del boundary y continuidad completa de Sprint 6 aún por consolidar, incluso después del backup de secretos y del rebuild rehearsal mínimo;
- riesgo de inflar capacidades por analogía, especialmente desde `draft.write`;
- riesgo de tratar baseline documental de Sprint 3 como si equivaliera a sincronización productiva ya cerrada.

## 7. Deuda documental y técnica

- reconciliación continua entre repo de producto y repo operativo cuando aparezca drift observable;
- cierre formal final de Sprint 3 aún no realizado;
- aclaración documental definitiva del scope de Syncthing `22000`;
- consolidación documental final del cierre prudente de Sprint 6;
- definición del siguiente ciclo sin inflar la continuidad integral del boundary ni la estabilidad perfecta del sistema;
- no confundir el fortalecimiento del vault en Sprint 6 con continuidad integral ya demostrada del boundary;
- evitar que contratos o runbooks documentados se presenten como capacidades ya validadas si no tienen evidencia host-side suficiente.

## 8. Qué NO debe asumirse

- no asumir que documentación = estado real del host;
- no asumir que la baseline Syncthing documentada en Sprint 3 sigue íntegra y literalmente vigente;
- no asumir sincronización productiva con clientes;
- no asumir pairing real validado;
- no asumir que `10.90.0.1:22000` equivale por sí solo a exposición pública;
- no asumir Telegram plenamente fiable o validado para cierre funcional;
- no asumir nuevas capacidades por arrastre desde `draft.write`;
- no asumir que Sprint 5 validó múltiples skills internas cuando la skill claramente validada con evidencia canónica es la Skill 01;
- no asumir que Sprint 3 ya quedó formalmente cerrado solo porque sea cerrable por checklist y evidencia.

## 9. Próxima secuencia recomendada

1. Tomar este `RESUMEN.md` como documento de relevo maestro para nuevos chats.
2. Tratar Sprint 6 como cerrado de forma prudente y usarlo como baseline operativa/documental del siguiente ciclo.
3. Priorizar solo los siguientes ámbar no bloqueantes o pendientes de verificación:
   - Windows en Syncthing;
   - warning `Obsi-Claw`;
   - continuidad integral final del boundary;
   - criterio sostenido de uso estable.
4. Cerrar primero tensiones documentales antes de abrir nuevas capacidades.
5. Abrir cualquier nueva validación en microfases, con contrato, evidencia esperada, límites y criterio HITL explícitos.

## 10. Prompt de arranque recomendado para un nuevo chat

```text
Actúa como copiloto técnico prudente del proyecto Obsi-Claw AI Agent.

Rol del chat:
- continuar el trabajo documental y técnico del proyecto por microfases;
- separar siempre diseño objetivo, estado documental y estado real observado;
- no inflar capacidades ni cierres por analogía.

Precedencia obligatoria:
1. evidencia verificable y estado real observado;
2. davlos-control-plane como fuente de verdad operativa del VPS;
3. obsi-claw-AI_agent como fuente de verdad de producto y documentación viva.

Reglas:
- no asumir que documentación = estado real del host;
- no tocar VPS si no se pide de forma explícita;
- marcar literalmente como `pendiente de verificación en host` todo lo no cerrado por evidencia suficiente;
- trabajar en microfases con prompts para Codex, cambios pequeños, auditables y reversibles.

Punto de partida:
- leer README.md, docs/PLAN_DIRECTOR.md, docs/MAPA_DE_SPRINTS.md, docs/ESTADO_GLOBAL.md, docs/ESTADO_SEMAFORICO.md, docs/RIESGOS_Y_DECISIONES.md y RESUMEN.md;
- proponer el siguiente paso mínimo útil sin inflar estado.
```
