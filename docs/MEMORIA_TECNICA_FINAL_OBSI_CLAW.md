# Memoria Técnica Final — Obsi-Claw

## 1. Resumen ejecutivo

Obsi-Claw puede presentarse como un **MVP funcional y entregable en sentido prudente**.

El producto integra un vault canónico de Obsidian en DAVLOS con un boundary operativo de OpenClaw, mecanismos mínimos de continuidad, observabilidad controlada y canales operativos acotados. No se presenta como sistema perfecto ni como plataforma cerrada en todos sus frentes, pero sí como una solución útil, trazable y segura por diseño dentro de un alcance deliberadamente contenido.

El cierre del MVP se apoya en evidencia real ya validada en host:

- observabilidad mínima operativa para `devops`;
- continuidad mínima del vault;
- continuidad mínima del boundary;
- Syncthing validado mínimamente con Android;
- Telegram validado mínimamente mediante `/status`;
- rutinas diaria y semanal mínimas;
- uso estable del sistema en sentido prudente.

Los límites del MVP siguen visibles y forman parte explícita del resultado final.

## 2. Introducción y contexto del proyecto

Obsi-Claw nace como un sistema híbrido orientado a dos necesidades complementarias:

- disponer de un segundo cerebro persistente y utilizable en Markdown;
- disponer de un operador técnico semiautónomo capaz de ejecutar tareas concretas dentro de un perímetro controlado.

El proyecto se construye sobre DAVLOS, con una separación clara entre:

- el repositorio de producto y documentación `obsi-claw-AI_agent`;
- el repositorio de estado operativo del VPS `davlos-control-plane`.

Esa separación responde a una decisión de ingeniería: distinguir producto, diseño, documentación y gobierno técnico del estado real observado en host.

## 3. Problema que resuelve el producto

El problema que aborda Obsi-Claw no es “crear un chatbot”, sino resolver de forma integrada:

- la gestión de conocimiento personal y operativo en un vault legible;
- la continuidad mínima de ese conocimiento en un VPS;
- la ejecución controlada de tareas técnicas repetibles;
- la observabilidad suficiente para operar sin abrir más superficie de la necesaria;
- una interacción mínima con el sistema sin depender exclusivamente del acceso directo al host.

En términos prácticos, Obsi-Claw busca unir conocimiento, operación y continuidad dentro de un MVP usable y defendible.

## 4. Objetivos del proyecto

Los objetivos reales del proyecto fueron:

- definir un vault canónico de Obsidian en DAVLOS;
- separar OpenClaw del vault y de la sincronización del usuario;
- construir un boundary mínimo y seguro para OpenClaw;
- permitir observabilidad operativa mínima sin abrir permisos generales;
- establecer continuidad mínima del vault;
- establecer continuidad mínima del boundary;
- validar una sincronización mínima con cliente real;
- validar un canal mínimo de operación vía Telegram;
- cerrar el sistema en un estado operable y presentable, aunque no perfecto.

## 5. Alcance real del MVP

El alcance defendible del MVP final incluye:

- vault canónico en VPS bajo `/opt/data/obsidian/vault-main`;
- continuidad mínima del vault:
  - backup diario mínimo automatizado;
  - restore-check manual no destructivo;
- continuidad mínima del boundary:
  - bundle externo mínimo;
  - backup root-only de secretos;
  - rebuild rehearsal mínimo fuera de producción;
- observabilidad mínima operativa vía helper readonly y estado host-side;
- Syncthing mínimo con Android en ambos sentidos;
- Telegram mínimo como canal de consulta segura y operativa acotada;
- rutina diaria mínima;
- rutina semanal mínima;
- uso estable del sistema en sentido prudente.

Este alcance no pretende cerrar toda la evolución futura del sistema, sino consolidar un MVP funcional y entregable.

## 6. Fuera de alcance y límites aceptados

Queda fuera de alcance del MVP:

- sincronización productiva completa;
- validación completa de Windows;
- Telegram plenamente fiable y libre de degradación;
- reconstrucción reproducible completa del boundary;
- ausencia total de warnings;
- optimizaciones, ampliaciones y automatizaciones posteriores.

Límites aceptados:

- warning `Unexpected folder "Obsi-Claw"` en ámbar;
- residual `.obsidian/workspace.json` como benigno probable;
- Windows como `pendiente de verificación en host`;
- Telegram con degradación histórica observable de polling;
- recuperabilidad integral exacta del boundary aún no cerrada.

## 7. Arquitectura de la solución

La arquitectura del MVP puede explicarse en siete piezas:

### Vault / Obsidian

El vault canónico reside en DAVLOS y actúa como base de conocimiento persistente. El diseño es Markdown-first y local-first.

### Boundary OpenClaw

OpenClaw opera dentro de un boundary separado, con runtime específico, política viva, auditoría y componentes host-side diferenciados del vault.

### Control-plane

El control-plane concentra runbooks, plantillas y consola operativa. Su función es gobernar el boundary y mantener trazabilidad, no sustituir la verdad del host.

### Syncthing

Syncthing se usa como mecanismo de sincronización previsto del vault. En el MVP queda validado mínimamente con Android en ambos sentidos, sin declararse sincronización productiva completa.

### Telegram

Telegram aporta un canal corto y controlado de consulta/ejecución mínima. En el MVP queda validado mediante `/status`, no como canal perfecto ni como interfaz completa.

### Helper readonly

El helper readonly es la vía preferente de observabilidad controlada para `devops`, evitando abrir acceso general a `journald` o al árbol operativo completo.

### Backups, restore-check y continuidad

La continuidad se resuelve con un conjunto mínimo y prudente:

- backup diario del vault;
- restore-check manual no destructivo del vault;
- bundle externo mínimo del boundary;
- backup root-only de secretos;
- rebuild rehearsal mínimo fuera de producción.

## 8. Componentes principales del sistema

Los componentes principales realmente usados en el MVP son:

- vault canónico de Obsidian;
- servicio Syncthing;
- runtime boundary de OpenClaw;
- inference gateway host-side;
- helper readonly host-side;
- canal Telegram del operador;
- artefactos de backup y restore-check del vault;
- artefactos externos mínimos de continuidad del boundary;
- runbooks y rutinas mínima diaria y semanal.

No se deben añadir a esta lista componentes no validados o solo planificados.

## 9. Seguridad y criterios de diseño

Las decisiones de seguridad del MVP responden a cuatro criterios:

### Mínimo privilegio

La observabilidad de `devops` se acota mediante helper readonly y sudoers explícito, sin abrir acceso general a `journald` ni al runtime.

### Separación de planos

El vault, el boundary, los secretos y la sincronización no se mezclan sin control. El estado real del host y la documentación del producto se tratan como planos distintos.

### Cambios pequeños y reversibles

Las mejoras validadas durante Sprint 6 se ejecutaron con scripts/units mínimos, validación explícita y rollback claro.

### Continuidad sin maximalismo

Se priorizó continuidad mínima suficiente y verificable frente a soluciones amplias no demostradas.

## 10. Evolución por sprints

### Sprint 1

Aportó auditoría inicial, baseline técnica y marco de trabajo prudente. Sirvió para separar diseño, host real y control documental.

### Sprint 2

Cerró el hardening necesario de `egress/allowlist` y consolidó el perímetro básico del boundary sin mezclar aún vault y Syncthing.

### Sprint 3

Definió la arquitectura del vault canónico, ownership, exclusiones, backups y baseline mínima de Syncthing. Quedó cerrable por checklist y evidencia, sin declararse sincronización productiva.

### Sprint 4

Validó la integración mínima y controlada entre OpenClaw y el vault mediante `heartbeat.write` y `draft.write`, sin arrastre a capacidades no demostradas.

### Sprint 5

Consolidó el operador técnico semiautónomo en sentido prudente: skill validada, prompts operativos y límites de autonomía, sin inflar Telegram ni skills adicionales.

### Sprint 6

Consolidó la capa de estabilización y entrega:

- observabilidad mínima;
- continuidad mínima del vault;
- continuidad mínima del boundary;
- rutinas diaria y semanal;
- validación mínima de Syncthing con Android;
- validación mínima de Telegram;
- criterio prudente de uso estable.

Sprint 6 es el sprint que permite cerrar el MVP de forma prudente.

## 11. Validaciones y evidencias del MVP

El MVP no se apoya en narrativa, sino en validaciones reales:

- backup diario mínimo del vault validado;
- restore-check manual no destructivo validado;
- bundle externo mínimo del boundary validado;
- backup root-only de secretos validado;
- rebuild rehearsal mínimo validado;
- helper readonly validado para observabilidad mínima;
- Syncthing validado mínimamente con Android en ambos sentidos;
- Telegram validado mínimamente con `/status`;
- rutina diaria mínima validada;
- rutina semanal mínima validada.

La referencia operativa de cierre se apoya en:

- el cierre prudente de Sprint 6;
- el plan final de pruebas del MVP;
- la evidencia host-side acumulada durante las microfases técnicas.

## 12. Riesgos, ámbar aceptados y deuda residual

Los ámbar aceptados del MVP son:

- warning `Unexpected folder "Obsi-Claw"` en Syncthing;
- `.obsidian/workspace.json` como residual benigno probable;
- Windows `pendiente de verificación en host`;
- Telegram con warnings históricos de polling;
- recuperabilidad integral exacta del boundary todavía parcial.

La deuda residual principal es:

- no presentar aún una reconstrucción reproducible completa;
- no vender sincronización productiva total;
- no equiparar validación mínima de Telegram con fiabilidad plena;
- no confundir uso estable prudente con perfección operativa.

## 13. Criterio de uso estable del sistema

En Obsi-Claw, `uso estable del sistema` significa:

**uso sostenido con ámbar conocido, acotado y no bloqueante.**

No significa:

- perfección;
- ausencia total de warnings;
- sincronización completa de todos los clientes;
- Telegram sin degradación;
- continuidad integral exacta ya cerrada.

Sí significa:

- continuidad mínima suficiente;
- observabilidad mínima operativa;
- operación básica repetible;
- ámbar conocidos que no invalidan el uso real del sistema.

## 14. Veredicto final del producto

Formulación defendible:

**Obsi-Claw puede presentarse como MVP funcional y entregable en sentido prudente.**

Ese veredicto es profesionalmente defendible porque:

- existe evidencia real de operación;
- existe continuidad mínima validada;
- existe observabilidad mínima suficiente;
- existe integración mínima usable con Syncthing y Telegram;
- los límites siguen visibles y no se maquillan.

## 15. Mejoras futuras y optimización

Las mejoras futuras quedan como fase posterior, no como bloqueo del MVP:

- validación adicional de Windows;
- revisión o limpieza del warning `Obsi-Claw`;
- mejora de la postura final de Syncthing por plataforma;
- mejora de robustez de Telegram;
- recuperación más fuerte del boundary;
- ampliaciones funcionales del operador técnico;
- optimización documental y operativa posterior.

## 16. Conclusiones

Obsi-Claw no cierra como promesa abstracta, sino como un MVP realista.

El proyecto llega a un punto en el que:

- el vault ya no es solo una idea arquitectónica;
- OpenClaw ya no es solo un boundary documental;
- la continuidad mínima está resuelta de forma suficiente para un MVP;
- la operación mínima está validada;
- la presentación del producto puede hacerse con honestidad técnica.

La principal conclusión es que el producto ya es entregable en sentido prudente precisamente porque sus límites son conocidos, explícitos y compatibles con su uso básico.

## 17. Anexo breve para presentación

### Qué es el producto

Obsi-Claw es un sistema híbrido que une un vault canónico de Obsidian con un operador técnico semiautónomo basado en OpenClaw dentro de un perímetro controlado.

### Qué se ha validado

- continuidad mínima del vault;
- continuidad mínima del boundary;
- observabilidad mínima;
- Syncthing mínimo con Android;
- Telegram mínimo;
- operación mínima diaria y semanal.

### Qué límites quedan

- Windows sigue `pendiente de verificación en host`;
- Telegram no debe venderse como plenamente fiable;
- Syncthing no debe venderse como sincronización productiva completa;
- la reconstrucción exacta del boundary sigue abierta.

### Por qué sigue siendo defendible como MVP entregable

Porque el producto ya permite operar, observar, respaldar y recuperar lo esencial con evidencia real, manteniendo los riesgos residuales en un marco prudente y no bloqueante.
