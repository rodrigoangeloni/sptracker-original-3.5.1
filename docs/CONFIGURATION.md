# Guía de Configuración

## Archivo de Configuración Principal

**Ubicación**: `stracker/stracker.ini`  
**Generado automáticamente** al primer inicio  
**Formato**: Archivo INI con secciones

### Estructura General

```ini
[STRACKER_CONFIG]
# Configuración general del sistema
option = value

[DATABASE]
# Configuración de base de datos
type = sqlite
file = stracker.db

[HTTP_CONFIG]
# Configuración del servidor web
enabled = yes
listen_port = 8080
```

## Secciones de Configuración

### [STRACKER_CONFIG]

Configuración general del sistema SPTracker.

| Opción | Tipo | Default | Descripción |
|--------|------|---------|-------------|
| `ac_server_cfg_ini` | string | "" | Ruta al server_cfg.ini de Assetto Corsa |
| `ac_server_working_dir` | string | "" | Directorio de trabajo del servidor AC |
| `ac_server_address` | string | "127.0.0.1" | Dirección IP del servidor AC |
| `listening_port` | int | 50000 | Puerto de escucha del servidor SPTracker |
| `server_name` | string | "SPTracker Server" | Nombre del servidor |
| `log_file` | string | "stracker.log" | Archivo de log principal |
| `log_level` | string | "INFO" | Nivel de logging (DEBUG, INFO, WARNING, ERROR) |
| `append_log_file` | bool | yes | Si añadir o sobrescribir log |
| `ptracker_connection_mode` | string | "auto" | Modo de conexión (auto, client, server) |
| `lower_priority` | bool | no | Ejecutar con baja prioridad |
| `keep_alive_ptracker_conns` | bool | yes | Mantener conexiones activas |
| `guids_based_on_driver_names` | bool | no | Usar nombres de pilotos como GUIDs |

### [DATABASE]

Configuración de la base de datos.

| Opción | Tipo | Default | Descripción |
|--------|------|---------|-------------|
| `database_type` | string | "sqlite" | Tipo de BD (sqlite, postgres) |
| `database_file` | string | "stracker.db" | Archivo SQLite |
| `postgres_host` | string | "localhost" | Host PostgreSQL |
| `postgres_user` | string | "" | Usuario PostgreSQL |
| `postgres_db` | string | "" | Base de datos PostgreSQL |
| `postgres_pwd` | string | "" | Contraseña PostgreSQL |
| `perform_backups` | bool | yes | Realizar backups automáticos |

### [HTTP_CONFIG]

Configuración del servidor web.

| Opción | Tipo | Default | Descripción |
|--------|------|---------|-------------|
| `enabled` | bool | yes | Habilitar servidor web |
| `listen_port` | int | 8080 | Puerto de escucha HTTP |
| `listen_addr` | string | "0.0.0.0" | Dirección de escucha |
| `admin_username` | string | "admin" | Usuario administrador |
| `admin_password` | string | "admin" | Contraseña administrador |
| `items_per_page` | int | 50 | Elementos por página |
| `banner` | string | "" | Banner personalizado |
| `enable_svg_generation` | bool | yes | Generar gráficos SVG |
| `log_requests` | bool | no | Log de requests HTTP |
| `auth_log_file` | string | "" | Archivo de log de autenticación |
| `max_streaming_clients` | int | 10 | Máximo clientes streaming |
| `lap_times_add_columns` | string | "" | Columnas adicionales en tiempos |
| `inverse_navbar` | bool | no | Navbar invertido |
| `velocity_unit` | string | "kmh" | Unidad de velocidad (kmh, mph) |
| `temperature_unit` | string | "celsius" | Unidad de temperatura |

### [SESSION_MANAGEMENT]

Gestión de sesiones de carrera.

| Opción | Tipo | Default | Descripción |
|--------|------|---------|-------------|
| `race_over_strategy` | string | "keep" | Estrategia fin de carrera |
| `wait_secs_before_skip` | int | 30 | Segundos antes de saltar sesión |

### [MESSAGES]

Configuración de mensajes.

| Opción | Tipo | Default | Descripción |
|--------|------|---------|-------------|
| `car_to_car_collision_msg` | string | "" | Mensaje colisión coche-coche |
| `message_types_to_send_over_chat` | string | "" | Tipos de mensajes por chat |
| `best_lap_time_broadcast_threshold` | float | 0.0 | Umbral broadcast mejor vuelta |

### [DB_COMPRESSION]

Compresión de base de datos.

| Opción | Tipo | Default | Descripción |
|--------|------|---------|-------------|
| `mode` | string | "none" | Modo de compresión |
| `interval` | int | 3600 | Intervalo en segundos |
| `needs_empty_server` | bool | no | Requiere servidor vacío |

### [WELCOME_MSG]

Mensajes de bienvenida.

| Opción | Tipo | Default | Descripción |
|--------|------|---------|-------------|
| `line1` - `line6` | string | "" | Líneas del mensaje de bienvenida |

### [ACPLUGIN]

Configuración del plugin de Assetto Corsa.

| Opción | Tipo | Default | Descripción |
|--------|------|---------|-------------|
| `rcvPort` | int | 12000 | Puerto recepción |
| `sendPort` | int | 12001 | Puerto envío |
| `proxyPluginPort` | int | 12002 | Puerto proxy plugin |
| `proxyPluginLocalPort` | int | 12003 | Puerto proxy local |

### [LAP_VALID_CHECKS]

Validación de vueltas.

| Opción | Tipo | Default | Descripción |
|--------|------|---------|-------------|
| `invalidateOnEnvCollisions` | bool | no | Invalidar por colisiones ambientales |
| `invalidateOnCarCollisions` | bool | no | Invalidar por colisiones entre coches |
| `ptrackerAllowedTyresOut` | int | 0 | Neumáticos permitidos fuera |

## Variables de Entorno

### STRACKER_CONFIG
```bash
export STRACKER_CONFIG=/path/to/stracker.ini
```
Especifica la ruta al archivo de configuración personalizado.

### PYTHONPATH
```bash
export PYTHONPATH=/path/to/sptracker:$PYTHONPATH
```
Incluye el directorio del proyecto en el path de Python.

## Configuración por Base de Datos

### SQLite (Configuración Mínima)

```ini
[DATABASE]
database_type = sqlite
database_file = stracker.db
perform_backups = yes
```

**Ventajas**:
- Sin configuración adicional
- Base de datos embebida
- Ideal para uso personal

### PostgreSQL (Configuración Avanzada)

```ini
[DATABASE]
database_type = postgres
postgres_host = localhost
postgres_user = stracker
postgres_db = stracker_db
postgres_pwd = your_password
perform_backups = yes
```

**Requisitos previos**:
1. Instalar PostgreSQL
2. Crear usuario y base de datos
3. Instalar psycopg2: `pip install psycopg2-binary`

## Configuración de Red

### Modos de Conexión

#### Modo Cliente
```ini
[STRACKER_CONFIG]
ptracker_connection_mode = client
ac_server_address = 192.168.1.100
listening_port = 50000
```

#### Modo Servidor
```ini
[STRACKER_CONFIG]
ptracker_connection_mode = server
listening_port = 50000
```

#### Modo Automático
```ini
[STRACKER_CONFIG]
ptracker_connection_mode = auto
```

### Firewall y Puertos

**Puertos requeridos**:
- 8080: Servidor web (HTTP)
- 50000: Comunicación cliente-servidor
- 12000-12003: Plugin Assetto Corsa

## Configuración de Seguridad

### Autenticación Web

```ini
[HTTP_CONFIG]
admin_username = admin
admin_password = secure_password_123
auth_log_file = auth.log
```

### Control de Acceso

```ini
[HTTP_CONFIG]
max_streaming_clients = 10
log_requests = yes
```

### Validación de Datos

```ini
[LAP_VALID_CHECKS]
invalidateOnEnvCollisions = yes
invalidateOnCarCollisions = yes
ptrackerAllowedTyresOut = 2
```

## Configuración de Rendimiento

### Optimizaciones para Servidores Grandes

```ini
[DB_COMPRESSION]
mode = daily
interval = 86400
needs_empty_server = yes

[HTTP_CONFIG]
items_per_page = 100
max_streaming_clients = 50
enable_svg_generation = no
```

### Configuración para Desarrollo

```ini
[STRACKER_CONFIG]
log_level = DEBUG
append_log_file = no

[HTTP_CONFIG]
log_requests = yes
```

## Troubleshooting de Configuración

### Problemas Comunes

#### "Error reading STRACKER_CONFIG/ac_server_cfg_ini"
- Verificar que la ruta al `server_cfg.ini` de Assetto Corsa sea correcta
- Asegurarse de que Assetto Corsa esté instalado

#### "Database connection failed"
- Para SQLite: verificar permisos de escritura en el directorio
- Para PostgreSQL: verificar credenciales y conectividad

#### "HTTP server failed to start"
- Verificar que el puerto 8080 no esté en uso
- Comprobar permisos de red

### Validación de Configuración

Ejecutar el servidor con `--check-config` para validar la configuración:

```bash
python stracker/stracker.py --check-config
```

### Logs de Configuración

Los errores de configuración se registran en:
- `stracker.log`: Log principal
- `auth.log`: Log de autenticación (si configurado)
- Consola: Durante el inicio

## Configuración Avanzada

### Personalización de Mensajes

```ini
[WELCOME_MSG]
line1 = Bienvenido a SPTracker Server
line2 = Reglas del servidor:
line3 = - Respeta a otros pilotos
line4 = - No bloquees intencionalmente
line5 = - Diverte conduciendo seguro
line6 = ¡Disfruta la carrera!
```

### Configuración de Chat

```ini
[MESSAGES]
message_types_to_send_over_chat = best_lap,collision,pit
best_lap_time_broadcast_threshold = 2.0
car_to_car_collision_msg = ¡Colisión detectada!
```

### Optimización de Base de Datos

```ini
[DB_COMPRESSION]
mode = weekly
interval = 604800
needs_empty_server = yes
```

Esta configuración comprime datos antiguos semanalmente, requiriendo que el servidor esté vacío durante el proceso.