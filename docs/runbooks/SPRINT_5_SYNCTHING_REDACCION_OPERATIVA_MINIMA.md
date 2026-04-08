# Sprint 5 — Syncthing 22000 — Redacción operativa mínima

## 1. Objetivo

Dejar una nota operativa breve para reconciliar la redacción documental mínima sobre Syncthing tras la investigación técnica controlada de Sprint 5, sin ampliar alcance ni convertir indicios en hechos cerrados.

## 2. Hallazgo confirmado

- La GUI/API observada de Syncthing quedó en `127.0.0.1:8384`.
- El listener de sincronización observado quedó en `10.90.0.1:22000`.
- La dirección `10.90.0.1` pertenece a la interfaz `wg0`.

## 3. Qué afirmación documental queda debilitada

- La formulación global `local-only` deja de ser defendible de forma literal si se aplica también al puerto `22000`.
- Sí sigue siendo defendible, con la evidencia disponible, afirmar que la GUI/API quedó ligada a `127.0.0.1:8384`.
- No es defendible, con la evidencia disponible, describir el listener de sincronización `22000` como loopback puro.

## 4. Qué redacción mínima es defendible ahora

Redacción mínima prudente:

> La GUI/API de Syncthing se observó en `127.0.0.1:8384`. El listener de sincronización se observó en `10.90.0.1:22000` sobre `wg0`. El alcance efectivo de esa exposición más allá de `wg0` queda `pendiente de verificación en host`.

Redacción breve equivalente:

> Syncthing no debe describirse de forma global como `local-only`. La afirmación `local-only` puede sostenerse para la GUI/API observada en `127.0.0.1:8384`, pero no como descripción literal del listener `22000` observado en `10.90.0.1`.

## 5. Qué sigue pendiente de verificación en host

- Si `10.90.0.1:22000` es accesible solo desde peers esperados de `wg0`: `pendiente de verificación en host`.
- Si existe filtrado adicional que limite de facto el alcance del listener `22000`: `pendiente de verificación en host`.
- Si el emparejamiento remoto visible está plenamente operativo más allá de su mera presencia observada: `pendiente de verificación en host`.
- Si la carpeta `vault-main` ya intercambia datos de forma efectiva o solo figura como preparada para sincronización: `pendiente de verificación en host`.

## 6. Riesgo de redacción incorrecta

- Riesgo documental medio si `local-only` se mantiene como descripción global de todo Syncthing.
- Riesgo de interpretación excesiva si `10.90.0.1:22000` se presenta como exposición pública sin evidencia adicional.
- Riesgo de drift entre documentación y estado observado si no se distingue entre GUI/API en loopback y listener de sincronización sobre `wg0`.

## 7. Uso correcto de esta nota

- Usar esta nota como guía de cautela documental para Sprint 5.
- Usar esta nota para corregir formulaciones absolutas o ambiguas sobre Syncthing.
- No usar esta nota para declarar exposición pública, emparejamiento plenamente operativo ni alcance final de red del listener `22000`.
- No usar esta nota como sustituto de validación host-side adicional donde siga aplicando `pendiente de verificación en host`.

## 8. Siguiente paso recomendado

Tomar esta redacción mínima como baseline prudente de Sprint 5 hasta que una verificación adicional en host permita cerrar, matizar o mantener la cautela sobre el alcance efectivo de `10.90.0.1:22000`.
