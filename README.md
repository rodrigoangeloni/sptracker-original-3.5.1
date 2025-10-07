# 🏎️ SPTracker - Assetto Corsa Stats Tracker

[![Python](https://img.shields.io/badge/Python-3.11.8-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![PyInstaller](https://img.shields.io/badge/PyInstaller-5.13.2%20%7C%206.16.0-4B8BBE?style=for-the-badge&logo=python&logoColor=white)](https://pyinstaller.org/)
[![Qt](https://img.shields.io/badge/PySide-Qt4-41CD52?style=for-the-badge&logo=qt&logoColor=white)](https://wiki.qt.io/Qt_for_Python)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Supported-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![SQLite](https://img.shields.io/badge/SQLite-Default-003B57?style=for-the-badge&logo=sqlite&logoColor=white)](https://www.sqlite.org/)
[![License](https://img.shields.io/badge/License-GPL--3.0-blue?style=for-the-badge)](LICENSE.txt)

> **Sistema de tracking y estadísticas para Assetto Corsa con soporte multiplataforma**

Modernizado y actualizado por **Rodrigo Angeloni** - 2025

---

## 📋 Tabla de Contenidos

- [🎯 Características](#-características)
- [🏗️ Arquitectura](#️-arquitectura)
- [⚙️ Requisitos del Sistema](#️-requisitos-del-sistema)
- [🚀 Instalación y Configuración](#-instalación-y-configuración)
  - [Windows](#windows)
  - [Linux (WSL/Debian)](#linux-wslddebian)
- [🔨 Compilación desde Código Fuente](#-compilación-desde-código-fuente)
- [📦 Dependencias](#-dependencias)
- [🐛 Problemas Conocidos y Soluciones](#-problemas-conocidos-y-soluciones)
- [🔧 Configuración Avanzada](#-configuración-avanzada)
- [📝 Notas de Modernización](#-notas-de-modernización)
- [📄 Licencia](#-licencia)

---

## 🎯 Características

### PTracker (Cliente)
- 📊 **Tracking en tiempo real** de vueltas y tiempos
- 🎮 **Integración nativa** con Assetto Corsa
- 📡 **Comunicación** con servidor STracker
- 🖥️ **Interfaz gráfica** con PySide (Qt4)

### STracker (Servidor)
- 📈 **Estadísticas completas** de sesiones y carreras
- 🌐 **Portal web integrado** con Bottle + CherryPy
- 💾 **Base de datos** SQLite o PostgreSQL
- 🔌 **Plugin UDP** para servidor AC
- 📊 **Gráficos interactivos** con Pygal
- 🏆 **Sistema de campeonatos** y rankings

---

## 🏗️ Arquitectura

```
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────┐
│                 │     │                  │     │                 │
│  Assetto Corsa  │────▶│    PTracker      │────▶│  PTracker       │
│   (Juego)       │     │   (Cliente)      │     │   Server        │
│                 │     │                  │     │                 │
└─────────────────┘     └──────────────────┘     └────────┬────────┘
                                                           │
                                                           ▼
                        ┌──────────────────────────────────────────┐
                        │         STracker (Servidor)              │
                        │  ┌────────────┐  ┌──────────────────┐   │
                        │  │   HTTP     │  │    UDP Plugin    │   │
                        │  │   Portal   │  │  (AC Server)     │   │
                        │  └────────────┘  └──────────────────┘   │
                        │           │               │              │
                        │           ▼               ▼              │
                        │      ┌─────────────────────────┐        │
                        │      │  SQLite / PostgreSQL    │        │
                        │      └─────────────────────────┘        │
                        └──────────────────────────────────────────┘
```

---

## ⚙️ Requisitos del Sistema

### 🪟 Windows (Desarrollo/Compilación)

| Componente | Versión | Notas |
|------------|---------|-------|
| ![Python](https://img.shields.io/badge/Python-3.11.8-3776AB?logo=python&logoColor=white) | **3.11.8** | ⚠️ **Versión específica requerida** |
| ![PyInstaller](https://img.shields.io/badge/PyInstaller-5.13.2-4B8BBE?logo=python&logoColor=white) | 5.13.2 | Para builds Windows |
| ![NSIS](https://img.shields.io/badge/NSIS-3.x-0078D7?logo=windows&logoColor=white) | 3.x | Para crear instaladores |
| ![PuTTY](https://img.shields.io/badge/PuTTY-Latest-000000?logo=putty&logoColor=white) | Última | `plink.exe` y `pscp.exe` para builds remotos |
| ![Git](https://img.shields.io/badge/Git-Latest-F05032?logo=git&logoColor=white) | Última | Control de versiones |

### 🐧 Linux (WSL/Debian/RPi)

| Componente | Versión | Notas |
|------------|---------|-------|
| ![Python](https://img.shields.io/badge/Python-3.13.5-3776AB?logo=python&logoColor=white) | 3.13.5+ | Debian Testing / WSL |
| ![PyInstaller](https://img.shields.io/badge/PyInstaller-6.16.0-4B8BBE?logo=python&logoColor=white) | 6.16.0 | Para builds Linux |
| ![dos2unix](https://img.shields.io/badge/dos2unix-Latest-FCC624?logo=linux&logoColor=black) | Última | ⚠️ **Crítico para WSL** |

---

## 🚀 Instalación y Configuración

### Windows

#### 1️⃣ Clonar el Repositorio

```powershell
git clone https://github.com/rodrigoangeloni/sptracker-original-3.5.1.git
cd sptracker-original-3.5.1
```

#### 2️⃣ Configurar Entorno Virtual

```powershell
# Crear entorno virtual con Python 3.11.8
python -m venv .venv

# Activar entorno virtual
.\.venv\Scripts\Activate.ps1

# Verificar versión de Python
python --version  # Debe mostrar Python 3.11.8
```

#### 3️⃣ Instalar Dependencias

```powershell
# Actualizar pip
python -m pip install --upgrade pip

# Instalar dependencias
pip install -r requirements.txt
```

#### 4️⃣ Configurar Build Remoto (Opcional)

Si deseas compilar para Linux desde Windows vía WSL o Raspberry Pi:

```powershell
# Copiar plantilla de configuración
copy remote_settings.py.in remote_settings.py

# Editar remote_settings.py con tus datos
notepad remote_settings.py
```

**Ejemplo de `remote_settings.py`:**

```python
plink = r"C:\Program Files\PuTTY\plink.exe"
git = r"C:\Program Files\Git\cmd\git.exe"

# Para WSL Local
remote_path = "/mnt/c/Users/TuUsuario/source/repos/sptracker-original-3.5.1"
host = "usuario@172.22.51.140"  # IP de tu WSL

# Para Raspberry Pi
# remote_path = "/home/pi/sptracker"
# host = "pi@192.168.1.100"

REMOTE_BUILD_CMD = [plink, "-pw", "tu_password", host, 
                    "cd " + remote_path + " && sh create_release.sh"]

REMOTE_COPY_RESULT = [
    r"C:\Program Files\PuTTY\pscp.exe",
    "-pw", "tu_password",
    f"{host}:{remote_path}/stracker/stracker_linux_x86.tgz",
    "stracker/stracker_linux_x86.tgz"
]
```

---

### Linux (WSL/Debian)

#### 1️⃣ Instalar Dependencias del Sistema

```bash
sudo apt update
sudo apt install -y \
    python3.13 \
    python3.13-venv \
    python3-pip \
    dos2unix \
    build-essential \
    libpq-dev \
    libssl-dev
```

#### 2️⃣ Instalar PyInstaller

```bash
pip3 install --user pyinstaller
```

#### 3️⃣ Convertir Scripts a Formato Unix

⚠️ **CRÍTICO para WSL**: Los scripts bash deben tener line endings LF (Unix), no CRLF (Windows)

```bash
cd /mnt/c/Users/TuUsuario/source/repos/sptracker-original-3.5.1
dos2unix create_release.sh
chmod +x create_release.sh
```

---

## 🔨 Compilación desde Código Fuente

### 🎯 Compilación Completa (Windows + Linux)

```powershell
# Modo test (no crea release en GitHub)
python create_release.py --test_release_process 3.5.2

# Modo producción (crea release)
python create_release.py 3.5.2
```

**Resultado esperado:**
- ✅ `versions/ptracker-V3.5.2.exe` (~19 MB) - Instalador Windows
- ✅ `versions/stracker-V3.5.2.zip` - Binarios Windows + Linux
  - `stracker.exe` - Servidor Windows
  - `stracker-packager.exe` - Empaquetador Windows
  - `stracker_linux_x86.tgz` - Binario Linux (16 MB)

### 🪟 Solo Windows

```powershell
python create_release.py --test_release_process --windows_only 3.5.2
```

### 🐧 Solo Linux

```powershell
python create_release.py --test_release_process --linux_only 3.5.2
```

### 🎮 Solo PTracker

```powershell
python create_release.py --test_release_process --ptracker_only 3.5.2
```

### 🖥️ Solo STracker

```powershell
python create_release.py --test_release_process --stracker_only 3.5.2
```

---

## 📦 Dependencias

### Core Dependencies

```ini
# PyInstaller
pyinstaller==5.13.2  # Windows builds
pyinstaller==6.16.0  # Linux builds (WSL/RPi)

# GUI (PySide - Qt4)
PySide==1.2.4  # ⚠️ Versión antigua, requiere Python 3.11.8

# Web Framework
bottle==0.12.25
CherryPy==18.8.0

# Database
psycopg2-binary==2.9.9  # PostgreSQL support
apsw==3.45.1.0         # SQLite wrapper

# Data Processing
simplejson==3.19.2
python-dateutil==2.8.2
pytz==2024.1

# Graphics/Charts
pygal==3.0.4
lxml==5.1.0
cairosvg==2.7.1

# System
pywin32==306  # Windows only
```

### Dependencias Completas

Ver `requirements.txt` y `DEPENDENCIES.txt` para la lista completa.

---

## 🐛 Problemas Conocidos y Soluciones

### ❌ Error: `$'\r': command not found` en WSL

**Causa:** Scripts bash con line endings CRLF (Windows)

**Solución:**
```bash
dos2unix create_release.sh
```

### ❌ Error: `pscp: permission denied` copiando `.tgz`

**Causa:** Problema de sincronización de permisos en WSL filesystem montado

**Solución:** Ya implementada en `create_release.sh`:
```bash
chmod 644 stracker_linux_x86.tgz
sleep 1  # Esperar sincronización
```

### ❌ Error: `Hidden import 'cherrypy.wsgiserver.wsgiserver3' not found`

**Causa:** CherryPy cambió la estructura de módulos en versiones nuevas

**Solución:** ⚠️ Advertencia esperada, no afecta la compilación

### ❌ Warning: `lib not found: python33.dll`

**Causa:** Referencia obsoleta en `ptracker_lib/_imagingft.pyd`

**Solución:** ⚠️ Advertencia esperada, el módulo no se usa en la versión actual

### ❌ PyInstaller genera archivo `.tgz` con 0 bytes

**Causa:** El comando `tar` falla o se ejecuta antes de que PyInstaller termine

**Solución verificada:**
```bash
# En create_release.sh
mv dist/stracker dist/stracker_linux_x86
tar cvzf stracker_linux_x86.tgz -C dist stracker_linux_x86
# Verificar que dist/stracker_linux_x86 existe antes del tar
```

### ❌ Python 3.12+ no es compatible

**Causa:** PySide 1.2.4 (Qt4) no compila en Python 3.12+

**Solución:** ⚠️ **Usar Python 3.11.8 exactamente**

---

## 🔧 Configuración Avanzada

### Configuración de STracker

Editar `stracker/stracker-default.ini`:

```ini
[STRACKER_CONFIG]
ac_server_cfg_ini = /path/to/server_cfg.ini
listening_port = 50041
server_name = Mi Servidor AC

[DATABASE]
database_type = sqlite  # o 'postgres'
database_file = stracker.db3

[HTTP_CONFIG]
enabled = true
listen_port = 50042
admin_username = admin
admin_password = tu_password_seguro
```

### Configuración de PostgreSQL (Opcional)

```ini
[DATABASE]
database_type = postgres
postgres_host = localhost
postgres_db = stracker
postgres_user = stracker_user
postgres_pwd = tu_password
```

### SSH para Builds Remotos

**Generar clave SSH (opcional, más seguro que password):**

```powershell
# Windows
ssh-keygen -t rsa -b 4096 -C "tu_email@example.com"
type $env:USERPROFILE\.ssh\id_rsa.pub | ssh usuario@host "cat >> ~/.ssh/authorized_keys"
```

---

## 📝 Notas de Modernización

### 🔄 Cambios Principales (2025)

1. **Python actualizado** de 3.3 a 3.11.8
2. **PyInstaller** actualizado de 2.x a 5.13.2 (Windows) / 6.16.0 (Linux)
3. **Dependencias** actualizadas a versiones compatibles
4. **Formato de línea** corregido para scripts bash (CRLF → LF)
5. **Permisos WSL** arreglados con `chmod` + `sleep`
6. **Documentación** completa y profesional

### ⚠️ Limitaciones Actuales

- **PySide (Qt4)** es obsoleto, migración a PySide2/PyQt5 pendiente
- **Bottle/CherryPy** versiones antiguas, actualización pendiente
- **Uso de `eval()`/`exec()`** presente en código legacy ⚠️ **Riesgo de seguridad**
- **Python 3.12+** no soportado por PySide 1.2.4

### 🚀 Roadmap Futuro

- [ ] Migrar a PySide2/PySide6 (Qt5/Qt6)
- [ ] Actualizar framework web (Flask/FastAPI)
- [ ] Eliminar uso de `eval()`/`exec()`
- [ ] Soporte Python 3.12+
- [ ] Tests automatizados
- [ ] CI/CD con GitHub Actions
- [ ] Containerización con Docker

---

## 📚 Documentación Adicional

- 📖 [CHANGELOG.md](CHANGELOG.md) - Historial de cambios
- 📋 [TODO.txt](TODO.txt) - Tareas pendientes
- 🔍 [ANALISIS_PROYECTO_SPTRACKER.md](ANALISIS_PROYECTO_SPTRACKER.md) - Análisis técnico completo
- 📦 [DEPENDENCIES.txt](DEPENDENCIES.txt) - Dependencias detalladas
- 🏗️ [MODERNIZATION_PLAN.md](MODERNIZATION_PLAN.md) - Plan de modernización

---

## 📄 Licencia

Este proyecto está licenciado bajo **GNU General Public License v3.0** (GPL-3.0).

Ver [LICENSE.txt](LICENSE.txt) para más detalles.

---

## 👤 Autor

**Rodrigo Angeloni**
- 📧 Email: [rodrigoangeloni@gmail.com]
- 🐱 GitHub: [@rodrigoangeloni](https://github.com/rodrigoangeloni)

---

## 🙏 Agradecimientos

- Proyecto original: **SPTracker** por [autor original]
- Comunidad de Assetto Corsa
- Contribuidores del proyecto

---

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 📞 Soporte

¿Problemas o preguntas?

- 🐛 **Issues**: [GitHub Issues](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/issues)
- 💬 **Discusiones**: [GitHub Discussions](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/discussions)

---

<div align="center">

**⭐ Si este proyecto te ayudó, considera darle una estrella en GitHub ⭐**

[![GitHub stars](https://img.shields.io/github/stars/rodrigoangeloni/sptracker-original-3.5.1?style=social)](https://github.com/rodrigoangeloni/sptracker-original-3.5.1)
[![GitHub forks](https://img.shields.io/github/forks/rodrigoangeloni/sptracker-original-3.5.1?style=social)](https://github.com/rodrigoangeloni/sptracker-original-3.5.1)

</div>

---

<p align="center">
  Hecho con ❤️ para la comunidad de Assetto Corsa
</p>
