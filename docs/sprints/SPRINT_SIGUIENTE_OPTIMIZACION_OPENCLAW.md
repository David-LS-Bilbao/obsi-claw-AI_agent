# SPRINT_SIGUIENTE_OPTIMIZACION_OPENCLAW.md

## Objetivo

Optimizar el boundary OpenClaw ya validado como baseline prudente, priorizando seguridad, observabilidad, estabilidad operativa y prevención de drift entre repositorio operativo, runtime real y documentación de producto.

## Alcance

- endurecimiento prudente del modelo de ownership y permisos observado;
- observabilidad controlada y lectura operativa suficiente para `devops`;
- reducción de drift repo ↔ host en el helper readonly y en la documentación viva;
- mejora prudente de estabilidad operativa de Telegram;
- clarificación de contratos operativos como bind northbound, helper readonly y límites del boundary.

## No alcance

- nuevas features amplias de runtime;
- cambios host-side grandes o irreversibles;
- ampliar la superficie del helper readonly;
- introducir writers no root nuevos sobre el runtime state;
- cambios productivos en Syncthing, vault o flujos de escritura del agente fuera de lo ya validado;
- vender continuidad integral cerrada o reconstrucción reproducible completa.

## Criterio de done

- no quedan contradicciones vivas relevantes entre `obsi-claw-AI_agent` y `davlos-control-plane` sobre la baseline OpenClaw;
- las próximas intervenciones host-side están acotadas en pasos pequeños, reversibles y con rollback;
- el helper readonly queda tratado como vía preferente de observabilidad controlada, sin ampliar superficie;
- el siguiente pase operativo sobre Telegram, ownership/permisos y drift técnico queda descrito sin inventar estado;
- el repo de producto conserva clara la frontera entre diseño, estado validado y trabajo pendiente.

## Riesgos

- sobrerrepresentar el baseline validado como “sistema cerrado”;
- abrir superficie innecesaria por querer mejorar observabilidad demasiado deprisa;
- tocar host sin un precheck suficiente de drift;
- introducir un writer no root sin reevaluar el modelo del `.lock`;
- mezclar optimización prudente con nuevas features que no tocan todavía.

## Dependencias con el repo operativo

- `davlos-control-plane` sigue siendo la referencia para toda validación host-side y todo checkpoint del boundary;
- cualquier intervención real sobre helper, sudoers, Telegram o state runtime debe contrastarse primero con el estado observado en ese repo;
- este sprint no debe tratar como verdad operativa nada que no haya quedado validado y trazado en `davlos-control-plane`.
