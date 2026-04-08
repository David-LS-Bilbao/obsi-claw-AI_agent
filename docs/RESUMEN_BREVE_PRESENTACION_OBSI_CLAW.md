# Resumen Breve de Presentación — Obsi-Claw

## Qué es Obsi-Claw

Obsi-Claw es un sistema híbrido que combina:

- un vault canónico de Obsidian como base de conocimiento viva;
- un boundary de OpenClaw como operador técnico semiautónomo dentro de un perímetro controlado;
- mecanismos mínimos de continuidad, observabilidad y operación segura.

## Qué problema resuelve

Obsi-Claw resuelve la necesidad de unir conocimiento personal/operativo y automatización técnica sin perder control humano, trazabilidad ni criterios básicos de seguridad.

## Qué se ha validado

- vault canónico en VPS;
- backup diario mínimo del vault;
- restore-check manual no destructivo del vault;
- observabilidad mínima operativa para `devops`;
- continuidad mínima del boundary mediante bundle externo, backup de secretos y rebuild rehearsal;
- Syncthing validado mínimamente con Android en ambos sentidos;
- Telegram validado mínimamente mediante `/status`;
- rutina diaria y rutina semanal mínimas;
- uso estable del sistema en sentido prudente.

## Qué no se afirma

- no se afirma sincronización productiva completa;
- no se afirma Telegram plenamente fiable;
- no se afirma reconstrucción reproducible completa del boundary;
- no se afirma ausencia total de warnings;
- Windows sigue `pendiente de verificación en host`.

## Veredicto defendible

Obsi-Claw puede presentarse como **MVP funcional y entregable en sentido prudente**:

- es útil;
- es operable;
- es trazable;
- mantiene límites conocidos y no bloqueantes visibles.
