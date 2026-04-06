# SYNCTHING_GUI_ACCESO_SEGURO.md

## Propósito

Definir la postura segura de acceso administrativo a la GUI de Syncthing en DAVLOS.

## Estado

Baseline host-side mínima validada en Sprint 3.

## Estado real observado

Ya quedó validado en host que:

- la GUI escucha en `127.0.0.1:8384`;
- exige autenticación local;
- no hay listeners públicos de Syncthing;
- el listener TCP de sincronización quedó en `127.0.0.1:22000`.

## Decisión documental cerrada

La postura baseline es:

- GUI solo en loopback;
- sin exposición pública por defecto;
- administración local o por canal privado controlado cuando llegue a ser necesario;
- nada de mezclar acceso humano a la GUI con automatización del agente.

## Qué no debe hacerse

- exponer la GUI a Internet;
- abrir puertos públicos “solo para probar”;
- dejar la GUI accesible desde redes no controladas;
- persistir credenciales o tokens en el repositorio.

## Riesgos

- ampliar superficie de administración del nodo canónico;
- mezclar acceso humano y automatización;
- normalizar atajos inseguros por comodidad operativa.

## Cierre de Sprint 3

La postura `localhost-only` ya basta para el cierre de Sprint 3.

Cualquier método administrativo remoto adicional queda fuera del alcance de este cierre y no bloquea el sprint.

## Rollback documental

Si la postura segura deja de estar clara:

1. volver a `localhost-only`;
2. no publicar puertos;
3. no abrir acceso administrativo adicional;
4. registrar el punto como no apto para avanzar hacia pairing.
