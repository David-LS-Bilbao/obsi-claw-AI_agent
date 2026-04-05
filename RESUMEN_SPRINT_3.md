# RESUMEN_SPRINT_3.md

## Contexto mínimo

Obsi-Claw combina dos planos:

- un vault canónico de Obsidian como base de conocimiento;
- OpenClaw como operador técnico semiautónomo dentro de un perímetro controlado.

Sprint 1 cerró baseline y gobierno técnico.
Sprint 2 cerró documentalmente y con evidencia funcional suficiente el gap de `egress/allowlist`.
Sprint 3 no despliega nada nuevo en host: consolida la arquitectura documental del vault, Syncthing, ownership y límites del agente.

## Estado consolidado al final de Sprint 3

### Decisión documental cerrada

- vault canónico en DAVLOS como diseño objetivo;
- Syncthing como solución prevista de sincronización;
- runtime del agente separado del vault;
- escritura del agente solo en zonas controladas;
- HITL obligatorio para promoción a conocimiento estable;
- postura de mínimo privilegio para lectura y escritura.

### Estado real observado

- existe un boundary OpenClaw previo en DAVLOS documentado en la base del proyecto;
- Sprint 3 no añade evidencia nueva de despliegue de Syncthing;
- Sprint 3 no añade evidencia nueva de existencia material del vault canónico en host.

### Pendiente de verificación en host

- ruta real del vault;
- layout real de la zona del agente;
- ownership y permisos efectivos;
- servicio real de Syncthing;
- método final de acceso seguro a GUI;
- exclusiones exactas de sync;
- estrategia operativa de backup y restore.

## Decisiones cerradas

- el vault canónico pertenece al plano de conocimiento del usuario, no al runtime del agente;
- OpenClaw no queda autorizado para escribir libremente sobre toda la bóveda;
- las zonas controladas del agente se modelan bajo `Agent/Inbox_Agent/`, `Agent/Drafts_Agent/`, `Agent/Reports_Agent/` y `Agent/Heartbeat/`;
- las notas núcleo del usuario y la taxonomía principal quedan fuera de escritura directa del agente;
- Syncthing se trata como sync previsto y controlado, no como despliegue ya realizado;
- la GUI de Syncthing no debe exponerse públicamente por defecto.

## Decisiones abiertas

- si la zona del agente vivirá dentro del vault principal o en carpeta hermana;
- usuario y grupo del sistema;
- permisos efectivos del vault;
- política exacta de conflictos;
- exclusiones exactas de sincronización;
- política operativa mínima de backup y restore;
- postura final por plataforma, sobre todo iOS.

## Riesgos principales

- confundir diseño objetivo con estado real observado;
- abrir superficie innecesaria alrededor de Syncthing;
- permitir escritura demasiado amplia al agente;
- mezclar vault y runtime;
- tratar sync como sustituto de backup.

## Artefactos canónicos que hay que leer primero

- `README.md`
- `docs/PLAN_DIRECTOR.md`
- `docs/MAPA_DE_SPRINTS.md`
- `docs/RIESGOS_Y_DECISIONES.md`
- `docs/architecture/ADR-001-VAULT-CANONICO-VPS-SYNCTHING.md`
- `docs/architecture/ADR-002-OWNERSHIP-Y-LIMITES-DE-ESCRITURA-DEL-VAULT.md`
- `docs/runbooks/SYNCTHING_DAVLOS_PREPARACION.md`
- `docs/runbooks/SYNCTHING_GUI_ACCESO_SEGURO.md`
- `docs/vault/CONVENCION_DE_CARPETAS_Y_ZONAS.md`
- `docs/vault/CONFLICTOS_EXCLUSIONES_Y_BACKUPS.md`
- `docs/sprints/SPRINT_3_CIERRE_BORRADOR.md`
- `docs/sprints/SPRINT_3_PR_REVIEW.md`

## Siguiente paso lógico

Abrir Sprint 4 solo como sprint de integración controlada OpenClaw ↔ Vault, después de contrastar en host qué partes siguen siendo únicamente diseño objetivo.

El orden prudente es:

1. verificar estado real del vault y de Syncthing en host;
2. cerrar ownership y permisos efectivos;
3. habilitar, si procede, una primera zona de escritura real del agente;
4. mantener HITL y mínimo privilegio como baseline.

## Prompt breve de arranque para Sprint 4

Usa Sprint 3 como baseline documental.
No asumas despliegue previo de vault ni de Syncthing.
Primero contrasta estado real observado en host, después define la primera integración controlada OpenClaw ↔ Vault con HITL, mínimo privilegio y zonas de escritura limitadas.
