# Stracker - Server Statistics and Tracking for Assetto Corsa

[![Python Version](https://img.shields.io/badge/python-3.11-blue.svg)](https://www.python.org/downloads/)
[![License](https://img.shields.io/badge/license-GPL--3.0-green.svg)](LICENSE.txt)

**Version 3.5.2 - Python 3.11 Modernization Release**

Stracker is a statistics and tracking system for Assetto Corsa multiplayer servers. This fork brings the original 2018 codebase (Python 3.3) up to modern Python 3.11.8 standards while preserving all functionality.

## 🎯 What's New in 3.5.2

This release focuses on **Python 3.11 compatibility** and modernization:

- ✅ **Fixed critical `async` keyword conflicts** (Python 3.7+ compatibility)
- ✅ **Migrated from py2exe to PyInstaller** (modern build system)
- ✅ **Updated all dependencies** to latest compatible versions
- ✅ **Fixed CherryPy WSGI server** imports (cheroot package)
- ✅ **Python 3.10+ collections.abc** compatibility

### Breaking Language Changes Fixed

The main issue preventing the original code from running on Python 3.7+ was the use of `async` as a variable/parameter name, which became a reserved keyword:

- `ptracker_lib/async_worker.py` - Renamed `async` → `is_async`
- `ptracker_lib/database.py` - Renamed `async` → `is_async`

See [CHANGELOG.md](CHANGELOG.md) for complete details.

## 📋 Requirements

- **Python 3.11.8** (tested and verified)
- **Windows 10/11** (for compiled .exe) or **Linux** (Ubuntu 18.04+)
- **Assetto Corsa Dedicated Server**

### Platform Support

| Platform | Status | Binary Format | Notes |
|----------|--------|---------------|-------|
| Windows 10/11 | ✅ Tested | `.exe` | Primary development platform |
| Linux (Ubuntu 22.04) | ✅ Tested | ELF binary | Via WSL or native |
| Linux (Other distros) | ⚠️ Should work | ELF binary | May need dependency adjustments |

## 🚀 Quick Start

### For Users (Compiled Binary)

#### Windows
1. Download `stracker.exe` from the releases page
2. Copy to your Assetto Corsa server directory
3. Configure `stracker.ini` to point to your AC server
4. Run `stracker.exe`

#### Linux
1. Download `stracker_linux_x86.tgz` from the releases page
2. Extract to your Assetto Corsa server directory
3. Configure `stracker.ini` to point to your AC server
4. Run `./stracker`

### For Developers (Source)

#### Windows Build

```bash
# Clone the repository
git clone https://github.com/rodrigoangeloni/sptracker-original-3.5.1.git
cd sptracker-original-3.5.1

# Create virtual environment
python -m venv .venv
.venv\Scripts\activate  # Windows

# Install dependencies
pip install -r requirements.txt

# Build stracker.exe (Windows)
python create_release.py --test_release_process --windows_only --stracker_only 3.5.2
```

#### Linux Build (WSL or Native)

```bash
# Install Python 3.11 on Ubuntu/Debian
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.11 python3.11-venv python3.11-dev build-essential libpq-dev libsqlite3-dev

# Clone repository
git clone https://github.com/rodrigoangeloni/sptracker-original-3.5.1.git
cd sptracker-original-3.5.1

# Create virtual environment
python3.11 -m venv .venv
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Build stracker (Linux)
chmod +x build_linux.sh
./build_linux.sh 3.5.2

# Or manually:
python create_release.py --test_release_process --linux_only --stracker_only 3.5.2
```

**For detailed Linux build instructions**, see [BUILD_LINUX.md](BUILD_LINUX.md)
```

## 📦 Dependencies

All dependencies with verified versions:

```
apsw==3.50.4.0
bottle==0.13.4
cherrypy==18.10.0
cheroot==11.0.0
psycopg2-binary==2.9.10
python-dateutil==2.9.0.post0
wsgi-request-logger==0.4.6
simplejson==3.20.2
pygal==3.0.5
pyinstaller==6.16.0
```

See [requirements.txt](requirements.txt) for the complete list.

## 🔧 Configuration

Edit `stracker.ini` to configure:

- AC server connection settings
- Database type (SQLite with APSW or PostgreSQL)
- HTTP server for web interface
- Session management
- And much more...

See the original `stracker.ini.sample` for all options.

## 🐛 Known Issues

- `python33.dll` warning during build is **harmless** (legacy PIL/Pillow dependency)
- APSW is now a required dependency (was optional in original)
- PostgreSQL backend requires additional configuration

## 📝 Migration from Original 3.5.1

If you're upgrading from the original 2018 release:

1. **Backup your database** (`stracker.db3` or PostgreSQL)
2. **Backup your config** (`stracker.ini`)
3. Replace `stracker.exe` with the new version
4. Test with a non-production server first
5. All data and settings are preserved

## 🤝 Contributing

This is a modernization fork focused on Python 3.11 compatibility. The original development was by **Neys** (never_eat_yellow_snow1).

For bugs or improvements related to Python 3.11 compatibility, please open an issue or submit a PR.

## 📜 License

GNU General Public License v3.0 - See [LICENSE.txt](LICENSE.txt)

Original author: **Neys**
- AC Forums: [never_eat_yellow_snow1](http://www.assettocorsa.net/forum/)
- RaceDepartment: [Neys](http://www.racedepartment.com/forums/)

Python 3.11 modernization: **Rodrigo Angeloni** (2025)

## 🙏 Acknowledgments

- Original author **Neys** for creating stracker
- Assetto Corsa community for continued support
- All contributors who helped identify Python 3.11 compatibility issues

---

**Note**: This fork maintains backward compatibility with databases and configurations from the original 3.5.1 release.
