# SPRINT_3_BORRADOR.md

## Estado

Borrador de trabajo de Sprint 3.

No autoriza despliegue en host por sí solo.

## Objetivo real

Consolidar la base documental y arquitectónica para:

- vault canónico en VPS;
- Syncthing como solución prevista de sincronización;
- política de ownership;
- separación vault/runtime;
- conflictos, exclusiones y backups;
- zonas controladas de escritura del agente;
- preparación segura para una futura integración controlada OpenClaw ↔ Vault.

## Alcance

### Dentro de alcance

- ADRs y decisiones de arquitectura;
- runbooks de preparación;
- política de ownership;
- convención de carpetas y zonas;
- conflictos, exclusiones y backups;
- criterios de Sprint 4.

### Fuera de alcance

- instalar Syncthing;
- abrir la GUI;
- crear el vault en DAVLOS;
- tocar permisos reales del host;
- integrar operativamente OpenClaw con el vault;
- dar escritura libre al agente.

## Estado real observado que sirve de baseline

- OpenClaw ya existe como boundary en DAVLOS;
- Sprint 2 cerró técnicamente `egress/allowlist`;
- Telegram sigue en ámbar;
- no hay evidencia en este repositorio de que Syncthing esté desplegado;
- no hay evidencia en este repositorio de que el vault canónico exista ya en host.

Los dos últimos puntos quedan `pendiente de verificación en host`.

## Precedencia y divergencias

- la evidencia verificable y el estado real observado prevalecen sobre documentos históricos;
- `davlos-control-plane` sigue siendo referencia operativa del VPS;
- algunas piezas de `davlos-control-plane` conservan cautelas históricas sobre OpenClaw y egress, así que deben leerse con fecha y alcance;
- este sprint no reabre Sprint 2, salvo para mantener coherencia documental mínima cuando haya contradicción explícita.

## Decisiones ya cerradas

- el vault canónico debe vivir en DAVLOS como decisión de producto;
- Syncthing es la solución prevista de sincronización;
- el runtime del agente permanece separado del vault;
- el agente no escribe libremente sobre toda la bóveda;
- la promoción a notas núcleo requiere HITL.

## Decisiones abiertas

- si la subzona del agente vive dentro del vault principal o en carpeta hermana;
- ownership exacto en host;
- usuario del sistema para Syncthing;
- exclusiones exactas de sync;
- política concreta de conflictos;
- estrategia mínima de backup y restore;
- postura exacta para iOS;
- método final de acceso seguro a la GUI.

## Entregables esperados

- `docs/architecture/ADR-001-VAULT-CANONICO-VPS-SYNCTHING.md`
- `docs/architecture/ADR-002-OWNERSHIP-Y-LIMITES-DE-ESCRITURA-DEL-VAULT.md`
- `docs/runbooks/SYNCTHING_DAVLOS_PREPARACION.md`
- `docs/runbooks/SYNCTHING_GUI_ACCESO_SEGURO.md`
- `docs/vault/CONVENCION_DE_CARPETAS_Y_ZONAS.md`
- `docs/vault/CONFLICTOS_EXCLUSIONES_Y_BACKUPS.md`
- `docs/sprints/SPRINT_3_BORRADOR.md`
- `docs/sprints/SPRINT_3_CIERRE_BORRADOR.md`
- `RESUMEN_SPRINT_3.md`

## Riesgos principales

- mezclar vault y runtime del agente;
- abrir la GUI de Syncthing sin perímetro claro;
- permitir escritura demasiado amplia al agente;
- confundir decisión de diseño con estado ya desplegado;
- tratar Syncthing como sustituto de backup.

## Criterio de cierre

Sprint 3 puede cerrarse documentalmente si:

- existe política clara de ownership y límites de escritura;
- existe postura prudente de Syncthing;
- existe convención de carpetas;
- existe postura mínima de conflictos, exclusiones y backups;
- queda explícito qué sigue `pendiente de verificación en host`;
- Sprint 4 queda preparado sin activar todavía integración operativa.
