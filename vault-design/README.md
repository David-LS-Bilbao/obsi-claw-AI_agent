# README.md

## Objetivo del vault en Sprint 1

En Sprint 1, la vault de Obsidian queda tratada solo como diseño prudente del plano de conocimiento. El objetivo no fue activar integración operativa, sino fijar una postura segura de estructura, ownership y límites de escritura para evitar mezclar documentación útil con automatización prematura.

## Postura vigente

- no activar sync bidireccional;
- no reescribir notas núcleo del usuario;
- no automatizar reorganización estructural agresiva;
- sí permitir, como diseño futuro controlado, zonas de borradores, evidencias, sprints y runbooks donde el agente pueda producir material revisable.

Toda integración operativa real con el runtime desplegado sigue `pendiente de verificación en host`.

## Carpetas base recomendadas

- `00_inbox_agente/`
  - borradores temporales o capturas iniciales del agente.
- `10_evidencias/`
  - evidencias exportadas o resumidas desde verificaciones controladas.
- `20_sprints/`
  - cierres, resúmenes y seguimiento de sprint.
- `30_runbooks_borrador/`
  - runbooks en estado de trabajo y revisión.
- `40_contexto_operativo/`
  - contexto curado, glosarios, mapas o notas derivadas útiles.
- `90_notas_nucleo_usuario/`
  - notas manuales y de referencia estable del usuario; zona no editable por el agente.

## Ownership de escritura recomendado

- el usuario conserva ownership de:
  - notas núcleo;
  - documentación estable;
  - estructura principal de la vault.
- el agente queda limitado a:
  - evidencias;
  - borradores;
  - sprints;
  - runbooks en zonas controladas.
- cualquier paso desde borrador a nota estable debe pasar por HITL.

## Zonas donde el agente NO escribe

- `90_notas_nucleo_usuario/`;
- notas manuales consolidadas del usuario;
- índices principales de la vault sin instrucción explícita;
- convenciones globales de nombres o enlaces sin revisión humana.

## Operaciones que requieren HITL

- promover un borrador a documento canónico;
- mover o borrar notas existentes;
- cambiar carpetas base o taxonomía principal;
- habilitar sync, import/export automático o reconciliación de conflictos;
- autorizar escritura del agente fuera de zonas controladas.

## Qué sí puede producir el agente en un futuro tramo controlado

- capturas de evidencia;
- resúmenes de sprint;
- borradores de runbooks;
- notas de trabajo en áreas controladas;
- índices derivados o resúmenes donde el usuario lo haya autorizado.

## Qué no pasa aún

- sync bidireccional;
- reescritura de notas núcleo del usuario;
- mantenimiento automático de enlaces o renombrados masivos;
- automatización estructural agresiva;
- ownership amplio del agente sobre la vault.

## Qué pasa a Sprint 2

- decidir si existe un flujo prudente de exportación o promoción desde el repo a la vault;
- validar naming y lifecycle de las zonas controladas;
- diseñar plantillas mínimas de sprint, evidencia y runbook para Obsidian;
- mantener toda integración real con HITL y rollback claro.

## Regla operativa final

Si la integración con Obsidian exige asumir conflictos, locking, ownership o sync no resueltos, no se activa.
