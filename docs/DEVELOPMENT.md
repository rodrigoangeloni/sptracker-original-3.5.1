# Guía de Desarrollo

## Configuración del Entorno de Desarrollo

### Requisitos Previos

- **Python**: 3.11 o superior
- **Git**: Para control de versiones
- **PySide6**: Para interfaz gráfica
- **PostgreSQL**: Opcional, para desarrollo avanzado

### Instalación

1. **Clonar el repositorio**:
```bash
git clone https://github.com/rodrigoangeloni/sptracker-original-3.5.1.git
cd sptracker-original-3.5.1
```

2. **Crear entorno virtual**:
```bash
python -m venv .venv
source .venv/bin/activate  # Linux/Mac
# o
.venv\Scripts\activate     # Windows
```

3. **Instalar dependencias**:
```bash
pip install -r requirements.txt
pip install PySide6          # Para interfaz gráfica
pip install psycopg2-binary  # Para PostgreSQL (opcional)
```

4. **Configurar para desarrollo**:
```bash
cp stracker/stracker.ini.example stracker/stracker.ini
# Editar stracker.ini con configuración de desarrollo
```

### Estructura del Proyecto para Desarrollo

```
sptracker/
├── ptracker.py              # Cliente principal
├── ptracker-server.py       # Servidor
├── ptracker_lib/           # Biblioteca principal
├── stracker/               # Servidor web
├── docs/                   # Documentación
├── test/                   # Tests (parcial)
├── create_release.py       # Build script
└── requirements.txt        # Dependencias
```

## Flujo de Desarrollo

### 1. Crear Rama de Feature

```bash
git checkout -b feature/nueva-funcionalidad
```

### 2. Desarrollo

- Seguir convenciones de código
- Escribir tests para nuevas funcionalidades
- Actualizar documentación
- Hacer commits frecuentes

### 3. Testing

```bash
# Ejecutar tests existentes
python -m pytest test/

# Tests manuales
python ptracker-server.py --test-mode
python stracker/stracker.py --check-config
```

### 4. Pull Request

- Asegurar que todos los tests pasan
- Actualizar documentación
- Descripción clara de cambios
- Revisión de código por maintainer

## Convenciones de Código

### Estilo Python

- **PEP 8**: Seguir guía de estilo oficial
- **Longitud de línea**: Máximo 100 caracteres
- **Imports**: Ordenados alfabéticamente
- **Docstrings**: En español, formato Google

```python
def funcion_ejemplo(parametro1, parametro2):
    """
    Descripción breve de la función.

    Args:
        parametro1 (tipo): Descripción del parámetro.
        parametro2 (tipo): Descripción del parámetro.

    Returns:
        tipo: Descripción del valor retornado.

    Raises:
        ExceptionType: Cuando ocurre esta excepción.
    """
    pass
```

### Nomenclatura

- **Clases**: `NombreDeClase`
- **Funciones/Métodos**: `nombre_de_funcion`
- **Variables**: `nombre_variable`
- **Constantes**: `NOMBRE_CONSTANTE`
- **Módulos**: `nombre_modulo.py`

### Manejo de Errores

```python
try:
    # Código que puede fallar
    resultado = operacion_riesgosa()
except ValorEspecificoError as e:
    logger.error(f"Error específico: {e}")
    # Recuperación específica
except Exception as e:
    logger.error(f"Error inesperado: {e}")
    raise  # Re-lanzar si no se puede manejar
```

## Arquitectura del Código

### Principios SOLID

- **S**: Single Responsibility - Cada clase/función una responsabilidad
- **O**: Open/Closed - Abierto a extensión, cerrado a modificación
- **L**: Liskov Substitution - Subtipos sustituibles
- **I**: Interface Segregation - Interfaces específicas
- **D**: Dependency Inversion - Depender de abstracciones

### Patrón de Diseño Principal

**Cliente-Servidor con Observer Pattern**:

```python
class Servidor:
    def __init__(self):
        self.observadores = []

    def agregar_observador(self, observador):
        self.observadores.append(observador)

    def notificar_cambio(self, evento, datos):
        for obs in self.observadores:
            obs.actualizar(evento, datos)

class Cliente:
    def actualizar(self, evento, datos):
        # Procesar actualización
        pass
```

## Testing

### Framework de Testing

Usar `unittest` (incluido en Python) y `pytest` para tests avanzados.

### Estructura de Tests

```
test/
├── __init__.py
├── test_database.py
├── test_lap_collector.py
├── test_ac_logparser.py
└── test_integration.py
```

### Ejemplo de Test Unitario

```python
import unittest
from ptracker_lib.lap_collector import LapCollector

class TestLapCollector(unittest.TestCase):

    def setUp(self):
        self.collector = LapCollector()

    def test_add_lap_time(self):
        # Arrange
        driver = "Test Driver"
        track = "test_track"
        car = "test_car"
        lap_time = 125.5

        # Act
        result = self.collector.add_lap_time(driver, track, car, lap_time)

        # Assert
        self.assertTrue(result)
        self.assertEqual(self.collector.get_best_lap(driver, track, car), lap_time)

    def tearDown(self):
        # Limpiar recursos
        pass

if __name__ == '__main__':
    unittest.main()
```

### Testing de Integración

```python
def test_full_session_workflow():
    """Test completo de workflow de sesión."""
    # Configurar servidor de test
    # Simular cliente conectándose
    # Enviar datos de telemetría
    # Verificar almacenamiento en BD
    # Verificar interfaz web
    pass
```

### Cobertura de Código

```bash
pip install coverage
coverage run -m pytest
coverage report
coverage html  # Genera reporte HTML
```

## Logging y Debugging

### Configuración de Logging

```python
import logging

# Configuración básica
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('debug.log'),
        logging.StreamHandler()
    ]
)

logger = logging.getLogger(__name__)
```

### Niveles de Log

- **DEBUG**: Información detallada para debugging
- **INFO**: Información general de funcionamiento
- **WARNING**: Advertencias que no detienen ejecución
- **ERROR**: Errores que afectan funcionalidad
- **CRITICAL**: Errores críticos que requieren atención inmediata

### Logging en Producción

```python
# Rotación automática de logs
from logging.handlers import RotatingFileHandler

handler = RotatingFileHandler(
    'stracker.log',
    maxBytes=10*1024*1024,  # 10MB
    backupCount=5
)
```

## Base de Datos

### Migraciones

Para cambios en el esquema de base de datos:

1. **Crear script de migración**:
```python
def migrate_database(db):
    """Migrar base de datos a nueva versión."""
    # Verificar versión actual
    current_version = db.get_version()

    if current_version < 2:
        # Ejecutar migración v2
        db.execute("""
            ALTER TABLE sessions ADD COLUMN weather TEXT;
        """)
        db.set_version(2)
```

2. **Versionado**:
   - Mantener versiones en tabla `schema_version`
   - Scripts de migración idempotentes
   - Backup antes de migrar

### Optimización de Queries

```python
# Query optimizada con índices
def get_driver_stats_optimized(db, driver_id, limit=10):
    return db.fetchall("""
        SELECT track, car, MIN(lap_time) as best_lap,
               AVG(lap_time) as avg_lap, COUNT(*) as total_laps
        FROM laps
        WHERE driver_id = ?
        GROUP BY track, car
        ORDER BY total_laps DESC
        LIMIT ?
    """, (driver_id, limit))
```

## Interfaz Web

### Desarrollo Frontend

- **Templates**: Sistema de templates Python con Bottle
- **CSS/JS**: Bootstrap + jQuery para interactividad
- **Gráficos**: pygal para visualización de datos

### Estructura de Templates

```
stracker/http_templates/
├── tmpl_base.py          # Layout base
├── tmpl_mainpage.py      # Página principal
├── tmpl_laptimes.py      # Tiempos de vuelta
└── tmpl_admin.py         # Panel admin
```

### Desarrollo de Nuevas Páginas

1. **Crear template**:
```python
def tmpl_nueva_pagina(**kwargs):
    """Template para nueva página."""
    return """
    <div class="container">
        <h1>Nueva Página</h1>
        <div id="content">
            <!-- Contenido dinámico -->
        </div>
    </div>
    """
```

2. **Agregar ruta en servidor**:
```python
@route('/nueva-pagina')
def nueva_pagina():
    return tmpl_nueva_pagina()
```

3. **Agregar navegación**:
```python
# En tmpl_base.py agregar link
navbar_items.append({
    'url': '/nueva-pagina',
    'text': 'Nueva Página'
})
```

## Comunicación Cliente-Servidor

### Protocolo de Mensajes

```python
# Definición de mensaje
MSG_SESSION_INFO = 1
MSG_LAP_COMPLETED = 2
MSG_CAR_UPDATE = 3

# Estructura de mensaje
message = {
    'type': MSG_LAP_COMPLETED,
    'data': {
        'driver': 'John Doe',
        'lap_time': 125.456,
        'track': 'monza'
    },
    'timestamp': time.time()
}
```

### Manejo de Conexiones

```python
class ConnectionManager:
    def __init__(self):
        self.connections = {}
        self.message_queue = Queue()

    def handle_new_connection(self, client_socket):
        client_id = self.generate_client_id()
        self.connections[client_id] = {
            'socket': client_socket,
            'last_seen': time.time(),
            'authenticated': False
        }

    def broadcast_message(self, message, exclude_client=None):
        for client_id, client_info in self.connections.items():
            if client_id != exclude_client:
                try:
                    self.send_message(client_info['socket'], message)
                except:
                    # Manejar desconexión
                    self.remove_client(client_id)
```

## Profiling y Optimización

### Herramientas de Profiling

```python
import cProfile
import pstats

def profile_function(func):
    def wrapper(*args, **kwargs):
        profiler = cProfile.Profile()
        profiler.enable()
        result = func(*args, **kwargs)
        profiler.disable()

        stats = pstats.Stats(profiler)
        stats.sort_stats('cumulative')
        stats.print_stats(20)  # Top 20 funciones

        return result
    return wrapper

@profile_function
def funcion_a_optimizar():
    # Código a perfilar
    pass
```

### Optimizaciones Comunes

1. **Lazy Loading**:
```python
class LazyLoader:
    def __init__(self, loader_func):
        self.loader_func = loader_func
        self._value = None
        self._loaded = False

    @property
    def value(self):
        if not self._loaded:
            self._value = self.loader_func()
            self._loaded = True
        return self._value
```

2. **Caching**:
```python
from functools import lru_cache

@lru_cache(maxsize=128)
def expensive_computation(param):
    # Cálculo costoso
    return result
```

3. **Multiprocessing**:
```python
import multiprocessing as mp

def process_data_parallel(data_chunks):
    with mp.Pool(processes=mp.cpu_count()) as pool:
        results = pool.map(process_chunk, data_chunks)
    return results
```

## Contribución

### Proceso de Contribución

1. **Fork** del repositorio
2. **Crear rama** para feature/bugfix
3. **Desarrollar** siguiendo guías
4. **Tests** exhaustivos
5. **Pull Request** con descripción detallada
6. **Code Review** y aprobación

### Tipos de Contribuciones

- **Bug fixes**: Corrección de errores reportados
- **Features**: Nuevas funcionalidades
- **Documentation**: Mejoras en documentación
- **Tests**: Cobertura de código adicional
- **Performance**: Optimizaciones de rendimiento

### Guías de Commit

```
feat: añadir nueva funcionalidad de chat
fix: corregir cálculo de tiempos de vuelta
docs: actualizar guía de configuración
test: añadir tests para validador de vueltas
perf: optimizar queries de estadísticas
refactor: reestructurar módulo de comunicación
```

## Debugging Avanzado

### Herramientas de Debug

- **pdb**: Debugger estándar de Python
- **ipdb**: Mejor interfaz para pdb
- **PyCharm/VSCode**: Debuggers gráficos
- **strace/ltrace**: Tracing de system calls

### Debug Remoto

```python
# En código a debuggear
import pydevd_pycharm
pydevd_pycharm.settrace('localhost', port=12345, stdoutToServer=True, stderrToServer=True)
```

### Logging Avanzado

```python
# Logging estructurado
import structlog

structlog.configure(
    processors=[
        structlog.stdlib.filter_by_level,
        structlog.stdlib.add_logger_name,
        structlog.stdlib.add_log_level,
        structlog.stdlib.PositionalArgumentsFormatter(),
        structlog.processors.TimeStamper(fmt="iso"),
        structlog.processors.StackInfoRenderer(),
        structlog.processors.format_exc_info,
        structlog.processors.UnicodeDecoder(),
        structlog.processors.JSONRenderer()
    ],
    context_class=dict,
    logger_factory=structlog.stdlib.LoggerFactory(),
    wrapper_class=structlog.stdlib.BoundLogger,
    cache_logger_on_first_use=True,
)

logger = structlog.get_logger()
logger.info("Operación completada", user_id=123, operation="login")
```

## Despliegue

### Build de Release

```bash
# Crear release de desarrollo
python create_release.py --test_release_process 3.5.1-dev

# Crear release final
python create_release.py --release 3.5.1
```

### Docker (Futuro)

```dockerfile
FROM python:3.11-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
EXPOSE 8080

CMD ["python", "stracker/stracker.py"]
```

### CI/CD

Configuración futura con GitHub Actions:

```yaml
name: CI/CD

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: 3.11
    - name: Install dependencies
      run: pip install -r requirements.txt
    - name: Run tests
      run: python -m pytest test/
```

## Soporte y Comunidad

### Canales de Comunicación

- **Issues**: Para bugs y feature requests
- **Discussions**: Para preguntas generales
- **Wiki**: Documentación comunitaria
- **Discord**: Chat en tiempo real

### Versionado

- **SemVer**: Major.Minor.Patch
- **Major**: Cambios incompatibles
- **Minor**: Nuevas funcionalidades
- **Patch**: Bug fixes

### Roadmap

- [ ] Tests completos
- [ ] Docker support
- [ ] API REST completa
- [ ] Multiplataforma mejorada
- [ ] Plugins system
- [ ] Clustering support