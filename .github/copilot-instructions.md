# Guía para Agentes de IA en SPTracker

## Arquitectura General
- El proyecto SPTracker contiene dos componentes principales:
  - **PTracker** (`ptracker.py`, `ptracker-server.py`, `ptracker_lib/`): Cliente para tracking de vueltas y tiempos en Assetto Corsa.
  - **STracker** (`stracker/`, `stracker_lib/`): Servidor de estadísticas y portal web.
- La comunicación entre cliente y servidor usa protocolos personalizados definidos en `ptracker_lib/client_server/`.
- El almacenamiento de datos se realiza en SQLite o PostgreSQL, con abstracciones en `database.py` y `db*`.
- La interfaz gráfica usa PySide (Qt4), y la web usa Bottle y CherryPy.

## Flujos y Componentes Clave
- El flujo principal: Assetto Corsa → PTracker → PTracker Server → STracker → Base de datos → Interfaz web.
- Los datos de sesión y vueltas se recolectan en tiempo real y se almacenan para análisis posterior.
- El portal web (`www/`, `stracker/http_static/`, `stracker/http_templates/`) permite visualizar estadísticas y documentación.

## Dependencias y Versiones
- El proyecto depende de Python 3.3 y librerías muy antiguas (ver `DEPENDENCIES.txt`).
- Para modernizar, priorizar la actualización de Python y dependencias (PySide, Bottle, CherryPy, psycopg2, Bootstrap, jQuery).
- Los DLLs para integración nativa están en `ptracker_lib/stdlib/` y `stdlib64/`.

## Convenciones y Patrones
- El código usa threading personalizado y comunicación socket propia.
- Los archivos de configuración y paths suelen requerir edición manual (ver instrucciones en `README.txt`).
- El uso de `eval()` y `exec()` es frecuente y crítico: revisa y elimina estos patrones por seguridad.
- Los hooks DLL (`create_file_hook/`) se usan para monitoreo avanzado.

## Workflows de Desarrollo
- Para ejecutar PTracker: usar `ptracker.py` o `ptracker-server.py` tras configurar el entorno virtual.
- Para ejecutar STracker: usar `stracker/stracker.py` y acceder vía web.
- Los tests y simulaciones están en `stresstest/`.
- Los recursos gráficos y de audio están en `images/` y `sounds/`.

## Ejemplo de Actualización
- Para migrar a Python moderno:
  1. Actualiza `DEPENDENCIES.txt` y adapta imports incompatibles.
  2. Refactoriza el uso de PySide a PySide2/PyQt5.
  3. Reemplaza Bottle/CherryPy por versiones actuales.
  4. Elimina o reemplaza todo uso de `eval()` y `exec()`.

## Seguridad y Riesgos
- El código actual tiene vulnerabilidades críticas por dependencias obsoletas y uso de `eval()`/`exec()`.
- Prioriza la revisión de estos puntos antes de desplegar en producción.

## Referencias Clave
- `README.txt`, `ANALISIS_PROYECTO_SPTRACKER.md`, `DEPENDENCIES.txt`, `TODO.txt` para contexto y tareas pendientes.
- `ptracker_lib/`, `stracker/stracker_lib/` para lógica principal.

---

¿Alguna sección te resulta poco clara o incompleta? ¿Quieres mayor detalle sobre algún flujo, convención o componente específico?
