# POSTURA_IPHONE_IPAD_SYNCTHING_OBSIDIAN.md

## Propósito

Definir la postura prudente de Sprint 3 para iPhone/iPad respecto a Obsidian + Syncthing.

## Estado

Decisión documental cerrada para Sprint 3.
No validada con dispositivos iOS/iPadOS reales.

## Estado real observado

En DAVLOS ya quedó validado un baseline host-side mínima:

- `vault-main` existe y actúa como nodo canónico;
- Syncthing opera localmente y sin pairing;
- OpenClaw sigue separado;
- existe backup manual con restore de prueba.

## Postura prudente actual

Para Sprint 3, iPhone/iPad no se considera plataforma baseline para el primer pairing real.

La postura recomendada es:

- tratar iOS/iPadOS como plataforma con fricción alta;
- no asumir paridad operativa con escritorio o Android;
- diferir cualquier despliegue real hasta después de validar primero escritorio y/o Android.

## Limitaciones esperables

- restricciones de ejecución en segundo plano;
- más fricción para sincronización continua;
- diferencias en acceso a carpetas locales respecto a escritorio;
- más riesgo de expectativas incorrectas sobre disponibilidad y comportamiento.

## Qué no debe asumirse

- que iPhone/iPad puede ser el primer cliente validado por defecto;
- que Syncthing en iOS/iPadOS ofrece el mismo modelo operativo que escritorio;
- que basta con tener un flujo documental para dar por resuelta la plataforma;
- que la existencia del vault canónico hace trivial el caso iOS.

## Decisión recomendada actual dentro de Sprint 3

- no usar iPhone/iPad como primer cliente de validación;
- no abrir pairing real en iOS/iPadOS dentro de Sprint 3;
- mantener la plataforma documentada como posible línea futura, pero no como GO actual.

## Cierre de Sprint 3

La postura de Sprint 3 queda cerrada como:

- iPhone/iPad no es cliente baseline para el primer pairing;
- cualquier validación real en iPhone/iPad se considera parte del onboarding futuro con clientes y no bloquea el cierre del sprint.
