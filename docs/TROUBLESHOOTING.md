# Guía de Solución de Problemas

## Problemas de Instalación

### "ptracker.exe has stopped working" durante instalación

**Síntoma**: El instalador falla con error genérico durante la verificación de instalación.

**Causa**: PySide/Qt no está incluido en el ejecutable o es incompatible.

**Solución**:
1. Verificar que PySide6 esté instalado: `pip install PySide6`
2. Reconstruir el ejecutable: `python create_release.py --test_release_process VERSION`
3. Verificar tamaño del exe (>60MB indica que Qt está incluido)

**Debug**: Ejecutar `ptracker.exe /check_install` manualmente para aislar el error.

### Error de dependencias faltantes

**Síntoma**: ImportError al ejecutar componentes.

**Solución**:
```bash
pip install -r requirements.txt
pip install PySide6 psycopg2-binary
```

### Problemas de permisos

**Windows**:
- Ejecutar como administrador
- Verificar permisos de escritura en directorio de instalación

**Linux/Mac**:
```bash
chmod +x ptracker-server
sudo chown -R $USER:$USER /opt/sptracker
```

## Problemas de Inicio

### Servidor no inicia

**Logs a revisar**:
- `stracker.log`: Log principal
- `debug.log`: Log de debug (si habilitado)
- Consola de comandos

**Causas comunes**:
1. **Puerto ocupado**:
   ```bash
   netstat -an | grep 8080  # Windows
   lsof -i :8080            # Linux/Mac
   ```

2. **Archivo de configuración inválido**:
   ```bash
   python stracker/stracker.py --check-config
   ```

3. **Base de datos corrupta**:
   - Borrar `stracker.db` para SQLite
   - Verificar conexión PostgreSQL

### Cliente no se conecta al servidor

**Verificar**:
1. **Configuración de red**:
   ```ini
   [STRACKER_CONFIG]
   ptracker_connection_mode = client
   ac_server_address = IP_DEL_SERVIDOR
   listening_port = 50000
   ```

2. **Firewall**: Abrir puerto 50000 TCP

3. **Conectividad**:
   ```bash
   telnet IP_SERVIDOR 50000
   ```

## Problemas de Rendimiento

### Alto uso de CPU

**Causas**:
1. **Logging excesivo**: Cambiar a `log_level = WARNING`
2. **Muchas conexiones**: Limitar `max_streaming_clients`
3. **Queries ineficientes**: Verificar índices en BD

**Optimización**:
```ini
[HTTP_CONFIG]
max_streaming_clients = 20
enable_svg_generation = no

[STRACKER_CONFIG]
log_level = WARNING
```

### Memoria insuficiente

**Síntomas**: OutOfMemoryError, aplicación lenta.

**Soluciones**:
1. **Reducir caché**: `items_per_page = 25`
2. **Comprimir BD**: Habilitar `db_compression`
3. **Limitar historial**: Configurar retención de datos

### Latencia alta en interfaz web

**Diagnóstico**:
1. Verificar carga del servidor
2. Comprobar queries lentas en BD
3. Revisar conectividad de red

**Optimizaciones**:
- Usar PostgreSQL en lugar de SQLite
- Implementar caching
- Optimizar queries con índices

## Problemas de Base de Datos

### SQLite: "Database locked"

**Causa**: Múltiples procesos accediendo simultáneamente.

**Soluciones**:
1. Usar PostgreSQL para múltiples usuarios
2. Implementar locking adecuado
3. Evitar operaciones concurrentes largas

### PostgreSQL: "Connection refused"

**Verificar**:
1. **Servicio ejecutándose**:
   ```bash
   sudo systemctl status postgresql
   ```

2. **Configuración de conexión**:
   ```ini
   [DATABASE]
   postgres_host = localhost
   postgres_user = stracker_user
   postgres_db = stracker_db
   ```

3. **Permisos de usuario**:
   ```sql
   GRANT ALL PRIVILEGES ON DATABASE stracker_db TO stracker_user;
   ```

### Datos corruptos

**Recuperación**:
1. **Backup automático**: Verificar `perform_backups = yes`
2. **Restaurar desde backup**:
   ```bash
   cp stracker.db.backup stracker.db
   ```

3. **Reparar BD**:
   ```bash
   sqlite3 stracker.db ".recover" > recovered.sql
   ```

## Problemas de Red

### Conexiones intermitentes

**Diagnóstico**:
```bash
ping IP_SERVIDOR
traceroute IP_SERVIDOR
```

**Soluciones**:
1. **Timeout más largo**:
   ```ini
   [STRACKER_CONFIG]
   connection_timeout = 30
   ```

2. **Reintentos automáticos**:
   ```ini
   [STRACKER_CONFIG]
   max_reconnect_attempts = 5
   ```

### Pérdida de paquetes

**Síntomas**: Datos de telemetría incompletos.

**Soluciones**:
1. **Red local**: Verificar switches/hubs
2. **WiFi**: Cambiar a cableada para estabilidad
3. **QoS**: Priorizar tráfico UDP/TCP del juego

## Problemas de Assetto Corsa

### Plugin no carga

**Verificar**:
1. **Instalación correcta**:
   ```
   Assetto Corsa/
   ├── apps/
   │   └── python/
   │       └── ptracker/
   │           ├── ptracker.py
   │           └── ... (otros archivos)
   ```

2. **Python en AC**: Verificar que AC use Python compatible

3. **Logs de AC**:
   ```
   Assetto Corsa/logs/ptracker_fileobserver.txt
   ```

### Datos de telemetría incorrectos

**Causas**:
1. **Configuración de pista**: Verificar layout correcto
2. **Modos de carrera**: Algunos modos no generan telemetría completa
3. **Plugins conflictivos**: Desactivar otros plugins

## Problemas de Interfaz Web

### Página no carga

**Debug**:
1. **Servidor ejecutándose**:
   ```bash
   curl http://localhost:8080
   ```

2. **Puerto correcto**:
   ```ini
   [HTTP_CONFIG]
   listen_port = 8080
   ```

3. **Firewall**: Abrir puerto 8080

### Gráficos no se muestran

**Causas**:
1. **pygal no instalado**: `pip install pygal`
2. **SVG deshabilitado**: `enable_svg_generation = yes`
3. **Cache del navegador**: Ctrl+F5

### Autenticación falla

**Verificar**:
1. **Credenciales**:
   ```ini
   [HTTP_CONFIG]
   admin_username = admin
   admin_password = correct_password
   ```

2. **Sesión expirada**: Re-loguear

3. **Cookies habilitadas**: Verificar configuración del navegador

## Problemas de Audio

### Sonidos no funcionan

**Windows**:
- Verificar dispositivo de audio por defecto
- Probar otros archivos WAV

**Configuración**:
```ini
# Verificar que los archivos existen
sounds/
├── Alarm3.wav
├── Applause.wav
└── ...
```

## Problemas Avanzados

### Debug detallado

**Habilitar logging completo**:
```ini
[STRACKER_CONFIG]
log_level = DEBUG
append_log_file = yes

[HTTP_CONFIG]
log_requests = yes
```

**Logs a revisar**:
- `stracker.log`: Eventos principales
- `auth.log`: Autenticación
- `debug.log`: Información detallada

### Profiling de rendimiento

```python
# Agregar al código para profiling
import cProfile
cProfile.run('funcion_a_perflar()', 'profile_output.prof')

# Analizar resultados
import pstats
p = pstats.Stats('profile_output.prof')
p.sort_stats('cumulative').print_stats(20)
```

### Memory leaks

**Herramientas**:
- `tracemalloc` para tracking de memoria
- `objgraph` para análisis de objetos
- Monitoreo con `psutil`

```python
import tracemalloc
tracemalloc.start()

# Código a analizar
snapshot = tracemalloc.take_snapshot()
top_stats = snapshot.statistics('lineno')
for stat in top_stats[:10]:
    print(stat)
```

## Comandos de Diagnóstico

### Verificar instalación

```bash
# Windows
ptracker.exe /check_install

# Linux/Mac
./ptracker-server --check-install
```

### Verificar conectividad

```bash
# Test HTTP
curl -I http://localhost:8080

# Test WebSocket
websocat ws://localhost:8080/api/live/stream

# Test base de datos
python -c "import ptracker_lib.database; print('DB OK')"
```

### Verificar configuración

```bash
python stracker/stracker.py --check-config --verbose
```

### Backup de datos

```bash
# SQLite
cp stracker.db stracker.db.backup

# PostgreSQL
pg_dump stracker_db > backup.sql
```

## Contacto y Soporte

### Comunidad
- **Foros de Assetto Corsa**: Sección SPTracker
- [**GitHub Issues**](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/issues) - Para bugs específicos
- [**GitHub Discussions**](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/discussions) - Para preguntas generales
- [**GitHub Wiki**](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/wiki) - Guías comunitarias
- **Discord**: Chat en tiempo real

### Información para reportes de bug

Incluir siempre:
- Versión de SPTracker
- Sistema operativo y versión
- Configuración relevante (`stracker.ini`)
- Logs completos del error
- Pasos para reproducir

### Template de reporte

```
**Título**: [BUG] Descripción breve

**Versión**: 3.5.1
**SO**: Windows 10
**Descripción**:
Pasos detallados para reproducir

**Configuración**:
[Secciones relevantes de stracker.ini]

**Logs**:
[Contenido relevante de logs]

**Comportamiento esperado**:
[Qué debería pasar]

**Comportamiento actual**:
[Qué pasa en realidad]
```

## Prevención de Problemas

### Mantenimiento regular

1. **Backups semanales**:
   ```ini
   [DATABASE]
   perform_backups = yes
   ```

2. **Actualizaciones**: Mantener dependencias actualizadas

3. **Monitoreo**: Revisar logs semanalmente

### Configuración de producción

```ini
[STRACKER_CONFIG]
log_level = INFO
lower_priority = yes

[HTTP_CONFIG]
max_streaming_clients = 50
items_per_page = 100

[DATABASE]
perform_backups = yes

[DB_COMPRESSION]
mode = weekly
```

### Alertas y monitoreo

- Configurar logs rotativos
- Monitorear uso de recursos
- Alertas para errores críticos
- Backup automático antes de actualizaciones