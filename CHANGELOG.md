# Changelog

All notable changes to stracker will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.5.2] - 2025-10-06

### Added
- Python 3.11.8 compatibility
- Modern dependency versions for all packages
- PyInstaller build system (replaces obsolete py2exe)
- Comprehensive requirements.txt with pinned versions
- APSW 3.50.4.0 for SQLite database backend

### Changed
- Migrated from py2exe to PyInstaller for executable building
- Updated CherryPy from 8.1.2 to 18.10.0
- Added Cheroot 11.0.0 (CherryPy's WSGI server was moved to separate package)
- Updated all dependencies to Python 3.11 compatible versions

### Fixed
- **CRITICAL**: Fixed `async` keyword conflicts in Python 3.7+
  - `ptracker_lib/async_worker.py`: Renamed `async` parameter to `is_async`
  - `ptracker_lib/database.py`: Renamed `async` variable to `is_async`
  - These were SyntaxErrors preventing module compilation since Python 3.7 made `async` a reserved keyword
- Fixed `collections.Iterable` import for Python 3.10+ (moved to `collections.abc`)
- Fixed CherryPy WSGI server import (cherrypy.wsgiserver.wsgiserver3 → cheroot.wsgi)
- Added graceful handling for missing APSW module with clear error message

### Technical Details
- Original version was built for Python 3.3 (2018)
- This version modernizes the codebase for Python 3.11.8 (2025)
- All core functionality preserved while ensuring compatibility with modern Python
- PyInstaller hook created to properly package all ptracker_lib submodules

### Dependencies Updated
- bottle: 0.13.4
- cherrypy: 18.10.0 (was 8.1.2)
- cheroot: 11.0.0 (new)
- apsw: 3.50.4.0 (new explicit requirement)
- psycopg2-binary: 2.9.10
- python-dateutil: 2.9.0.post0
- wsgi-request-logger: 0.4.6
- simplejson: 3.20.2
- pygal: 3.0.5
- pyinstaller: 6.16.0 (replaces py2exe)

## [3.5.1] - 2018 (Original Release)

Original release by **Neys** with Python 3.3 support.

### Note About Version History

The original project (versions 3.0.x - 3.5.1) did not maintain a formal changelog. 
Based on the TODO.txt file and code comments, we can infer there were several major versions:

- **3.0.x - 3.1.x**: Early releases (details unknown)
- **3.2.x**: Major feature additions mentioned in TODO.txt
  - Live map administration
  - Chat logging
  - Lap comparisons
  - Swear filter/autokick
  - Various HTTP interface improvements
- **3.3.x**: Continued development (features in TODO.txt)
  - Interface ports
  - Animation improvements
- **3.4.x**: Unknown (no documentation found)
- **3.5.0 - 3.5.1**: Final Python 3.3 release (2018)
  - py2exe build system
  - CherryPy 8.1.2
  - PostgreSQL and SQLite support with APSW

For detailed feature requests and planned work, see the [TODO.txt](TODO.txt) file which 
contains the original development roadmap from Neys.
