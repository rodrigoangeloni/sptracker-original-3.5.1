# Plan de Modernización de SPTracker (2018 → 2025)

## Estado Actual
- **Código base**: Python 3.3 (2018)
- **Objetivo**: Python 3.11+ (2025)
- **Repositorio**: `main` branch (código original limpio)

---

## Lecciones Aprendidas del Intento Anterior

### ❌ Problemas Encontrados
1. **PyInstaller 6.x vs 2.x**: Comportamiento muy diferente en detección de módulos
2. **Estructura ptracker_lib**: Directorio paralelo no detectado automáticamente
3. **Muchos cambios simultáneos**: Difícil identificar qué rompió qué
4. **Falta de testing incremental**: No probamos cada paso antes de avanzar

### ✅ Lo que SÍ funcionó
1. **Modernización de sintaxis**: PySide6, type hints, logging moderno
2. **Actualización de dependencias**: Bottle, CherryPy, etc. funcionan bien
3. **Build scripts**: `build_dev.py` y `build_release.py` son buenos

---

## Estrategia Nueva: Enfoque Incremental

### Fase 1: Preparación del Entorno ✅
**Objetivo**: Ambiente funcional con Python 3.11

- [ ] Crear rama `modernization` desde `main`
- [ ] Instalar Python 3.11.8
- [ ] Crear virtualenv `.venv`
- [ ] Instalar dependencias base (requirements.txt)
- [ ] **PROBAR**: `python stracker/stracker.py --help` debe funcionar

**Criterio de éxito**: El código original ejecuta sin errores

---

### Fase 2: Actualización de Dependencias (Sin cambios de código)
**Objetivo**: Usar versiones modernas de librerías sin tocar código Python

#### 2.1 Dependencias Core
- [ ] Actualizar `bottle` (mantener compatibilidad)
- [ ] Actualizar `cherrypy`
- [ ] Actualizar `psycopg2-binary`
- [ ] Actualizar `Pillow`
- [ ] **PROBAR**: `python stracker/stracker.py --help` sigue funcionando

#### 2.2 Dependencias de Build
- [ ] Instalar PyInstaller 6.16.0
- [ ] Probar build con comando ORIGINAL de `create_release.py` línea 253:
  ```bash
  pyinstaller --name stracker --clean -y --onefile \
    --exclude-module http_templates \
    --hidden-import cherrypy.wsgiserver.wsgiserver3 \
    --hidden-import psycopg2 \
    --additional-hooks-dir=pyinstaller-hooks \
    --path .. --path externals \
    stracker.py
  ```
- [ ] **PROBAR**: `stracker.exe --help` debe funcionar
- [ ] **PROBAR EN SERVER**: Deploy en Server Manager y verificar que arranca

**Criterio de éxito**: Ejecutable funciona con código sin modificar

---

### Fase 3: Corrección de Warnings (Sin romper compatibilidad)
**Objetivo**: Eliminar deprecation warnings de Python 3.11

- [ ] Corregir `SyntaxWarning: "is not" with literal` en `mr_query.py`
- [ ] Corregir otros warnings de sintaxis obsoleta
- [ ] **NO CAMBIAR** lógica de negocio
- [ ] **PROBAR**: Build y ejecución después de CADA cambio

**Criterio de éxito**: Sin warnings, ejecutable funciona igual

---

### Fase 4: Modernización de Logging (Opcional)
**Objetivo**: Sistema de logging moderno sin romper el existente

- [ ] Crear `modern_logging.py` como wrapper del logger original
- [ ] Mantener compatibilidad con API antigua
- [ ] Agregar `--modern-logging` flag (opcional)
- [ ] **PROBAR**: Modo legacy y modo moderno funcionan

**Criterio de éxito**: Dos modos de logging, ambos funcionan

---

### Fase 5: Solución del Problema ptracker_lib
**Objetivo**: Hacer que PyInstaller 6.x empaquete ptracker_lib correctamente

#### Opción A: Hook de PyInstaller (Limpio)
```python
# stracker/pyinstaller-hooks/hook-ptracker_lib.py
from PyInstaller.utils.hooks import collect_all

datas, binaries, hiddenimports = collect_all('ptracker_lib')
```
- [ ] Crear hook
- [ ] Probar build
- [ ] Verificar que `async_worker` está en PYZ-00.toc

#### Opción B: Copiar ptracker_lib antes del build (Pragmático)
- [ ] Script pre-build que copia `ptracker_lib/` a `stracker/ptracker_lib/`
- [ ] Build normal
- [ ] Script post-build que elimina la copia
- [ ] **PROBAR**: Ejecutable funciona

#### Opción C: Hidden imports explícitos (Fallback)
```python
--hidden-import ptracker_lib.async_worker
--hidden-import ptracker_lib.helpers
--hidden-import ptracker_lib.config
# ... etc para todos los módulos necesarios
```

**Criterio de éxito**: `stracker.exe` arranca sin `ModuleNotFoundError`

---

### Fase 6: PySide6 (GUI) - SOLO SI ES NECESARIO
**Objetivo**: Migrar de PySide2 a PySide6 (solo si usas la GUI)

**IMPORTANTE**: Si solo usas `stracker.exe` (servidor sin GUI), saltar esta fase

- [ ] Verificar si la GUI es necesaria
- [ ] Si NO: Excluir completamente PySide de los builds
- [ ] Si SÍ: Migrar incrementalmente módulos GUI

---

### Fase 7: Testing y Optimización
**Objetivo**: Ejecutable estable y optimizado

- [ ] Probar 24h en Server Manager
- [ ] Monitorear logs por errores
- [ ] Optimizar tamaño del ejecutable (si es necesario)
- [ ] Documentar cambios en CHANGELOG.md

---

## Comandos de Referencia

### Setup Inicial
```bash
# Crear rama nueva
git checkout -b modernization

# Setup virtualenv
python -m venv .venv
.\.venv\Scripts\Activate.ps1

# Instalar dependencias
pip install -r requirements.txt
pip install pyinstaller
```

### Build Original (Probado en 2018)
```bash
cd stracker
pyinstaller --name stracker --clean -y --onefile \
  --exclude-module http_templates \
  --hidden-import cherrypy.wsgiserver.wsgiserver3 \
  --hidden-import psycopg2 \
  --additional-hooks-dir=pyinstaller-hooks \
  --path .. --path externals \
  stracker.py
```

### Testing Rápido
```bash
# Test local
.\stracker\dist\stracker.exe --help

# Deploy
Copy-Item stracker\dist\stracker.exe C:\servermanager\assetto\stracker\stracker.exe -Force

# Monitor logs
Get-Content C:\servermanager\assetto\stracker\stracker.log -Wait -Tail 50
```

---

## Notas Importantes

### PyInstaller 6.x vs 2.x
- **2.x (2018)**: Auto-detectaba imports de `--path` directories
- **6.x (2025)**: Solo auto-detecta de site-packages instalados
- **Solución**: Hooks explícitos o copiar módulos localmente

### Estructura del Proyecto
```
sptracker-original-3.5.1/
├── ptracker_lib/          # ← Biblioteca compartida (paralela a stracker/)
├── stracker/              # ← Aplicación principal
│   ├── stracker.py        # ← Entry point
│   ├── stracker_lib/      # ← Módulos internos de stracker
│   └── externals/         # ← Librerías vendidas (pygal, acplugins4python)
└── ptracker/              # ← GUI client (no necesario para servidor)
```

### Módulos Críticos de ptracker_lib
Estos DEBEN estar en el ejecutable:
- `async_worker.py` - Workers asíncronos (usado por mr_query.py)
- `helpers.py` - Funciones auxiliares (usado por múltiples módulos)
- `config.py` - Configuración
- `constants.py` - Constantes
- `dbgeneric.py`, `dbapsw.py`, `dbpostgres.py` - Acceso a BD

---

## Plan de Contingencia

Si algo falla en cualquier fase:
1. **Commit** el último estado funcional
2. **Documentar** exactamente qué cambió
3. **Revertir** al commit anterior funcional
4. **Analizar** qué salió mal
5. **Intentar** enfoque alternativo

**Regla de oro**: Nunca hacer más de UN cambio significativo sin probar

---

## Próximos Pasos INMEDIATOS

1. **Crear rama `modernization`**
   ```bash
   git checkout -b modernization
   ```

2. **Verificar código original funciona**
   ```bash
   python -m venv .venv
   .\.venv\Scripts\Activate.ps1
   pip install -r requirements.txt
   python stracker/stracker.py --help
   ```

3. **Probar build original**
   ```bash
   pip install pyinstaller==6.16.0
   cd stracker
   # Usar comando exacto de create_release.py línea 253
   ```

4. **Si el build falla**: Empezar con Fase 5 (solución ptracker_lib)

---

**Última actualización**: 6 de octubre de 2025
**Autor**: Copilot + Rodrigo
**Estado**: Plan creado, listo para ejecutar
