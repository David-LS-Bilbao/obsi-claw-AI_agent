# Manual de Instalación — Obsi-Claw MVP

## 1. Propósito

Este manual resume la instalación y puesta en marcha del MVP de Obsi-Claw en su alcance real y prudente.

No sustituye los runbooks detallados del proyecto ni debe leerse como receta para ampliar el sistema sin validación.

## 2. Alcance de esta instalación

La instalación del MVP cubre:

- vault canónico en DAVLOS;
- baseline de Syncthing;
- boundary OpenClaw ya materializado en host;
- helper readonly para observabilidad controlada;
- continuidad mínima del vault;
- continuidad mínima del boundary;
- Telegram mínimo.

No cubre:

- optimizaciones futuras;
- sincronización productiva completa;
- reconstrucción reproducible completa del boundary;
- validación completa de Windows.

## 3. Prerrequisitos

### Infraestructura

- VPS DAVLOS operativo.
- Repositorios disponibles:
  - `obsi-claw-AI_agent`
  - `davlos-control-plane`

### Base técnica mínima

- runtime OpenClaw disponible en el host;
- inference gateway operativo;
- vault en `/opt/data/obsidian/vault-main`;
- Syncthing instalado;
- acceso de operador para validaciones mínimas;
- canal Telegram ya configurado en su perímetro mínimo.

## 4. Orden de despliegue recomendado

### Paso 1 — Validar la base documental y operativa

Revisar como referencia:

- `README.md`
- `RESUMEN.md`
- `docs/ESTADO_GLOBAL.md`
- `docs/MEMORIA_TECNICA_FINAL_OBSI_CLAW.md`
- `docs/PLAN_DE_PRUEBAS_FINAL_MVP_OBSI_CLAW.md`

### Paso 2 — Confirmar vault canónico

Validar que:

- el vault canónico existe;
- el ownership y permisos base son los previstos;
- la estructura mínima del vault está materializada.

### Paso 3 — Confirmar baseline de Syncthing

Validar que:

- `syncthing@syncthing.service` existe y está activo;
- `vault-main` está configurado;
- la GUI local y el acceso se mantienen en el perímetro esperado;
- el cliente Android puede usarse en validación mínima.

### Paso 4 — Confirmar boundary OpenClaw

Validar que:

- el runtime boundary está materializado;
- el gateway y la inferencia están operativos;
- el helper readonly está disponible;
- Telegram está configurado en su contrato mínimo.

### Paso 5 — Confirmar continuidad mínima del vault

Validar que:

- existe backup diario mínimo del vault;
- existe restore-check manual no destructivo validado.

### Paso 6 — Confirmar continuidad mínima del boundary

Validar que:

- existe bundle externo mínimo del boundary;
- existe backup root-only de secretos;
- existe rebuild rehearsal mínimo validado fuera de producción.

### Paso 7 — Confirmar operación mínima

Validar que:

- la rutina diaria mínima es ejecutable;
- la rutina semanal mínima es ejecutable;
- Syncthing y Telegram cumplen el alcance mínimo del MVP.

## 5. Validación mínima posterior a instalación

La instalación no debe darse por buena sin validar al menos:

- salud básica del boundary;
- helper readonly operativo;
- backup diario del vault;
- restore-check del vault;
- bundle del boundary;
- backup de secretos;
- rebuild rehearsal;
- Syncthing con Android;
- Telegram `/status`.

La referencia de cierre de esta validación es:

- `docs/PLAN_DE_PRUEBAS_FINAL_MVP_OBSI_CLAW.md`

## 6. Criterio de instalación correcta

La instalación del MVP puede considerarse correcta si:

- el sistema queda operable en su alcance mínimo;
- la continuidad mínima del vault y del boundary queda presente;
- la observabilidad mínima funciona;
- Syncthing y Telegram cumplen la validación mínima realista;
- no aparece un bloqueo crítico nuevo.

La instalación no debe venderse como “completa” si siguen existiendo elementos `pendiente de verificación en host`.

## 7. Límites aceptados de la instalación

Incluso con la instalación correcta, siguen siendo límites aceptados:

- Windows `pendiente de verificación en host`;
- warning `Unexpected folder "Obsi-Claw"` en ámbar;
- `.obsidian/workspace.json` como benigno probable;
- Telegram con degradación histórica observable;
- continuidad integral exacta del boundary aún abierta.

## 8. Documentación mínima asociada

Documentos recomendados para acompañar la instalación:

- [README.md](../README.md)
- [RESUMEN.md](../RESUMEN.md)
- [ESTADO_GLOBAL.md](ESTADO_GLOBAL.md)
- [PLAN_DE_PRUEBAS_FINAL_MVP_OBSI_CLAW.md](PLAN_DE_PRUEBAS_FINAL_MVP_OBSI_CLAW.md)
- [MEMORIA_TECNICA_FINAL_OBSI_CLAW.md](MEMORIA_TECNICA_FINAL_OBSI_CLAW.md)

## 9. Veredicto prudente de instalación

La instalación de Obsi-Claw debe darse por correcta en sentido prudente cuando deja el sistema:

- desplegado;
- observable;
- respaldado en su mínimo viable;
- operable dentro del alcance del MVP;
- y con sus límites residuales claramente visibles.
