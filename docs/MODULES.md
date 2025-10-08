# Documentación de Módulos

## ptracker_lib/ - Biblioteca Central

### Módulos de Comunicación

#### client_server/
**Archivos**: `ac_client_server.py`, `ac_server.py`, `ac_server_base.py`

**Propósito**: Implementa el protocolo de comunicación cliente-servidor.

**Clases principales**:
- `ClientServer`: Interfaz principal para comunicación
- `ServedFunctions`: Funciones expuestas por el servidor
- `Client`: Cliente para conexión al servidor

**Métodos clave**:
```python
# Conexión
connect(host, port)
disconnect()

# Envío de mensajes
send_message(msg_type, data)
broadcast_message(msg_type, data)

# Recepción
register_handler(msg_type, callback)
poll_messages()
```

#### ps_protocol.py
**Propósito**: Define el protocolo de comunicación punto a punto.

**Constantes**:
- `MSG_*`: Tipos de mensajes
- `PROTOCOL_VERSION`: Versión del protocolo

**Funciones**:
```python
pack_message(msg_type, data)  # Serializa mensaje
unpack_message(data)          # Deserializa mensaje
validate_message(msg)         # Valida integridad
```

### Módulos de Base de Datos

#### database.py
**Propósito**: Interfaz unificada para acceso a base de datos.

**Clases**:
- `Database`: Clase base abstracta
- `DatabaseConnection`: Conexión activa

**Métodos**:
```python
connect(config)           # Establece conexión
execute(query, params)    # Ejecuta consulta
fetchone(query, params)   # Obtiene un registro
fetchall(query, params)   # Obtiene múltiples registros
commit()                  # Confirma transacción
rollback()                # Revierte transacción
```

#### dbapsw.py / dbpostgres.py
**Propósito**: Implementaciones específicas para SQLite y PostgreSQL.

**Características SQLite**:
- Sin configuración requerida
- Base de datos embebida
- Transacciones automáticas

**Características PostgreSQL**:
- Conexiones remotas
- Usuarios y permisos
- Rendimiento para múltiples usuarios

### Módulos de Procesamiento

#### ac_logparser.py
**Propósito**: Parser para logs de Assetto Corsa.

**Funcionalidades**:
- Análisis de archivos de log
- Extracción de eventos de carrera
- Procesamiento de telemetría
- Detección de incidentes

**Clases**:
```python
class ACLogParser:
    def parse_log_file(self, filepath):
        # Procesa archivo completo

    def parse_log_line(self, line):
        # Procesa línea individual

    def extract_session_info(self, lines):
        # Extrae información de sesión
```

#### lap_collector.py
**Propósito**: Gestión de tiempos de vuelta y estadísticas.

**Funcionalidades**:
- Recolección de tiempos por vuelta
- Cálculo de mejores tiempos
- Validación de vueltas
- Estadísticas de rendimiento

**Métodos**:
```python
add_lap_time(driver, track, car, time, sector_times)
get_best_lap(driver, track, car)
get_lap_history(driver, track, limit=10)
validate_lap(lap_data)  # Verifica si la vuelta es válida
```

#### sim_info.py
**Propósito**: Información sobre la simulación de Assetto Corsa.

**Datos proporcionados**:
- Estado de la carrera
- Información de vehículos
- Condiciones ambientales
- Configuración del servidor

### Módulos de Utilidades

#### config.py
**Propósito**: Gestión de configuración del sistema.

**Funcionalidades**:
- Carga de archivos INI
- Variables de entorno
- Configuración por defecto
- Validación de valores

**Uso**:
```python
config = Config()
config.load_file('stracker.ini')
config.get('SECTION', 'option', default_value)
config.set('SECTION', 'option', value)
```

#### constants.py
**Propósito**: Constantes del sistema.

**Categorías**:
- Códigos de error
- Límites y umbrales
- Configuraciones por defecto
- Identificadores de mensajes

#### expand_ac.py
**Propósito**: Expansión de rutas específicas de Assetto Corsa.

**Funciones**:
```python
expand_ac_path(relative_path)  # Expande ruta relativa a instalación de AC
get_ac_install_path()          # Obtiene ruta de instalación
get_ac_documents_path()        # Obtiene carpeta de documentos de AC
```

### Módulos de Interfaz

#### qtbrowser.py / qtbrowser_common.py
**Propósito**: Interfaz gráfica con Qt/PySide6.

**Componentes**:
- Navegador web embebido
- Paneles de información
- Controles de usuario
- Visualización de datos

**Clases**:
```python
class QtBrowser:
    def __init__(self, parent=None):
        # Inicialización

    def load_url(self, url):
        # Carga URL

    def execute_js(self, script):
        # Ejecuta JavaScript
```

### Módulos Especializados

#### profiler.py
**Propósito**: Profiling y optimización de rendimiento.

**Funcionalidades**:
- Medición de tiempos de ejecución
- Análisis de uso de memoria
- Detección de cuellos de botella
- Generación de reportes

#### sound.py
**Propósito**: Gestión de efectos de sonido.

**Funcionalidades**:
- Reproducción de sonidos
- Gestión de volumen
- Efectos de audio
- Notificaciones sonoras

#### png.py
**Propósito**: Procesamiento de imágenes PNG.

**Funcionalidades**:
- Generación de gráficos
- Manipulación de imágenes
- Creación de thumbnails
- Optimización de tamaño

## stracker_lib/ - Biblioteca del Servidor Web

### Módulos Principales

#### http_server.py
**Propósito**: Servidor HTTP principal.

**Tecnologías**:
- CherryPy como framework base
- Bottle para routing
- Templates personalizados

**Rutas principales**:
```
/                     # Página principal
/admin/*              # Panel de administración
/live/*               # Mapa en vivo
/api/*                # API REST
/static/*             # Recursos estáticos
```

#### ac_monitor.py
**Propósito**: Monitoreo del estado de Assetto Corsa.

**Funcionalidades**:
- Verificación de procesos activos
- Estado del servidor
- Información de sesiones
- Alertas y notificaciones

#### config.py
**Propósito**: Configuración específica del servidor web.

**Opciones**:
- Puerto de escucha
- Autenticación
- Límites de usuarios
- Configuración de base de datos

### Plantillas HTTP

**Ubicación**: `stracker/http_templates/`

**Archivos principales**:
- `tmpl_base.py`: Plantilla base con layout común
- `tmpl_mainpage.py`: Página principal
- `tmpl_laptimes.py`: Tiempos de vuelta
- `tmpl_livemap.py`: Mapa en vivo
- `tmpl_admin.py`: Panel de administración

**Características**:
- Templates Python ejecutables
- Integración con Bottle
- Variables dinámicas
- Layout responsivo

## Dependencias Externas

### Requeridas
- **PySide6**: Interfaz gráfica
- **CherryPy**: Servidor web
- **Bottle**: Micro-framework web
- **APSW**: SQLite avanzado
- **psycopg2**: PostgreSQL

### Opcionales
- **lxml**: Procesamiento XML avanzado
- **Pygal**: Generación de gráficos
- **Pillow**: Procesamiento de imágenes

## Convenciones de Código

### Estilo
- PEP 8 compliant
- Docstrings en español
- Nombres descriptivos
- Comentarios explicativos

### Manejo de Errores
- Excepciones específicas por módulo
- Logging comprehensivo
- Recuperación graceful
- Mensajes de error informativos

### Testing
- Tests unitarios en `test/` (parcial)
- Cobertura básica implementada
- Tests de integración pendientes