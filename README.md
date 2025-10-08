# SPTracker

<div align="center">

![SPTracker Logo](images/brand_icon_large_wob.png)

**SPTracker** es una solución avanzada para la gestión y análisis de carreras en Assetto Corsa. Incluye un plugin cliente, servidor de telemetría, interfaz web y soporte para base de datos, permitiendo monitoreo en tiempo real, estadísticas y administración centralizada.

[![Estado del Build](https://img.shields.io/github/actions/workflow/status/rodrigoangeloni/sptracker-original-3.5.1/ci.yml?branch=main&style=for-the-badge&logo=github)](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/actions)
[![Versión](https://img.shields.io/badge/versión-3.5.3--dev-blue?style=for-the-badge&logo=git)](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/branches)
[![Python](https://img.shields.io/badge/Python-3.11+-3776AB?style=for-the-badge&logo=python)](https://www.python.org/)
[![Qt](https://img.shields.io/badge/Qt-6.0+-41CD52?style=for-the-badge&logo=qt)](https://pyside.org/)
[![CherryPy](https://img.shields.io/badge/CherryPy-18.0+-FF6B35?style=for-the-badge)](https://cherrypy.org/)
[![SQLite](https://img.shields.io/badge/SQLite-3.x-003B57?style=for-the-badge&logo=sqlite)](https://www.sqlite.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-13+-336791?style=for-the-badge&logo=postgresql)](https://www.postgresql.org/)
[![Licencia](https://img.shields.io/github/license/rodrigoangeloni/sptracker-original-3.5.1?style=for-the-badge)](LICENSE.txt)

[![Ramas](https://img.shields.io/badge/Ramas-main_py--upgrade→3.5.3-FF6B6B?style=for-the-badge&logo=git)](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/branches)
[![Commits](https://img.shields.io/github/commit-activity/m/rodrigoangeloni/sptracker-original-3.5.1?style=for-the-badge)](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/commits)
[![Último Commit](https://img.shields.io/github/last-commit/rodrigoangeloni/sptracker-original-3.5.1?style=for-the-badge)](https://github.com/rodrigoangeloni/sptracker-original-3.5.1)

[📖 Documentación](docs/) • [🚀 Inicio Rápido](#inicio-rápido) • [📋 Issues](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/issues) • [💬 Discusiones](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/discussions)

</div>

---

## ✨ Características principales

<div align="center">

| 🚗 **Cliente Assetto Corsa** | 🖥️ **Servidor Telemetría** | 🌐 **Interfaz Web** | 🗄️ **Base de Datos** |
|:----------------------------:|:--------------------------:|:-------------------:|:--------------------:|
| Plugin integrado en AC      | Procesamiento en tiempo real | Panel administrativo | SQLite/PostgreSQL   |
| Interfaz Qt moderna         | Comunicación TCP/IP       | Mapas en vivo       | Estadísticas completas |
| Telemetría detallada        | Gestión de sesiones       | API REST            | Backup automático    |

</div>

### 🎯 Funcionalidades destacadas

- **📊 Telemetría en tiempo real**: Seguimiento preciso de posiciones, velocidades y tiempos
- **🏁 Gestión de carreras**: Sesiones, clasificaciones y estadísticas automáticas
- **🗺️ Mapas interactivos**: Visualización en vivo de posiciones en circuito
- **👥 Multi-jugador**: Soporte completo para servidores dedicados
- **🔧 Configuración flexible**: Más de 50 opciones de personalización
- **📱 API REST**: Integración con sistemas externos
- **🔒 Seguridad**: Autenticación, permisos y validación de datos
- **📈 Rendimiento**: Optimizado para alta concurrencia

---

## 🚀 Inicio rápido

### 📦 Instalación

#### Opción 1: Instalador automático (Recomendado)
```bash
# Descargar desde releases
# Ejecutar ptracker-V3.5.1.exe
# Seguir el asistente de instalación
```

#### Opción 2: Instalación manual
```bash
# Clonar repositorio
git clone https://github.com/rodrigoangeloni/sptracker-original-3.5.1.git
cd sptracker-original-3.5.1

# Instalar dependencias
pip install -r requirements.txt
pip install PySide6 psycopg2-binary

# Configurar
cp stracker/stracker.ini.example stracker/stracker.ini
```

### ⚙️ Configuración básica

1. **Assetto Corsa**:
   ```bash
   # Copiar plugin
   cp -r ptracker/ "C:/Program Files/Assetto Corsa/apps/python/"
   ```

2. **Servidor**:
   ```ini
   # stracker/stracker.ini
   [STRACKER_CONFIG]
   listening_port = 50000

   [HTTP_CONFIG]
   listen_port = 8080
   admin_username = admin
   admin_password = tu_password_seguro
   ```

3. **Base de datos** (opcional):
   ```ini
   [DATABASE]
   database_type = postgres
   postgres_host = localhost
   postgres_user = sptracker
   postgres_db = sptracker_db
   ```

### 🎮 Primer uso

```bash
# Iniciar servidor
python stracker/stracker.py

# Acceder a la interfaz web
# http://localhost:8080
# Usuario: admin / Contraseña: [tu_password]
```

---

## 📚 Documentación

<div align="center">

### 📖 Guías principales

| Documento | Descripción | Dificultad |
|:----------|:------------|:----------:|
| [**🏗️ Arquitectura**](docs/ARCHITECTURE.md) | Componentes y flujo de datos | Intermedio |
| [**⚙️ Configuración**](docs/CONFIGURATION.md) | Todas las opciones disponibles | Todos |
| [**📚 Módulos**](docs/MODULES.md) | Referencia de APIs y bibliotecas | Avanzado |
| [**🔌 API REST**](docs/API.md) | Integración programática | Avanzado |
| [**💻 Desarrollo**](docs/DEVELOPMENT.md) | Contribuir al proyecto | Avanzado |
| [**🔧 Troubleshooting**](docs/TROUBLESHOOTING.md) | Solución de problemas | Todos |

### 📋 Documentos adicionales

- [**📄 README.txt**](README.txt) - Información histórica
- [**📝 TODO.txt**](TODO.txt) - Roadmap y tareas pendientes
- [**⚖️ LICENSE.txt**](LICENSE.txt) - Términos de uso

</div>

---

## 🏗️ Arquitectura del sistema

```mermaid
graph TB
    A[Assetto Corsa] --> B[ptracker.py<br/>Cliente Qt]
    B --> C[ptracker-server.py<br/>Servidor Backend]
    C --> D[(Base de Datos<br/>SQLite/PostgreSQL)]
    C --> E[stracker/<br/>Servidor Web]
    E --> F[🌐 Interfaz Web<br/>Bootstrap + jQuery]
    E --> G[📡 API REST<br/>JSON]

    style A fill:#e1f5fe
    style B fill:#f3e5f5
    style C fill:#e8f5e8
    style D fill:#fff3e0
    style E fill:#fce4ec
    style F fill:#f1f8e9
    style G fill:#e0f2f1
```

### 🧩 Componentes principales

- **🚗 Cliente**: Plugin Qt para Assetto Corsa
- **🖥️ Servidor**: Procesamiento de telemetría y datos
- **🌐 Web**: Interfaz de administración y visualización
- **🗄️ Base de datos**: Almacenamiento persistente
- **📡 API**: Integración con sistemas externos

---

## 🛠️ Tecnologías utilizadas

<div align="center">

### Backend & Core
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)
![Qt](https://img.shields.io/badge/Qt-41CD52?style=flat-square&logo=qt&logoColor=white)
![CherryPy](https://img.shields.io/badge/CherryPy-FF6B35?style=flat-square&logo=cherrypy&logoColor=white)
![Bottle](https://img.shields.io/badge/Bottle-003B57?style=flat-square&logo=bottle&logoColor=white)

### Base de datos
![SQLite](https://img.shields.io/badge/SQLite-003B57?style=flat-square&logo=sqlite&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=flat-square&logo=postgresql&logoColor=white)
![APSW](https://img.shields.io/badge/APSW-3776AB?style=flat-square&logo=python&logoColor=white)

### Frontend & UI
![Bootstrap](https://img.shields.io/badge/Bootstrap-7952B3?style=flat-square&logo=bootstrap&logoColor=white)
![jQuery](https://img.shields.io/badge/jQuery-0769AD?style=flat-square&logo=jquery&logoColor=white)
![Pygal](https://img.shields.io/badge/Pygal-3776AB?style=flat-square&logo=python&logoColor=white)

### Desarrollo & Build
![PyInstaller](https://img.shields.io/badge/PyInstaller-3776AB?style=flat-square&logo=python&logoColor=white)
![NSIS](https://img.shields.io/badge/NSIS-003B57?style=flat-square&logo=nsis&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white)

</div>

---

## 📊 Estructura del proyecto

```
sptracker-original-3.5.1/
├── 📁 ptracker/                 # 🏁 Cliente Assetto Corsa
│   ├── ptracker.py              # 🚗 Plugin principal
│   └── 📁 data/                 # 📊 Datos del plugin
├── 📁 ptracker_lib/             # 🧰 Biblioteca central (30+ módulos)
│   ├── client_server/          # 🔌 Protocolo comunicación
│   ├── database.py              # 🗄️ Abstracción BD
│   ├── ac_logparser.py          # 📝 Parser logs AC
│   ├── lap_collector.py         # ⏱️ Gestión tiempos
│   └── ...
├── 📁 stracker/                 # 🌐 Servidor web
│   ├── stracker.py              # 🖥️ Servidor principal
│   ├── 📁 stracker_lib/         # 🛠️ Utilidades web
│   ├── 📁 http_templates/       # 📄 Templates HTML
│   └── 📁 http_static/          # 🎨 Recursos web
├── 📁 docs/                     # 📚 Documentación completa
│   ├── ARCHITECTURE.md          # 🏗️ Arquitectura
│   ├── CONFIGURATION.md         # ⚙️ Configuración
│   ├── API.md                   # 🔌 API REST
│   └── ...
├── 📁 images/                   # 🖼️ Recursos gráficos
├── 📁 sounds/                   # 🔊 Efectos de audio
├── 📁 versions/                 # 📦 Releases generados
├── 📄 requirements.txt          # 📋 Dependencias
├── 🛠️ create_release.py         # 📦 Script de build
├── 📄 ptracker.nsh.in           # 📦 Template NSIS
├── 📄 README.md                 # 📖 Este archivo
└── 📄 LICENSE.txt               # ⚖️ Licencia
```

---

## 🤝 Contribuir

<div align="center">

¡Las contribuciones son bienvenidas! 👋

[![Contribuciones](https://img.shields.io/badge/Contribuciones-Bienvenidas-FF6B6B?style=for-the-badge&logo=github-sponsors)](docs/DEVELOPMENT.md)
[![Guía de Desarrollo](https://img.shields.io/badge/📖_Guía-Desarrollo-3776AB?style=for-the-badge)](docs/DEVELOPMENT.md)

</div>

### 🚀 Flujo de contribución

```mermaid
graph LR
    A[Fork] --> B[Crear rama<br/>feature/nueva-funcionalidad]
    B --> C[Desarrollar<br/>y testear]
    C --> D[Commit<br/>con mensaje claro]
    D --> E[Push<br/>a tu fork]
    E --> F[Crear<br/>Pull Request]
    F --> G[Code Review<br/>y merge]
```

### 🎯 Tipos de contribución

| Tipo | Descripción | Ejemplo |
|:-----|:------------|:--------|
| 🐛 **Bug fixes** | Corrección de errores | Fix crash on startup |
| ✨ **Features** | Nuevas funcionalidades | Add weather data export |
| 📚 **Documentation** | Mejoras en docs | Update API examples |
| 🧪 **Tests** | Cobertura adicional | Add unit tests for lap_collector |
| ⚡ **Performance** | Optimizaciones | Improve database queries |
| 🔄 **Refactoring** | Mejora de código | Clean up configuration parsing |

### 📝 Convenciones de commit

```
feat: añadir nueva funcionalidad de chat
fix: corregir cálculo de tiempos de vuelta
docs: actualizar guía de configuración
test: añadir tests para validador de vueltas
perf: optimizar queries de estadísticas
refactor: reestructurar módulo de comunicación
```

---

## 🆘 Soporte

<div align="center">

### 📞 Canales de soporte

| Canal | Uso | Enlace |
|:------|:----|:-------|
| 📋 **Issues** | Bugs y features | [GitHub Issues](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/issues) |
| 💬 **Discussions** | Preguntas generales | [GitHub Discussions](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/discussions) |
| 📖 **Wiki** | Guías comunitarias | [GitHub Wiki](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/wiki) |
| 🐛 **Debugging** | Troubleshooting | [Guía de resolución](docs/TROUBLESHOOTING.md) |

</div>

### 🐛 Reportar problemas

Para reportes efectivos incluir:

```markdown
**Versión**: 3.5.1
**SO**: Windows 10 Pro 22H2
**Python**: 3.11.8
**Descripción**: [Descripción clara del problema]
**Pasos para reproducir**:
1. [Paso 1]
2. [Paso 2]
3. [Resultado esperado vs actual]
**Logs**: [Adjuntar logs relevantes]
**Configuración**: [Secciones relevantes de stracker.ini]
```

---

## 📈 Estado del proyecto

<div align="center">

### ✅ Funcionalidades completas

| Categoría | Estado | Detalles |
|:----------|:-------|:---------|
| **Cliente Assetto Corsa** | ✅ Completo | Plugin Qt con telemetría completa |
| **Servidor Backend** | ✅ Completo | Procesamiento en tiempo real |
| **Interfaz Web** | ✅ Completo | Panel admin + mapas en vivo |
| **Base de Datos** | ✅ Completo | SQLite + PostgreSQL |
| **Instalador** | ✅ Completo | NSIS automatizado |
| **API REST** | ✅ Completo | Integración externa |

### 🚧 En desarrollo

| Feature | Estado | Prioridad |
|:--------|:-------|:----------|
| Tests automatizados | 🔄 En progreso | Alta |
| Docker support | 📋 Planificado | Media |
| Clustering | 📋 Planificado | Media |
| Sistema de plugins | 📋 Planificado | Baja |

### 📊 Métricas del proyecto

[![Líneas de código](https://img.shields.io/badge/Líneas%20de%20código-50K+-blue?style=flat-square)](https://github.com/rodrigoangeloni/sptracker-original-3.5.1)
[![Archivos](https://img.shields.io/badge/Archivos-200+-green?style=flat-square)](https://github.com/rodrigoangeloni/sptracker-original-3.5.1)
[![Módulos](https://img.shields.io/badge/Módulos-30+-orange?style=flat-square)](ptracker_lib/)

</div>

---

## 👥 Créditos y licencia

<div align="center">

**Desarrollado por [Rodrigo Angeloni](https://github.com/rodrigoangeloni)**

### 🙏 Agradecimientos

- **🎮 Comunidad Assetto Corsa** - Por el feedback y testing continuo
- **🏎️ Kunos Simulazioni** - Por crear Assetto Corsa
- **🐍 Comunidad Python** - Por las excelentes librerías
- **🔧 Contribuidores** - Por mejoras y correcciones

### 📄 Licencia

Este proyecto está bajo la **Licencia MIT**.
Ver [`LICENSE.txt`](LICENSE.txt) para detalles completos.

[![Licencia MIT](https://img.shields.io/badge/Licencia-MIT-yellow.svg?style=for-the-badge)](LICENSE.txt)

</div>

---

## 📋 Roadmap

Ver [`TODO.txt`](TODO.txt) para el roadmap completo y tareas pendientes.

### 🎯 Próximas versiones

- **v3.5.3**: Mejoras de rendimiento y estabilidad (actual)
- **v3.6.0**: Sistema de plugins extensible
- **v4.0.0**: Arquitectura completamente modular

---

<div align="center">

**⭐ Si te gusta SPTracker, ¡dale una estrella en GitHub!**

[📖 **Documentación completa**](docs/) • [🚀 **Descargar última versión**](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/releases) • [🐛 **Reportar issue**](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/issues)

---

*SPTracker - Gestión profesional de carreras para Assetto Corsa*

</div>


