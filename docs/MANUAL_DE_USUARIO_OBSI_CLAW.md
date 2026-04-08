# Manual de Usuario — Obsi-Claw MVP

## 1. Propósito

Este manual describe cómo usar Obsi-Claw en su estado de MVP funcional y entregable en sentido prudente.

No describe capacidades no validadas ni presenta el sistema como completamente automático.

## 2. Qué puede hacer el usuario

En el MVP actual, el usuario puede apoyarse en Obsi-Claw para:

- mantener un vault canónico de Obsidian en DAVLOS;
- consultar y operar información del sistema con observabilidad mínima controlada;
- disponer de continuidad mínima del vault y del boundary;
- sincronizar mínimamente el vault con Android mediante Syncthing;
- usar Telegram como canal mínimo de consulta segura;
- operar con una rutina diaria y una rutina semanal mínimas.

## 3. Componentes que ve el usuario

- Vault Obsidian en DAVLOS.
- Syncthing para sincronización mínima del vault.
- Boundary OpenClaw para operación técnica controlada.
- Telegram como canal corto de consulta.
- Helper readonly como vía de observabilidad controlada para operaciones en host.

## 4. Uso normal del sistema

### 4.1 Uso del vault

El vault canónico reside en DAVLOS y actúa como fuente principal de conocimiento operativo y personal.

Uso esperado:

- escribir y consultar notas en las carpetas previstas del vault;
- mantener el vault como fuente de verdad de contenido;
- evitar usar rutas del agente para notas núcleo del usuario.

### 4.2 Uso de Syncthing

Syncthing se usa para sincronización mínima del vault con Android.

Uso prudente:

- comprobar que el cliente Android está conectado;
- verificar sincronización básica cuando sea necesario;
- tratar Windows como `pendiente de verificación en host`.

No debe asumirse:

- sincronización productiva completa;
- equivalencia total entre todos los clientes;
- ausencia de warnings.

### 4.3 Uso de Telegram

Telegram se usa como canal mínimo de operación y consulta.

Uso validado:

- `/status`

Uso prudente:

- tratar Telegram como canal operativo corto;
- no asumir que sustituye la consola o el acceso al host;
- aceptar que existe degradación histórica observable de polling.

### 4.4 Uso de observabilidad mínima

La observabilidad mínima para operación controlada se apoya en:

- helper readonly;
- salidas de runtime resumidas;
- logs operativos recientes acotados.

Esto permite:

- consultar estado;
- revisar señales básicas del boundary;
- hacerlo sin abrir acceso amplio al sistema.

## 5. Operación mínima recomendada

### 5.1 Rutina diaria mínima

La rutina diaria mínima consiste en comprobar:

- salud básica del boundary;
- salud mínima de Syncthing;
- evidencia de backup reciente del vault;
- observabilidad mínima mediante helper readonly;
- errores visibles recientes.

### 5.2 Rutina semanal mínima

La rutina semanal mínima consiste en comprobar:

- backups recientes del vault;
- último restore-check válido del vault;
- bundle externo mínimo del boundary;
- backup de secretos;
- estado operativo mínimo del boundary;
- warnings visibles que sigan en ámbar aceptado.

## 6. Qué hacer si aparece un ámbar conocido

Ámbar aceptados del MVP:

- `Unexpected folder "Obsi-Claw"`;
- `.obsidian/workspace.json` como benigno probable;
- Telegram con warnings históricos de polling;
- Windows `pendiente de verificación en host`;
- continuidad integral exacta del boundary todavía no cerrada.

Acción recomendada:

- no dramatizar;
- registrar el ámbar;
- confirmar que no bloquea el uso básico;
- escalar solo si deja de ser acotado o pasa a bloquear operación.

## 7. Qué no debe hacer el usuario

- no tratar Telegram como interfaz completa del sistema;
- no asumir que Syncthing ya está validado de forma completa en todos los clientes;
- no presentar el sistema como libre de warnings;
- no asumir que existe reconstrucción exacta completa del boundary;
- no dar por cerrada ninguna pieza que siga `pendiente de verificación en host`.

## 8. Criterio de uso estable

En este MVP, `uso estable del sistema` significa:

- uso sostenido;
- capacidades mínimas disponibles;
- ámbar conocidos y no bloqueantes;
- continuidad mínima suficiente para operar.

No significa perfección.

## 9. Veredicto de uso del MVP

Obsi-Claw puede usarse como MVP funcional en sentido prudente para:

- gestionar el vault canónico;
- operar el boundary con observabilidad mínima;
- mantener continuidad mínima;
- utilizar Syncthing y Telegram dentro del alcance ya validado.
