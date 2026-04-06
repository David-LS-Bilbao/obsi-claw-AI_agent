# SYNCTHING_DAVLOS_PREPARACION.md

## Propósito

Congelar la baseline host-side mínima de Syncthing en DAVLOS y dejar claro qué partes del trabajo de clientes siguen fuera de alcance.

## Estado

Baseline host-side mínima validada en Sprint 3.

## Estado real observado

Ya quedó confirmado en host que:

- Syncthing está instalado y operativo como `syncthing@syncthing.service`;
- usa usuario dedicado `syncthing`;
- la config vive bajo `/var/lib/syncthing`;
- la GUI escucha solo en `127.0.0.1:8384` con auth local;
- el listener TCP escucha solo en `127.0.0.1:22000`;
- `vault-main` quedó dada de alta como carpeta local;
- existe `.stignore` mínimo conservador;
- no hay dispositivos remotos;
- no hay pairing;
- no hay listeners públicos de Syncthing.

## Decisión documental cerrada

La postura baseline para DAVLOS queda así:

- DAVLOS actúa como nodo canónico;
- Syncthing se mantiene local-first y localhost-only en administración;
- el vault vivo no se expone como carpeta remota de edición multiusuario;
- Syncthing no se trata como sustituto de backup;
- OpenClaw sigue separado del vault y de Syncthing.

## Qué no debe hacerse

- abrir la GUI o el listener TCP a IP pública;
- dar por validado un cliente por el solo hecho de existir este runbook;
- convertir `vault-main` en sync productivo sin pairing controlado;
- mezclar la preparación de clientes con cambios en OpenClaw.

## Validaciones ya cerradas

- ruta canónica del vault: `/opt/data/obsidian/vault-main`;
- servicio dedicado de Syncthing;
- carpeta local `vault-main` dada de alta;
- `.stignore` mínimo conservador;
- backup manual y restore de prueba independientes de Syncthing.

## Pendiente de verificación en host

- pairing y onboarding real con clientes.

## Rollback documental

Si en una fase posterior fallan validaciones de clientes:

1. no hacer pairing adicional;
2. no abrir puertos;
3. no ampliar superficie de Syncthing;
4. mantener `vault-main` como carpeta local del nodo canónico;
5. registrar el bloqueo sin tocar OpenClaw.
