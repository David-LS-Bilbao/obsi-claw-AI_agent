# RIESGOS_Y_DECISIONES.md

| Riesgo | Impacto | Mitigación | Decisión actual |
| --- | --- | --- | --- |
| Divergencia entre roadmap del repo nuevo y checkpoint operativo de `davlos-control-plane` | Planificación incorrecta del Sprint 1 | Priorizar evidencia y contraste host-side antes de proponer cambios técnicos | Sprint 1 queda cerrado como auditoría y consolidación del boundary existente; Sprint 2 asume el hardening pendiente |
| Ausencia inicial de estructura documental mínima en `obsi-claw-AI_agent` | Baja continuidad entre chats y agentes | Sembrar baseline documental pequeño y canónico | Ejecutado en este paso |
| Falta de verificación host-side del runtime OpenClaw | Riesgo de documentar sobre supuestos | Marcar todo hueco como `pendiente de verificación en host` | Se mantiene restricción explícita |
| Reutilizar árboles locales mezclados con runtime o trabajo previo | Confusión operativa y riesgo de tocar rutas sensibles | Separar workspace en `/opt/automation/projects` y tratar `/opt/control-plane` como solo lectura | Ejecutado en este paso |
| Definir integración Obsidian sin política de ownership y conflictos | Corrupción o sincronización insegura de la vault | Limitarse a visión inicial y prohibir sync bidireccional por ahora | Sprint 1 cierra con postura prudente: zonas controladas, HITL, sin sync bidireccional ni reescritura de notas núcleo |
| `control-plane/docs/AGENTS.md` desalineado con la evidencia real reciente | Baseline operativo ambiguo y decisiones erróneas | Fijar precedencia documental y registrar la desalineación | Riesgo aceptado temporalmente: `README` reciente + evidencia de host se tratan como baseline más fiable mientras no se limpie `control-plane` |
| Broker restringido sin ejercicio funcional propio | Falsa sensación de operatividad cerrada | Ejecutar una única verificación readonly sobre una acción explícitamente no mutante | Gap resuelto: el broker core queda `VERDE` tras ejecutar `action.health.general.v1` con evidencia before/after |
| Telegram activo con warnings de polling/timeout | Canal corto degradado sin visibilidad suficiente | Clasificar Telegram como ámbar y revisar salud funcional en paso posterior | Riesgo aceptado temporalmente: Telegram no bloquea el cierre de Sprint 1 y pasa a Sprint 2 como track secundario |
| Helper readonly instalado pero no revalidado | Menor confianza en la vía segura de observabilidad | Validar helper con subcomandos readonly y evidencia capturada | Resuelto: helper `VALIDADO READONLY` y vía preferente de observabilidad |
| No se observa un canal no-Telegram autenticado del broker desplegado en host | Riesgo de asumir una superficie operativa que hoy no está confirmada | Tratar el broker core como verde, pero cualquier canal alternativo como `pendiente de verificación en host` | No bloquea Sprint 1; queda fuera del cierre actual del broker core |
| Egress/allowlist final no cerrada | Riesgo residual de superficie no normalizada | Mantener gap explícito, usar la auditoría host-side como baseline y diferir el hardening real a Sprint 2 | Riesgo principal transferido a Sprint 2: hay ruta aprobada a `11434/11440`, pero no allowlist real ni `deny-by-default` efectivo |

## Divergencias documentales abiertas

- `davlos-control-plane` documenta un boundary OpenClaw ya operativo y con componentes auxiliares activos.
- `obsi-claw-AI_agent` no partía de cero conceptualmente, pero sí partía de una base documental mínima insuficiente.
- `control-plane/README.md` y la evidencia de host confirman un checkpoint avanzado del boundary.
- `control-plane/docs/AGENTS.md` conserva cautelas históricas que ya no describen broker y Telegram.
- Toda implementación futura debe validarse contra el estado real del VPS antes de tocar runtime o servicios.
