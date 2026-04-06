# CONVENCION_DE_CARPETAS_Y_ZONAS.md

## Propósito

Definir el árbol base del vault y separar con claridad:

- conocimiento núcleo del usuario;
- zonas controladas del agente;
- zonas delicadas o excluidas.

## Estado

Baseline documental cerrada con materialización host-side del árbol base en Sprint 3.

## Estado real observado

Ya quedó materializado en host:

- `/opt/data/obsidian/vault-main`

Con árbol base:

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

## Decisión documental cerrada

### Ruta base del vault

- `/opt/data/obsidian/vault-main`

### Ruta opcional todavía no materializada

- `/opt/data/obsidian/vault-agent-zone`

La carpeta hermana `vault-agent-zone` queda como opción futura, no como baseline cerrada de Sprint 3.

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

- si conviene una `vault-agent-zone` separada en lugar de `Agent/` dentro del vault principal;
- cualquier control fino adicional de permisos por zona;
- la futura superficie real de lectura del agente.
