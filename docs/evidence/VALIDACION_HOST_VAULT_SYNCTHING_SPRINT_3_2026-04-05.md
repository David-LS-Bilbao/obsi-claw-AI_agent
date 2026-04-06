# VALIDACION_HOST_VAULT_SYNCTHING_SPRINT_3_2026-04-05.md

## Propósito

Dejar una evidencia textual corta y suficiente del estado host-side alcanzado en Sprint 3 para:

- materialización del vault canónico en DAVLOS;
- instalación mínima y segura de Syncthing como servicio dedicado;
- cierre del plano administrativo local de la GUI;
- mantenimiento explícito de la separación `OpenClaw ↔ vault`.

Fecha de validación:

- `2026-04-05`

## Hechos confirmados

- existe `/opt/data/obsidian/vault-main`;
- el árbol base del vault fue creado con:
  - `00_Inbox/`
  - `10_Proyectos/`
  - `20_Areas/`
  - `30_Recursos/`
  - `40_Operaciones/`
  - `50_Archivado/`
  - `90_Notas_Nucleo_Usuario/`
  - `Agent/Inbox_Agent/`
  - `Agent/Drafts_Agent/`
  - `Agent/Reports_Agent/`
  - `Agent/Heartbeat/`
- el group `obsidian` existe;
- el vault quedó con ownership `devops:obsidian`;
- los directorios del vault quedaron con modo `2770`;
- `syncthing` quedó instalado como paquete del sistema;
- existe y está activo `syncthing@syncthing.service`;
- el usuario de sistema `syncthing` existe y pertenece a `syncthing` y `obsidian`;
- la config real vive en `/var/lib/syncthing/.local/state/syncthing/config.xml`;
- la GUI escucha solo en `127.0.0.1:8384`;
- el listener TCP de Syncthing escucha solo en `127.0.0.1:22000`;
- no hay listeners UDP activos de Syncthing;
- `global discovery`, `local discovery`, `relays` y `NAT` quedaron desactivados;
- `auto-upgrade` y `crash reporting` quedaron desactivados;
- la GUI tiene autenticación local explícita:
  - usuario `syncthing-admin`;
  - contraseña almacenada como hash bcrypt;
- la credencial temporal quedó guardada solo en un archivo `root-only`;
- no hay carpetas activas en Syncthing;
- no hay dispositivos remotos;
- no se hizo pairing;
- no se abrieron puertos públicos;
- no aparecieron referencias runtime nuevas entre OpenClaw y `/opt/data/obsidian`.

## Comandos ejecutados

### Vault host-side

```bash
date -u +%Y%m%dT%H%M%SZ
df -h /opt
ss -lntp | rg '(:8384|:22000|:21027|syncthing)' || true
id devops
getent passwd devops
getent group obsidian || groupadd --system obsidian

install -d -m 0755 /opt/data
install -d -m 0755 /opt/data/obsidian

install -d -o devops -g obsidian -m 2770 /opt/data/obsidian/vault-main
install -d -o devops -g obsidian -m 2770 /opt/data/obsidian/vault-main/00_Inbox
install -d -o devops -g obsidian -m 2770 /opt/data/obsidian/vault-main/10_Proyectos
install -d -o devops -g obsidian -m 2770 /opt/data/obsidian/vault-main/20_Areas
install -d -o devops -g obsidian -m 2770 /opt/data/obsidian/vault-main/30_Recursos
install -d -o devops -g obsidian -m 2770 /opt/data/obsidian/vault-main/40_Operaciones
install -d -o devops -g obsidian -m 2770 /opt/data/obsidian/vault-main/50_Archivado
install -d -o devops -g obsidian -m 2770 /opt/data/obsidian/vault-main/90_Notas_Nucleo_Usuario
install -d -o devops -g obsidian -m 2770 /opt/data/obsidian/vault-main/Agent
install -d -o devops -g obsidian -m 2770 /opt/data/obsidian/vault-main/Agent/Inbox_Agent
install -d -o devops -g obsidian -m 2770 /opt/data/obsidian/vault-main/Agent/Drafts_Agent
install -d -o devops -g obsidian -m 2770 /opt/data/obsidian/vault-main/Agent/Reports_Agent
install -d -o devops -g obsidian -m 2770 /opt/data/obsidian/vault-main/Agent/Heartbeat
```

### Syncthing mínimo como servicio dedicado

```bash
apt-get install -y syncthing
id syncthing 2>/dev/null || useradd --system --home-dir /var/lib/syncthing --create-home --shell /usr/sbin/nologin syncthing
usermod -a -G obsidian syncthing
runuser -u syncthing -- env HOME=/var/lib/syncthing syncthing generate --no-default-folder --skip-port-probing
systemctl enable --now syncthing@syncthing.service
```

### Hardening administrativo de Syncthing

```bash
syncthing cli --gui-address 127.0.0.1:8384 --gui-apikey <local-apikey> config gui auth-mode set static
syncthing cli --gui-address 127.0.0.1:8384 --gui-apikey <local-apikey> config gui user set syncthing-admin
syncthing cli --gui-address 127.0.0.1:8384 --gui-apikey <local-apikey> config gui password set <generated-secret>
syncthing cli --gui-address 127.0.0.1:8384 --gui-apikey <local-apikey> config gui send-basic-auth-prompt set false
systemctl restart syncthing@syncthing.service
```

## Salida relevante observada

### Vault

```text
root:root 755 /opt/data
root:root 755 /opt/data/obsidian
devops:obsidian 2770 /opt/data/obsidian/vault-main
devops:obsidian 2770 /opt/data/obsidian/vault-main/90_Notas_Nucleo_Usuario
devops:obsidian 2770 /opt/data/obsidian/vault-main/Agent
devops:obsidian 2770 /opt/data/obsidian/vault-main/Agent/Inbox_Agent
```

### Syncthing

```text
● syncthing@syncthing.service - Syncthing - Open Source Continuous File Synchronization for syncthing
     Active: active (running)
```

```text
LISTEN 0 4096 127.0.0.1:8384  0.0.0.0:* users:(("syncthing",pid=2309926,fd=13))
LISTEN 0 4096 127.0.0.1:22000 0.0.0.0:* users:(("syncthing",pid=2309926,fd=12))
```

```text
gui_user=syncthing-admin
gui_password_present=True
gui_password_bcrypt_prefix=$2a$
active_folder_count= 0
active_remote_device_count= 0
```

## Artefactos sensibles y operativos

- credencial temporal GUI:
  `/root/syncthing-gui-admin-20260405T232632Z.txt`
- backup previo de config antes del cambio de auth:
  `/var/lib/syncthing/.local/state/syncthing/config.xml.bak.20260405T232632Z`

Estos artefactos existen en host, pero no deben copiarse al repositorio.

## Juicio técnico

Con esta validación, Sprint 3 queda soportado host-side así:

- el vault canónico ya no es solo diseño: existe materializado en DAVLOS;
- Syncthing ya no es solo una idea documental: existe instalado y activo como servicio mínimo;
- la administración quedó cerrada en loopback y por túnel SSH, sin exposición pública;
- el servicio sigue sin carpetas activas y sin dispositivos remotos;
- no existe todavía pairing ni sincronización productiva;
- OpenClaw sigue separado del vault y no recibió integración runtime nueva.
