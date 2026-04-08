# Plan de Pruebas Final — Obsi-Claw MVP

## 1. Propósito del plan

Definir el conjunto final de pruebas del MVP funcional y entregable de Obsi-Claw antes de su presentación.

Este plan sirve para:

- ejecutar validaciones reales de forma ordenada;
- registrar resultados y evidencias;
- sostener un veredicto profesional de aprobación o no aprobación del MVP;
- defender el producto como MVP funcional y entregable en sentido prudente, no maximalista.

## 2. Alcance del MVP a validar

Este plan valida solo el MVP realmente defendible a fecha de cierre prudente de Sprint 6:

- vault canónico en VPS;
- continuidad mínima del vault:
  - backup diario mínimo;
  - restore-check manual no destructivo;
- continuidad mínima del boundary:
  - bundle externo mínimo del boundary;
  - backup root-only de secretos;
  - rebuild rehearsal mínimo fuera de producción;
- observabilidad mínima operativa para `devops`;
- Syncthing mínimo con Android en ambos sentidos;
- Telegram mínimo como canal operativo de consulta segura;
- rutina diaria mínima;
- rutina semanal mínima;
- uso estable del sistema en sentido prudente.

## 3. Fuera de alcance de este plan

Queda explícitamente fuera de alcance:

- sincronización productiva completa entre todos los clientes;
- validación completa de Windows;
- Telegram plenamente fiable o sin degradación;
- reconstrucción reproducible completa del boundary;
- ausencia total de warnings;
- optimizaciones futuras, hardening adicional o automatizaciones no validadas;
- cambios de arquitectura o ampliaciones funcionales del producto;
- cualquier afirmación que siga `pendiente de verificación en host`.

## 4. Supuestos y restricciones

- El plan se apoya en evidencia ya validada en host durante Sprint 6.
- El producto se presenta como MVP funcional y entregable, no como sistema perfecto.
- Los ámbar conocidos no bloquean por sí solos la aprobación si están acotados y no comprometen el uso básico.
- No se deben inventar validaciones no demostradas.
- Todo lo no demostrado debe quedar como `pendiente de verificación en host`.
- La validación debe priorizar pruebas reales, mínimas y seguras.
- Este plan no sustituye runbooks operativos ni procedimientos de recuperación extendidos.

## 5. Entornos y prerrequisitos

### Entorno principal

- Host DAVLOS con el stack MVP observado en Sprint 6.

### Prerrequisitos mínimos

- acceso de operador a la sesión host con permisos suficientes para observación;
- acceso `devops` al helper readonly validado;
- acceso a evidencias locales de backup y restore-check;
- acceso al cliente Android real para pruebas mínimas de Syncthing;
- acceso al chat privado de Telegram ya autorizado para `/status`;
- disponibilidad de las rutas y artefactos ya validados durante Sprint 6.

### Condición de base

El plan parte de una baseline prudente ya validada en host, con ámbar aceptados y conocidos.

## 6. Criterio de aprobado / no aprobado

### Aprobado

El MVP puede darse por aprobado si:

- todas las pruebas P1 del plan resultan conformes;
- no aparece un fallo crítico nuevo que comprometa el uso básico;
- los ámbar conocidos siguen siendo acotados, no bloqueantes y coherentes con la evidencia ya aceptada;
- el producto puede sostener:
  - observabilidad mínima;
  - continuidad mínima del vault;
  - continuidad mínima del boundary;
  - Syncthing mínimo con Android;
  - Telegram mínimo;
  - operación básica con rutina diaria y semanal.

### No aprobado

El MVP no debe aprobarse si ocurre cualquiera de estos supuestos:

- falla la salud básica del boundary;
- falla el backup del vault o su restore-check mínimo;
- no existe evidencia válida del bundle del boundary o del backup de secretos;
- el rebuild rehearsal deja de ser coherente;
- el helper readonly deja de ser usable para observabilidad mínima;
- falla la validación mínima de Syncthing con Android en alguno de los sentidos exigidos por este plan;
- falla la validación mínima de Telegram `/status`;
- aparece un riesgo nuevo no acotado que compromete el uso básico del sistema.

## 7. Matriz de pruebas

| ID | Área | Objetivo | Tipo de prueba | Prioridad | Estado esperado | Evidencia requerida |
|---|---|---|---|---|---|---|
| T01 | Boundary | Confirmar arranque y salud básica del boundary | Operativa / salud | P1 | Conforme | Estado de servicio, contenedor y health |
| T02 | Observabilidad | Confirmar observabilidad mínima para `devops` vía helper readonly | Operativa / seguridad | P1 | Conforme | Salida útil de helper y logs permitidos |
| T03 | Vault | Confirmar backup diario mínimo del vault | Continuidad | P1 | Conforme | Artefacto reciente, sidecar y checksum OK |
| T04 | Vault | Confirmar restore-check manual no destructivo | Recuperabilidad | P1 | Conforme | Evidencia de restore temporal y comparación prudente |
| T05 | Boundary | Confirmar bundle externo mínimo del boundary | Continuidad | P1 | Conforme | Artefacto, inventario y checksum OK |
| T06 | Secretos | Confirmar backup root-only de secretos | Continuidad / seguridad | P1 | Conforme | Artefacto, inventario sin contenido y checksum OK |
| T07 | Boundary | Confirmar rebuild rehearsal mínimo fuera de producción | Recuperabilidad | P1 | Conforme | Evidencia de árbol rehecho coherente |
| T08 | Syncthing | Confirmar flujo host -> Android | Integración E2E mínima | P1 | Conforme | Evidencia host-side del canario |
| T09 | Syncthing | Confirmar flujo Android -> host | Integración E2E mínima | P1 | Conforme con ámbar aceptado | Evidencia host-side del canario |
| T10 | Telegram | Confirmar `/status` como prueba mínima del canal | Integración E2E mínima | P1 | Conforme con ámbar aceptado | Audit host-side y avance de offset |
| T11 | Operación | Confirmar ejecución útil de rutina diaria mínima | Operativa | P2 | Conforme | Registro de ejecución y resultado |
| T12 | Operación | Confirmar ejecución útil de rutina semanal mínima | Operativa | P2 | Conforme | Registro de ejecución y resultado |
| T13 | Sistema | Confirmar criterio de uso estable en sentido prudente | Criterio de aceptación | P1 | Conforme con ámbar aceptado | Resultado consolidado del plan |

## 8. Casos de prueba detallados

### CP-01 — Salud básica del boundary

- Objetivo:
  - confirmar que el boundary sigue sano en su baseline operativa.
- Precondiciones:
  - servicios y runtime observables desde host.
- Pasos:
  1. comprobar estado del gateway;
  2. comprobar estado del servicio de inferencia;
  3. comprobar endpoint de salud mínimo;
  4. registrar resultado.
- Resultado esperado:
  - runtime activo y salud básica conforme.
- Evidencia:
  - estado del contenedor, estado del servicio y respuesta de health.
- Severidad si falla:
  - crítica.

### CP-02 — Observabilidad mínima vía helper readonly

- Objetivo:
  - confirmar que `devops` puede ver estado y logs operativos mínimos sin acceso general a `journald`.
- Precondiciones:
  - helper readonly y sudoers ya instalados y validados.
- Pasos:
  1. ejecutar `runtime_summary`;
  2. ejecutar `operational_logs_recent`;
  3. revisar si la salida es útil y acotada.
- Resultado esperado:
  - observabilidad mínima útil y cerrada.
- Evidencia:
  - salida del helper y confirmación de alcance restringido.
- Severidad si falla:
  - alta.

### CP-03 — Backup diario mínimo del vault

- Objetivo:
  - confirmar que la continuidad mínima del vault se sostiene con backup reciente válido.
- Precondiciones:
  - timer de backup existente y artefactos presentes.
- Pasos:
  1. comprobar timer activo;
  2. identificar último backup;
  3. validar sidecar `.sha256`.
- Resultado esperado:
  - backup reciente presente y checksum válido.
- Evidencia:
  - nombre del artefacto, sidecar y `OK` del checksum.
- Severidad si falla:
  - crítica.

### CP-04 — Restore-check manual no destructivo del vault

- Objetivo:
  - confirmar recuperabilidad mínima del vault sin tocar el vault vivo.
- Precondiciones:
  - script/service de restore-check validados.
- Pasos:
  1. revisar última ejecución válida del restore-check;
  2. verificar que usó ruta temporal;
  3. verificar que la comparación fue prudente y correcta;
  4. verificar limpieza final o justificación equivalente.
- Resultado esperado:
  - restore-check correcto sin impacto en producción.
- Evidencia:
  - journal del service y resultado de comparación.
- Severidad si falla:
  - crítica.

### CP-05 — Bundle externo mínimo del boundary

- Objetivo:
  - confirmar continuidad mínima externa del boundary no sensible.
- Precondiciones:
  - bundle ya generado durante Sprint 6.
- Pasos:
  1. localizar el último bundle;
  2. comprobar sidecar `.sha256`;
  3. revisar inventario;
  4. confirmar presencia de config, compose, policy, unit Telegram y snapshot de egress.
- Resultado esperado:
  - bundle coherente y verificable.
- Evidencia:
  - artefacto, inventario y checksum OK.
- Severidad si falla:
  - alta.

### CP-06 — Backup root-only de secretos

- Objetivo:
  - confirmar continuidad mínima de secretos host-side sin exposición de contenido.
- Precondiciones:
  - backup manual de secretos ya validado.
- Pasos:
  1. localizar artefacto más reciente;
  2. validar checksum;
  3. revisar inventario externo sin contenido sensible.
- Resultado esperado:
  - backup root-only válido y trazable.
- Evidencia:
  - artefacto, inventario y checksum OK.
- Severidad si falla:
  - crítica.

### CP-07 — Rebuild rehearsal mínimo fuera de producción

- Objetivo:
  - confirmar que los artefactos permiten ensamblar un boundary coherente fuera de producción.
- Precondiciones:
  - evidencia del rehearsal ya validado.
- Pasos:
  1. revisar resultado del rehearsal;
  2. confirmar presencia reconstruida de config, compose, policy, unit Telegram, restricted operator y secretos restaurados solo en ruta temporal;
  3. confirmar que producción no fue tocada.
- Resultado esperado:
  - rehearsal mínimo validado.
- Evidencia:
  - resumen del rehearsal y clasificación final.
- Severidad si falla:
  - alta.

### CP-08 — Syncthing host -> Android

- Objetivo:
  - confirmar la sincronización mínima host -> Android.
- Precondiciones:
  - Android real disponible y conectado.
- Pasos:
  1. revisar evidencia del canario host -> Android;
  2. confirmar que el canario fue necesitado por el cliente y luego absorbido;
  3. confirmar que no generó conflicto.
- Resultado esperado:
  - flujo mínimo validado.
- Evidencia:
  - API/estado host-side y registro del canario.
- Severidad si falla:
  - alta.

### CP-09 — Syncthing Android -> host

- Objetivo:
  - confirmar la sincronización mínima Android -> host.
- Precondiciones:
  - cliente Android real disponible.
- Pasos:
  1. revisar evidencia del canario creado desde Android;
  2. confirmar aparición en host;
  3. confirmar metadata coherente y ausencia de conflicto;
  4. registrar warning y residual asociados sin inflar conclusión.
- Resultado esperado:
  - flujo mínimo validado con ámbar aceptado.
- Evidencia:
  - archivo en host, metadata, journal/API si aplica.
- Severidad si falla:
  - alta.

### CP-10 — Telegram `/status`

- Objetivo:
  - confirmar uso mínimo del canal Telegram.
- Precondiciones:
  - servicio del bot activo y chat autorizado disponible.
- Pasos:
  1. revisar precheck del servicio;
  2. enviar `/status`;
  3. verificar evidencia host-side de procesamiento correcto.
- Resultado esperado:
  - comando procesado con `ok=true`.
- Evidencia:
  - audit host-side y avance de offset.
- Severidad si falla:
  - alta.

### CP-11 — Rutina diaria mínima

- Objetivo:
  - confirmar que la operación diaria mínima es corta, usable y útil.
- Precondiciones:
  - baseline de Sprint 6 disponible.
- Pasos:
  1. ejecutar la rutina diaria definida;
  2. registrar lo que salió bien;
  3. registrar ámbar y `pendiente de verificación en host`.
- Resultado esperado:
  - rutina ejecutable y útil para operación básica.
- Evidencia:
  - salida resumida de la rutina y lectura operativa.
- Severidad si falla:
  - media.

### CP-12 — Rutina semanal mínima

- Objetivo:
  - confirmar que la rutina semanal existe y aporta control real de continuidad.
- Precondiciones:
  - evidencias de continuidad ya disponibles.
- Pasos:
  1. ejecutar la rutina semanal definida;
  2. comprobar backups, restore-check, bundle y secretos;
  3. registrar resultado consolidado.
- Resultado esperado:
  - rutina semanal válida en una primera ejecución.
- Evidencia:
  - salida resumida y veredicto de rutina.
- Severidad si falla:
  - media.

### CP-13 — Uso estable del sistema en sentido prudente

- Objetivo:
  - decidir si el producto puede defenderse como uso estable prudente.
- Precondiciones:
  - CP-01 a CP-12 evaluados.
- Pasos:
  1. consolidar resultados P1 y P2;
  2. verificar que los ámbar aceptados siguen siendo no bloqueantes;
  3. emitir veredicto final del MVP.
- Resultado esperado:
  - uso estable del sistema defendible en sentido prudente.
- Evidencia:
  - matriz completa, riesgos conocidos y veredicto final.
- Severidad si falla:
  - crítica.

## 9. Evidencias a capturar

- estado de servicios y contenedor del boundary;
- salidas del helper readonly relevantes;
- nombre y checksum del backup diario del vault;
- resultado del restore-check manual no destructivo;
- nombre, inventario y checksum del bundle del boundary;
- nombre, inventario y checksum del backup de secretos;
- evidencia del rebuild rehearsal;
- evidencia host-side del canario host -> Android;
- evidencia host-side del canario Android -> host;
- evidencia host-side de Telegram `/status`;
- ejecución resumida de rutina diaria;
- ejecución resumida de rutina semanal;
- matriz final del plan con estado por caso.

## 10. Riesgos conocidos y tratamiento

| Riesgo / ámbar | Estado | Tratamiento en este plan |
|---|---|---|
| `Unexpected folder "Obsi-Claw"` | Ámbar acotado | No bloquea aprobación si el sync mínimo con Android sigue funcionando |
| `.obsidian/workspace.json` | Benigno probable | Se registra como ruido compatible con ignores; no se vende como validación total |
| Windows | `pendiente de verificación en host` | Queda fuera del aprobado mínimo del MVP |
| Telegram con degradación histórica de polling | Ámbar aceptado | No bloquea si `/status` sigue pasando y no hay caída del canal |
| Continuidad integral exacta del boundary | Parcial | No se afirma reconstrucción reproducible completa |
| Ausencia total de warnings | No demostrada | No forma parte del criterio de aprobado |

## 11. Veredicto final del MVP

Formulación defendible propuesta:

**Obsi-Claw puede presentarse como MVP funcional y entregable en sentido prudente si este plan queda aprobado, aunque permanezcan ámbar conocidos, acotados y no bloqueantes.**

Eso significa:

- continuidad mínima validada;
- observabilidad mínima operativa validada;
- Syncthing mínimo con Android validado;
- Telegram mínimo validado;
- uso estable del sistema alcanzado en sentido prudente.

No significa:

- sistema perfecto;
- sincronización completa de todos los clientes;
- Telegram sin degradación;
- boundary completamente reproducible;
- ausencia total de warning operativo.

## 12. Checklist de ejecución

- [ ] revisar prerrequisitos del entorno
- [ ] ejecutar CP-01
- [ ] ejecutar CP-02
- [ ] ejecutar CP-03
- [ ] ejecutar CP-04
- [ ] ejecutar CP-05
- [ ] ejecutar CP-06
- [ ] ejecutar CP-07
- [ ] ejecutar CP-08
- [ ] ejecutar CP-09
- [ ] ejecutar CP-10
- [ ] ejecutar CP-11
- [ ] ejecutar CP-12
- [ ] consolidar CP-13
- [ ] registrar ámbar aceptados
- [ ] registrar `pendiente de verificación en host`
- [ ] emitir veredicto final del MVP

## 13. Anexo para presentación del producto

### Qué se ha validado

- continuidad mínima del vault;
- continuidad mínima del boundary;
- observabilidad mínima para operación;
- Syncthing mínimo con Android en ambos sentidos;
- Telegram mínimo con `/status`;
- operación mínima diaria y semanal;
- uso estable del sistema en sentido prudente.

### Qué límites quedan

- Windows sigue `pendiente de verificación en host`;
- Telegram conserva degradación histórica observable;
- Syncthing no debe venderse como sincronización productiva completa;
- la reconstrucción exacta del boundary no debe presentarse como cerrada;
- siguen existiendo ámbar operativos acotados.

### Por qué el producto sigue siendo defendible como MVP entregable

Porque las capacidades mínimas necesarias para operar, observar, respaldar y recuperar el sistema ya están validadas con evidencia real, y los riesgos residuales conocidos no bloquean el uso básico del producto.
