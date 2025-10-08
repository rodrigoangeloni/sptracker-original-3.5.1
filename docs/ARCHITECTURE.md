# Arquitectura de SPTracker

## Visión General

SPTracker es una aplicación modular para Assetto Corsa que consta de múltiples componentes que se comunican entre sí para proporcionar una experiencia completa de gestión de carreras.

## Componentes Principales

### 1. Cliente (ptracker.py)

**Ubicación**: `ptracker.py`  
**Propósito**: Plugin principal que se ejecuta dentro de Assetto Corsa

**Funcionalidades**:
- Interfaz gráfica con PySide6/Qt
- Comunicación con servidor via protocolo personalizado
- Procesamiento de telemetría en tiempo real
- Gestión de sesiones de carrera
- Interfaz de usuario para configuración

**Dependencias**:
- PySide6 (Qt6)
- acsys (API de Assetto Corsa)
- ptracker_lib (biblioteca interna)

### 2. Servidor (ptracker-server.py)

**Ubicación**: `ptracker-server.py`  
**Propósito**: Procesamiento backend y almacenamiento de datos

**Funcionalidades**:
- Comunicación bidireccional con clientes
- Procesamiento de logs de Assetto Corsa
- Almacenamiento en base de datos
- Gestión de sesiones múltiples
- Servidor HTTP integrado (opcional)

**Modos de operación**:
- **Cliente-Servidor**: Comunicación con ptracker.py
- **Standalone**: Procesamiento independiente
- **Servidor web**: Interfaz HTTP adicional

### 3. Servidor Web (stracker/)

**Ubicación**: `stracker/`  
**Propósito**: Interfaz web para administración y visualización

**Componentes**:
- `stracker.py`: Servidor principal con CherryPy
- `stracker_lib/`: Biblioteca específica del servidor web
- `http_templates/`: Plantillas HTML con Bottle
- `http_static/`: Recursos estáticos (CSS, JS, imágenes)

**Funcionalidades**:
- Panel de administración
- Mapa en vivo de posiciones
- Estadísticas de carreras
- Gestión de usuarios y permisos
- API REST para integración

### 4. Biblioteca Central (ptracker_lib/)

**Ubicación**: `ptracker_lib/`  
**Propósito**: Utilidades compartidas y lógica de negocio

**Módulos principales**:

#### Comunicación
- `client_server/`: Protocolo cliente-servidor
- `ps_protocol.py`: Protocolo de comunicación
- `message_types.py`: Definiciones de mensajes

#### Datos y Base de Datos
- `database.py`: Interfaz de base de datos
- `dbapsw.py`: SQLite con APSW
- `dbpostgres.py`: PostgreSQL
- `dbgeneric.py`: Interfaz genérica

#### Procesamiento
- `ac_logparser.py`: Parser de logs de AC
- `lap_collector.py`: Recolección de tiempos de vuelta
- `sim_info.py`: Información de simulación

#### Utilidades
- `config.py`: Gestión de configuración
- `constants.py`: Constantes del sistema
- `expand_ac.py`: Expansión de rutas de AC

## Flujo de Datos

```
Assetto Corsa → ptracker.py → ptracker-server.py → Base de Datos
       ↓              ↓              ↓
   Telemetría    Procesamiento   Almacenamiento
       ↓              ↓              ↓
   Interfaz UI   Comunicación    Persistencia
       ↓              ↓              ↓
   Usuario    ← stracker/ ← Consultas HTTP
```

## Arquitectura de Comunicación

### Protocolo Cliente-Servidor

**Tecnología**: Sockets TCP/IP con protocolo personalizado  
**Puerto**: Configurable (default: 50000)  
**Mensajes**: Serializados con pickle/struct

**Tipos de mensajes**:
- `MSG_SESSION_INFO`: Información de sesión
- `MSG_LAP_COMPLETED`: Vuelta completada
- `MSG_CAR_UPDATE`: Actualización de posición
- `MSG_CHAT_MESSAGE`: Mensajes de chat

### Memoria Compartida (SHM)

**Ubicación**: `stracker_lib/stracker_shm.py`  
**Propósito**: Comunicación eficiente entre procesos  
**Uso**: Transferencia de datos de telemetría

### Base de Datos

**Motores soportados**:
- SQLite (default, sin configuración)
- PostgreSQL (para despliegues grandes)

**Esquemas principales**:
- `sessions`: Sesiones de carrera
- `laps`: Tiempos de vuelta
- `cars`: Información de vehículos
- `tracks`: Circuitos
- `users`: Usuarios del sistema

## Configuración

### Archivo de configuración principal

**Ubicación**: `stracker/stracker.ini` (generado automáticamente)  
**Formato**: INI con secciones

**Secciones principales**:
- `[STRACKER_CONFIG]`: Configuración general
- `[DATABASE]`: Configuración de BD
- `[HTTP_CONFIG]`: Servidor web
- `[SESSION_MANAGEMENT]`: Gestión de sesiones

### Variables de entorno

- `STRACKER_CONFIG`: Ruta al archivo de configuración
- `PYTHONPATH`: Incluir directorios del proyecto

## Seguridad

### Autenticación
- Sistema de usuarios con contraseñas hasheadas
- Sesiones HTTP con cookies seguras
- Control de acceso basado en roles

### Validación
- Checksums de archivos para integridad
- Validación de datos de entrada
- Filtros de chat y swear words

## Despliegue

### Modos de operación

1. **Desarrollo**:
   - Ejecutar componentes individualmente
   - Logs detallados activados
   - Base de datos local

2. **Producción**:
   - Ejecutables empaquetados con PyInstaller
   - Instalador NSIS
   - Configuración optimizada

### Requisitos del sistema

- **Python**: 3.11+
- **PySide6**: Para interfaz gráfica
- **PostgreSQL**: Opcional para BD
- **CherryPy/Bottle**: Para servidor web

## Extensibilidad

### Plugins y extensiones
- Arquitectura modular permite agregar funcionalidades
- API documentada para integración
- Sistema de hooks para personalización

### Desarrollo
- Código bien estructurado con separación de responsabilidades
- Documentación inline y externa
- Tests automatizados (parcialmente implementados)