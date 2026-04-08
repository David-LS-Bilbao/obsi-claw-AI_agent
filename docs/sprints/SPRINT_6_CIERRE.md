# Cierre Sprint 6 — Estabilización, observabilidad y continuidad

## 1. Objetivo del sprint

Cerrar un tramo prudente y defendible de estabilización operativa del sistema, reforzando observabilidad mínima, backups, restore y continuidad sin ampliar superficie innecesaria ni vender estabilidad perfecta.

## 2. Qué quedó realmente validado

- observabilidad mínima operativa para `devops` mediante helper readonly acotado;
- backup diario mínimo del vault con `systemd` timer, `tar --zstd` y sidecar `.sha256`;
- restore-check manual no destructivo del vault, validado fuera del vault vivo;
- bundle externo mínimo del boundary validado;
- backup root-only de secretos validado;
- rebuild rehearsal mínimo del boundary fuera de producción, validado sin tocar el runtime vivo;
- rutina diaria mínima validada;
- rutina semanal mínima validada;
- Syncthing validado mínimamente con Android en ambos sentidos;
- Telegram validado mínimamente mediante `/status`, con evidencia host-side suficiente.

## 3. Qué quedó en ámbar aceptado

- warning `Unexpected folder "Obsi-Claw"` acotado pero ámbar;
- `.obsidian/workspace.json` tratado como benigno probable;
- Windows sigue `pendiente de verificación en host`;
- Telegram mantiene degradación observable histórica de polling;
- la continuidad integral exacta del boundary sigue parcial.

## 4. Qué no debe afirmarse

- que existe sincronización productiva completa de Syncthing;
- que Telegram sea un canal plenamente fiable o sin warnings;
- que el boundary ya tenga reconstrucción reproducible completa;
- que `uso estable del sistema` equivalga a perfección o ausencia total de ámbar.

## 5. Veredicto final de cierre

**SPRINT_6_CERRABLE_PRUDENTE**

Sprint 6 puede cerrarse de forma prudente porque deja capacidades mínimas validadas, continuidad mínima operativa y ámbar conocidos no bloqueantes, sin necesidad de vender estabilidad perfecta ni recuperabilidad integral completa.

## 6. Arrastre recomendado al siguiente ciclo/chat

- decisión explícita sobre el cliente Windows en Syncthing;
- limpieza o documentación final del warning `Obsi-Claw`;
- criterio sostenido de `uso estable del sistema` a lo largo de más ciclos reales;
- continuidad integral exacta del boundary como trabajo separado, no como arrastre automático.
