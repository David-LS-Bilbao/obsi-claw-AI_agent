# OPENCLAW_VAULT_ROLLBACK_AGENT_ZONE_SPRINT_4.md

## Propósito

Definir la estrategia mínima de rollback para artefactos del agente en `Agent/` durante Sprint 4.

## Estado real observado

Sprint 3 ya dejó validado en host que:

- el vault tiene backup manual trazable;
- existe restore de prueba fuera del vault vivo;
- OpenClaw no está integrado todavía con el vault.

## Decisión documental cerrada

La política inicial de rollback será conservadora:

- create-only por defecto;
- retirada o archivo manual de artefactos del agente;
- snapshot previo obligatorio si en una fase posterior se autoriza update de notas del agente;
- backup del vault como fallback mayor.

Syncthing no cuenta como rollback.

## Alcance

Este runbook cubre solo:

- `Agent/Drafts_Agent/`
- `Agent/Reports_Agent/`
- `Agent/Heartbeat/`

No cubre:

- restore sobre el vault vivo;
- rollback de sync;
- conflictos cliente/cliente;
- notas núcleo del usuario.

## Create-only rollback simple

Si el agente crea un artefacto incorrecto:

1. el humano revisa el archivo generado;
2. el humano lo retira o lo archiva manualmente;
3. se conserva la trazabilidad mínima del incidente;
4. no se modifica ninguna nota núcleo como parte del rollback.

## Política futura si se permiten updates

Si una fase posterior permite actualizar notas ya gestionadas por el agente:

- deberá existir snapshot previo del archivo;
- deberá registrarse la relación entre versión previa y versión nueva;
- el update no se autoriza sin rollback local explícito.

Esto sigue `pendiente de verificación en host`.

## Relación con el backup del vault

El backup validado en Sprint 3 es la red de seguridad mayor.

Se usa cuando:

- el problema supera la retirada simple de un artefacto;
- hay dudas sobre integridad del árbol del agente;
- se requiere reconstrucción fuera del vault vivo.

## Validación

La validación mínima documental exige:

- rollback simple por retirada o archivo manual;
- create-only como baseline;
- distinción clara entre rollback local del agente y restore completo del vault.

La validación real del procedimiento queda `pendiente de verificación en host`.

## Riesgos

- confiar en Syncthing como reversión;
- permitir updates sin snapshot previo;
- mezclar rollback del agente con restauración completa del vault;
- perder trazabilidad al retirar artefactos erróneos.

## Pendiente de verificación en host

- la ruta exacta de archivo manual de artefactos rechazados;
- si el snapshot por archivo se hará dentro de `Agent/` o fuera;
- el procedimiento real para correlacionar artefacto fallido y run_id;
- cualquier restore real sobre el vault vivo.
