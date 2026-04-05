# SYNCTHING_GUI_ACCESO_SEGURO.md

## Propósito

Definir la postura recomendada de acceso seguro a la GUI de Syncthing para DAVLOS sin asumir despliegue real.

## Estado

Borrador de Sprint 3.

Todo bind, puerto, servicio o acceso real queda `pendiente de verificación en host`.

## Baseline recomendada

- GUI accesible solo por localhost;
- sin exposición pública por defecto;
- acceso remoto únicamente mediante túnel SSH o equivalente controlado;
- sin publicar la GUI en IP pública del VPS.

## Motivo

Abrir la GUI de Syncthing sin perímetro claro introduce superficie innecesaria sobre el nodo canónico del conocimiento.

## Modelo recomendado

### Opción base

- bind local en loopback;
- túnel SSH cuando haga falta administración;
- sesiones puntuales y auditables.

### Opción alternativa controlada

Un canal privado equivalente puede evaluarse más adelante, pero queda `pendiente de verificación en host`.

## Qué no debe hacerse por defecto

- exponer la GUI a Internet;
- abrir puertos públicos “solo para probar”;
- dejar la GUI accesible desde redes no controladas;
- mezclar acceso de usuario final con automatización del agente.

## Validaciones mínimas antes de cualquier acceso real

- confirmar bind efectivo y alcance de escucha;
- confirmar usuario del servicio;
- confirmar que el canal de acceso no rompe la política de mínimo privilegio;
- confirmar que no se exponen credenciales ni tokens;
- confirmar rollback claro para cerrar acceso.

## Riesgos

- exposición innecesaria de superficie de administración;
- acceso desde redes no previstas;
- confusión entre acceso humano y acceso del agente;
- credenciales persistidas en lugares inadecuados.

## Rollback documental

Si la postura de acceso seguro no está clara:

1. no abrir GUI;
2. no publicar puertos;
3. mantener Syncthing sin exposición administrativa remota;
4. registrar el punto como `pendiente de verificación en host`.

## Pendiente de verificación en host

- puerto exacto de GUI si se instala Syncthing;
- unidad de servicio;
- método operativo preferido entre túnel SSH u otro canal controlado;
- si existe algún requisito adicional del entorno DAVLOS.
