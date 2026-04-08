# Cierre de Validación Android - Sprint 3

**Fecha:** 2026-04-08

## Alcance

Este documento cierra el bloque Android del Sprint 3 en DAVLOS. Recoge el estado real validado en host para WireGuard, Syncthing, Obsidian Android y la comprobación de backup/restore del vault. No activa Sprint 4, no toca OpenClaw y no introduce cambios adicionales de configuración.

## Resumen ejecutivo

Android quedó validado como segundo cliente controlado del entorno, después de Windows. El túnel WireGuard Android funciona, el peer quedó persistido correctamente en `/etc/wireguard/wg0.conf`, Syncthing Android conecta de forma estable con DAVLOS, Obsidian Android abre el vault correcto y la prueba funcional de escritura se propagó al vault canónico. El único cambio de red necesario fue una regla UFW mínima y específica para permitir `tcp/22000` por `wg0` desde `10.90.0.4` hacia `10.90.0.1`. Se cerró además con backup fresco, checksum y restore de comprobación fuera del vault vivo.

## Estado inicial al retomar Android

Al retomar el bloque Android, el VPS ya tenía `wg0` sano y al menos un cliente Windows funcionando correctamente. Syncthing servidor también estaba sano, pero Android todavía no estaba plenamente integrado. El peer Android no estaba persistido en fichero al inicio; primero se trabajó en runtime para validar conectividad sin riesgo y después se avanzó hacia la persistencia segura.

## Incidencia principal encontrada

La incidencia principal no estaba en WireGuard, sino en la conectividad de Syncthing sobre la VPN. Android conseguía llegar por WireGuard, pero Syncthing Android seguía mostrando DAVLOS como "Desconectado". El diagnóstico real mostró que UFW tenía política `INPUT DROP` y no existía una regla `ACCEPT` para `22000/tcp` por `wg0`, por lo que el servidor recibía intentos TCP desde Android pero no completaba la aceptación de la sesión.

## Diagnóstico realizado

Se siguió un enfoque de evidencia primero y cambio mínimo después:

- Verificación read-only del estado de `wg0`, peers, rutas y escucha UDP.
- Carga inicial del peer Android en caliente con `wg set` para evitar tocar `wg0.conf` prematuramente.
- Validación del material cliente Android y creación de variante IPv4 explícita para eliminar dudas sobre resolución de `davlos.es`.
- Confirmación posterior de handshake real, tráfico y ping entre DAVLOS (`10.90.0.1`) y Android (`10.90.0.4`).
- Localización de la configuración real activa de Syncthing en `/var/lib/syncthing/.local/state/syncthing/config.xml`.
- Confirmación por API local de que el dispositivo Android existía en `devices` y estaba autorizado en `vault-main`.
- Capturas `tcpdump` y revisión de firewall/políticas del host, que permitieron aislar el problema real en UFW/iptables/nft.

## Cambios mínimos aplicados

Se aplicaron únicamente cambios mínimos, específicos y reversibles:

### WireGuard

- El peer Android `10.90.0.4/32` se cargó primero en caliente con `wg set` para validar operación sin tocar `wg0.conf`.
- Una vez validado el funcionamiento, se persistió correctamente en `/etc/wireguard/wg0.conf`.
- La persistencia se hizo con backup previo y edición atómica, sin reiniciar `wg-quick@wg0` y sin hacer `wg-quick down/up`.

### Firewall

- Se detectó que `22000/tcp` no estaba permitido en `wg0`.
- La solución mínima aplicada fue permitir `tcp/22000` solo en `wg0`, solo desde `10.90.0.4` hacia `10.90.0.1`.
- No se abrió `22000/tcp` públicamente, no se permitió `0.0.0.0/0` y no se tocó `ens6`.

## Estado final validado

El estado final validado del bloque Android es el siguiente:

- WireGuard Android funcional.
- Peer Android `10.90.0.4/32` persistido correctamente en `/etc/wireguard/wg0.conf`.
- Syncthing Android conectado y estable contra DAVLOS.
- `vault-main` operativo como carpeta válida final.
- Ruta local Android real validada: `/storage/emulated/0/Obsidian`.
- La carpeta duplicada `Obsi-Claw` quedó como no compartida para evitar duplicidad sobre la misma ruta local.
- Obsidian Android abre el vault correctamente.
- La nota de prueba `android-sync-test` creada en `00_Inbox` en Android se propagó al vault canónico.
- Backup fresco, checksum y restore de comprobación fuera del vault vivo validados.

## Evidencias clave

- Android validado como segundo cliente controlado, después de Windows.
- WireGuard:
  - Peer Android: `10.90.0.4/32`
  - Carga inicial en caliente con `wg set`
  - Persistencia posterior correcta en `/etc/wireguard/wg0.conf`
- Problema real encontrado:
  - UFW con `INPUT DROP`
  - ausencia de regla `ACCEPT` para `22000/tcp` por `wg0`
- Solución mínima aplicada:
  - permitir `tcp/22000` solo en `wg0`, solo desde `10.90.0.4` hacia `10.90.0.1`
- Syncthing:
  - DAVLOS conectado
  - `vault-main` operativo
  - necesidad operativa de mantener una sola carpeta válida
  - `Obsi-Claw` no compartida para evitar duplicidad sobre la misma ruta local Android
- Obsidian Android:
  - apertura correcta del vault
- Prueba funcional:
  - creación de `android-sync-test` en `00_Inbox`
  - propagación al vault canónico confirmada
- Backup/restore:
  - backup fresco generado en `/opt/backups/obsidian/vault-main-20260408T113905Z.tar.zst`
  - checksum generado en `/opt/backups/obsidian/vault-main-20260408T113905Z.tar.zst.sha256`
  - restore de comprobación validado en `/tmp/obsidian-restore-vault-main_20260408T113905Z`

## Decisiones operativas resultantes

- Mantener `vault-main` como única carpeta válida de sincronización para Android.
- Mantener `Obsi-Claw` como carpeta no compartida para evitar doble mapeo sobre la misma ruta local.
- Conservar la regla UFW mínima específica para Syncthing sobre `wg0`.
- Considerar el peer Android ya persistido y estable para reinicios futuros del servicio.
- Mantener OpenClaw fuera de este bloque y fuera de cualquier cambio colateral.

## Riesgos/limitaciones que siguen fuera de alcance

- No se activó Sprint 4.
- No se hicieron pruebas agresivas de conflicto o edición concurrente compleja entre clientes.
- No se amplió la superficie de acceso de Syncthing fuera de la VPN.
- No se revisó ni modificó OpenClaw.
- La configuración queda validada para este escenario controlado, pero cualquier expansión a nuevos clientes o cambios de rutas debe repetirse con el mismo enfoque de evidencia y cambios mínimos.

## Próximo paso recomendado

El siguiente paso recomendado es cerrar formalmente el Sprint 3 en documentación operativa y, si se decide continuar el roadmap, abrir un bloque separado y explícito para el Sprint 4 sin mezclarlo con Android. Cualquier nueva fase debe partir del estado validado actual, mantener `vault-main` como fuente operativa correcta y preservar la separación respecto a OpenClaw.

## Checklist final

- WireGuard Android OK
- Syncthing Android OK
- Obsidian Android OK
- Backup/restore OK
- OpenClaw sigue separado
- Sprint 4 no activado

## Conclusión

El bloque Android puede darse por cerrado operativamente. La integración quedó validada extremo a extremo con cambios mínimos y controlados, sin activar Sprint 4 y sin tocar OpenClaw.
