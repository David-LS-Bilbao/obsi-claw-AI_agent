# CONVENCION_DE_CARPETAS_Y_ZONAS.md

## Propósito

Definir un árbol inicial recomendado del vault y separar con claridad:

- conocimiento núcleo del usuario;
- zonas controladas del agente;
- zonas delicadas o excluidas.

## Estado

Borrador de Sprint 3.

El árbol aquí descrito es diseño objetivo.
No demuestra estructura ya desplegada en host.

## Ruta base recomendada

- `/opt/data/obsidian/vault-main`

Ruta opcional para una separación más fuerte del agente:

- `/opt/data/obsidian/vault-agent-zone`

Ambas quedan `pendiente de verificación en host`.

## Árbol inicial recomendado

```text
vault-main/
├─ 00_Inbox/
├─ 10_Proyectos/
├─ 20_Areas/
├─ 30_Recursos/
├─ 40_Operaciones/
├─ 50_Archivado/
├─ 90_Notas_Nucleo_Usuario/
└─ Agent/
   ├─ Inbox_Agent/
   ├─ Drafts_Agent/
   ├─ Reports_Agent/
   └─ Heartbeat/
```

## Criterio de zonas

### Núcleo del usuario

Se consideran núcleo del usuario, como baseline:

- `90_Notas_Nucleo_Usuario/`
- índices principales del vault;
- documentación estable del usuario;
- áreas personales o sensibles no autorizadas expresamente.

### Zonas controladas del agente

Se consideran zonas controladas iniciales:

- `Agent/Inbox_Agent/`
- `Agent/Drafts_Agent/`
- `Agent/Reports_Agent/`
- `Agent/Heartbeat/`

Estas rutas son las únicas candidatas de escritura por defecto para el agente.

### Zonas delicadas o excluidas

Deben tratarse con especial cuidado:

- configuraciones de Obsidian;
- adjuntos sensibles;
- notas privadas del usuario;
- índices globales;
- carpetas no incluidas en la política de escritura controlada.

## Política de promoción

La promoción de contenido del agente a conocimiento estable requiere HITL.

Ejemplos:

- de `Agent/Drafts_Agent/` a proyecto o área;
- de `Agent/Reports_Agent/` a documentación estable;
- de `Agent/Inbox_Agent/` a nota estructurada.

## Qué no se autoriza todavía

- escritura del agente fuera de zonas controladas;
- renombrados masivos;
- mantenimiento automático de enlaces;
- borrado automático;
- promoción automática a notas núcleo.

## Pendiente de verificación en host

- si conviene una carpeta `Agent/` dentro del vault principal o una carpeta hermana `vault-agent-zone`;
- el árbol exacto que mejor encaja con el uso real del usuario;
- ownership y permisos efectivos de cada zona.
