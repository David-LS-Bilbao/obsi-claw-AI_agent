# SPRINT_3_CIERRE_BORRADOR.md

## Resumen ejecutivo

Sprint 3 queda preparado para cierre documental como sprint de arquitectura, gobierno del vault y preparación segura de una futura integración controlada OpenClaw ↔ Vault.

El resultado de este sprint no es un despliegue. El resultado es una base documental coherente para:

- vault canónico en VPS como diseño objetivo;
- Syncthing como solución prevista de sincronización;
- política de ownership;
- separación vault/runtime;
- conflictos, exclusiones y backups;
- zonas controladas de escritura del agente.

Nada de lo anterior debe leerse como activado en host por el solo hecho de existir estos documentos.

## Alcance realmente cubierto por Sprint 3

Sprint 3 cubre documentalmente:

- decisión de arquitectura del vault canónico como diseño objetivo;
- política de ownership y límites de escritura del agente;
- postura prudente de Syncthing;
- postura de acceso seguro a la GUI;
- convención de carpetas y zonas controladas;
- baseline de conflictos, exclusiones y backups;
- preparación de relevo hacia Sprint 4.

Sprint 3 no cubre:

- instalación de Syncthing;
- creación material del vault en DAVLOS;
- configuración real de usuario, permisos o servicio;
- integración operativa OpenClaw ↔ Vault;
- escritura efectiva del agente sobre el vault real.

## Decisiones cerradas documentalmente

- el vault canónico en DAVLOS queda fijado como decisión de producto y diseño objetivo;
- Syncthing queda fijado como solución prevista de sincronización;
- el runtime del agente debe permanecer separado del vault;
- el agente no queda autorizado para escribir libremente sobre toda la bóveda;
- la escritura del agente se limita, como baseline, a zonas controladas bajo `Agent/`;
- la promoción desde zonas del agente a conocimiento estable requiere HITL;
- la postura base es mínimo privilegio tanto para lectura como para escritura.

## Qué NO se activó todavía

- no se ha desplegado Syncthing en este sprint;
- no se ha dado por creado el vault canónico en DAVLOS;
- no se ha abierto la GUI de Syncthing;
- no se han fijado permisos efectivos en host;
- no se ha activado escritura real del agente sobre el vault;
- no se ha abierto Sprint 4 operativamente.

## Pendiente de verificación en host

- la ruta operativa real del vault canónico;
- si la zona del agente vivirá dentro del vault principal o en carpeta hermana;
- el usuario y grupo efectivos para vault y Syncthing;
- permisos POSIX o ACL concretas;
- exclusiones exactas de sincronización;
- estrategia operativa real de backup, restore y validación;
- método exacto de acceso seguro a la GUI;
- postura final por plataforma, especialmente iOS.

## Entregables creados

- `docs/architecture/ADR-001-VAULT-CANONICO-VPS-SYNCTHING.md`
- `docs/architecture/ADR-002-OWNERSHIP-Y-LIMITES-DE-ESCRITURA-DEL-VAULT.md`
- `docs/runbooks/SYNCTHING_DAVLOS_PREPARACION.md`
- `docs/runbooks/SYNCTHING_GUI_ACCESO_SEGURO.md`
- `docs/vault/CONVENCION_DE_CARPETAS_Y_ZONAS.md`
- `docs/vault/CONFLICTOS_EXCLUSIONES_Y_BACKUPS.md`
- `docs/sprints/SPRINT_3_BORRADOR.md`
- `docs/sprints/SPRINT_3_CIERRE_BORRADOR.md`
- `docs/sprints/SPRINT_3_PR_REVIEW.md`
- `RESUMEN_SPRINT_3.md`

## Riesgos residuales

- confundir diseño objetivo con estado real observado;
- abrir más superficie de la necesaria al preparar Syncthing;
- diluir ownership del conocimiento del usuario;
- permitir que el agente salga de zonas controladas;
- tratar Syncthing como sustituto de backup;
- llegar a Sprint 4 sin validar primero el estado real del host.

## Criterio de cierre documental del sprint

Sprint 3 puede darse por cerrado documentalmente si:

- existe una arquitectura documental coherente del vault canónico;
- existe una política clara de ownership y límites de escritura;
- existe una postura prudente de Syncthing y de su GUI;
- existe convención canónica de carpetas y zonas;
- existe baseline documental de conflictos, exclusiones y backups;
- queda explícito qué sigue `pendiente de verificación en host`;
- el relevo hacia Sprint 4 queda preparado sin activar todavía cambios operativos.

## Condiciones previas para abrir Sprint 4

Antes de abrir Sprint 4 deberían cumplirse estas condiciones:

- releer los artefactos canónicos de Sprint 3;
- contrastar en host qué partes siguen solo como diseño objetivo;
- decidir la ruta real del vault y la forma final de la zona del agente;
- decidir usuario, ownership y límites efectivos;
- confirmar la postura operativa de Syncthing y de la GUI;
- no asumir que la existencia de estos documentos sustituye validación host-side.
