# Problemas de Build de SPTracker

## Fecha: 7 de octubre de 2025

## Resumen
El proceso de creación de release (`create_release.py --test_release_process --windows`) falla al intentar ejecutarse con Python 3.10 en un sistema sin Assetto Corsa instalado.

## Problemas Identificados

### 1. Incompatibilidad de Bytecode
**Error:** `IndexError: tuple index out of range` en `dis.py`

**Causa:** PyInstaller intenta analizar módulos binarios (`.pyd`) compilados para Python 3.3, pero el entorno actual usa Python 3.10. El formato de bytecode ha cambiado entre estas versiones.

**Archivos problemáticos:**
- `ptracker_lib/_imagingft.pyd`
- `ptracker_lib/stdlib/_ctypes.pyd`
- `ptracker_lib/stdlib/unicodedata.pyd`
- `ptracker_lib/stdlib64/_ctypes.pyd`

### 2. Dependencia de Assetto Corsa
**Error:** Falta el módulo `acsys`

**Causa:** El script `ptracker-server-dist.py` importa módulos de Assetto Corsa:
```python
sys.path.append('apps/python/system')
import acsys
```

**Path esperado:** `C:\Program Files (x86)\Steam\SteamApps\common\assettocorsa\apps\python\system`

### 3. Archivos `.pyc` Obsoletos
Se encontraron archivos `.pyc` compilados con versiones antiguas de Python que causaban conflictos.

**Solución aplicada:** Se eliminaron todos los archivos `.pyc` y directorios `__pycache__`.

## Soluciones Necesarias

### Solución 1: Usar Python 3.3 (Solución Temporal)
Para crear releases usando el código actual sin modificaciones:
1. Instalar Python 3.3.x
2. Instalar Assetto Corsa
3. Configurar el entorno con las dependencias originales
4. Ejecutar `create_release.py` desde Python 3.3

### Solución 2: Modernizar el Proyecto (Solución Recomendada)
Para poder compilar con Python moderno (3.10+):

#### 2.1 Recompilar Módulos Binarios
- Recompilar o reemplazar todos los archivos `.pyd` para Python 3.10
- Actualizar `CreateFileHook.dll` si es necesario

#### 2.2 Eliminar Dependencia de Assetto Corsa para Build
- Crear un mock de `acsys` para el proceso de build
- Separar el código de build del código de runtime
- Los módulos de AC solo se cargan en tiempo de ejecución, no en build time

#### 2.3 Actualizar Dependencias
- Migrar de PySide (Qt4) a PySide2/PySide6 (Qt5/Qt6)
- Actualizar PyInstaller a la última versión
- Revisar todas las dependencias en `requirements.txt`

#### 2.4 Modificar `create_release.py`
- Actualizar el comando de PyInstaller para Python 3.10
- Remover paths hardcodeados de Assetto Corsa del proceso de build
- Agregar validaciones para detectar entornos sin AC instalado

## Archivos Modificados Durante la Investigación

### `ptracker.spec`
- Removido path de Assetto Corsa de `pathex`
- Agregados módulos a `excludes`: `acsys`, `ac`, `apps`, `_ctypes`, `unicodedata`, `_imagingft`
- Cambio de `pathex`: 
  - Antes: `['C:\\Program Files (x86)\\Steam\\...\\assettocorsa\\apps\\python\\system', 'stracker']`
  - Después: `['stracker']`

### `create_release.py`
- Modificado comando de PyInstaller para usar el archivo `.spec` existente
- Comando actual: `.venv\\Scripts\\python -m PyInstaller --clean -y ptracker.spec`

## Comandos de Limpieza Ejecutados

```powershell
# Eliminar archivos .pyc
Get-ChildItem -Path . -Recurse -Filter "*.pyc" -Exclude ".venv" -ErrorAction SilentlyContinue | 
    Where-Object { $_.FullName -notlike "*\.venv\*" } | 
    Remove-Item -Force -Verbose

# Eliminar directorios __pycache__
Get-ChildItem -Path ptracker_lib, stracker -Recurse -Directory -Filter "__pycache__" -ErrorAction SilentlyContinue | 
    Remove-Item -Recurse -Force -Verbose
```

## Próximos Pasos Recomendados

1. **Corto plazo:** Documentar el proceso de build completo incluyendo todos los prerequisitos
2. **Medio plazo:** Crear mocks de módulos de AC para permitir builds sin AC instalado
3. **Largo plazo:** Migrar completamente a Python 3.10+ y dependencias modernas

## Notas Adicionales

- El proyecto fue originalmente diseñado para Python 3.3
- La rama actual es `py-upgrade`, sugiriendo que ya hay trabajo en progreso para actualizar Python
- Los módulos binarios (`.pyd`, `.dll`) necesitan atención especial durante la migración
- El proceso de build está íntimamente ligado a la estructura de Assetto Corsa

## Referencias

- Ver `ANALISIS_PROYECTO_SPTRACKER.md` para contexto adicional
- Ver `DEPENDENCIES.txt` para lista completa de dependencias
- Ver `TODO.txt` para tareas pendientes del proyecto
