# API del Servidor Web

## Visión General

SPTracker proporciona una API REST para integración con sistemas externos y acceso programático a datos de carreras.

## Endpoints Principales

### Autenticación

#### POST /api/login
Autenticación de usuario.

**Parámetros**:
```json
{
  "username": "admin",
  "password": "password"
}
```

**Respuesta exitosa**:
```json
{
  "success": true,
  "session_id": "abc123",
  "user": {
    "username": "admin",
    "role": "admin"
  }
}
```

### Sesiones

#### GET /api/sessions
Obtiene lista de sesiones.

**Parámetros de query**:
- `limit`: Número máximo de resultados (default: 50)
- `offset`: Desplazamiento para paginación
- `active_only`: Solo sesiones activas (true/false)

**Respuesta**:
```json
{
  "sessions": [
    {
      "id": 1,
      "name": "Qualifying Session",
      "track": "monza",
      "start_time": "2024-01-01T10:00:00Z",
      "end_time": "2024-01-01T10:30:00Z",
      "status": "finished",
      "participants": 12
    }
  ],
  "total": 150
}
```

#### GET /api/sessions/{id}
Obtiene detalles de una sesión específica.

**Respuesta**:
```json
{
  "id": 1,
  "name": "Race Session",
  "track": "spa",
  "cars": ["ferrari_488_gt3", "bmw_m6_gt3"],
  "participants": [
    {
      "driver": "John Doe",
      "car": "ferrari_488_gt3",
      "best_lap": 125.456,
      "position": 1
    }
  ]
}
```

### Tiempos de Vuelta

#### GET /api/laps
Obtiene tiempos de vuelta.

**Parámetros de query**:
- `session_id`: ID de sesión
- `driver`: Nombre del piloto
- `track`: Nombre del circuito
- `car`: Modelo del coche
- `limit`: Número máximo de resultados

**Respuesta**:
```json
{
  "laps": [
    {
      "id": 123,
      "session_id": 1,
      "driver": "John Doe",
      "track": "monza",
      "car": "ferrari_488_gt3",
      "lap_time": 125.456,
      "sector_times": [45.123, 35.234, 45.099],
      "valid": true,
      "timestamp": "2024-01-01T10:15:30Z"
    }
  ]
}
```

#### GET /api/best-laps
Obtiene mejores tiempos por combinación track/coche.

**Respuesta**:
```json
{
  "best_laps": [
    {
      "track": "monza",
      "car": "ferrari_488_gt3",
      "driver": "John Doe",
      "lap_time": 124.567,
      "date": "2024-01-01T10:15:30Z"
    }
  ]
}
```

### Estadísticas

#### GET /api/stats/drivers
Estadísticas por piloto.

**Parámetros de query**:
- `period`: Período (day, week, month, year)

**Respuesta**:
```json
{
  "drivers": [
    {
      "name": "John Doe",
      "total_laps": 150,
      "best_lap": 124.567,
      "average_lap": 128.456,
      "total_races": 12,
      "wins": 5
    }
  ]
}
```

#### GET /api/stats/tracks
Estadísticas por circuito.

**Respuesta**:
```json
{
  "tracks": [
    {
      "name": "monza",
      "total_sessions": 25,
      "total_laps": 1200,
      "best_lap": 124.567,
      "record_holder": "John Doe"
    }
  ]
}
```

#### GET /api/stats/cars
Estadísticas por modelo de coche.

**Respuesta**:
```json
{
  "cars": [
    {
      "model": "ferrari_488_gt3",
      "total_sessions": 30,
      "total_laps": 800,
      "best_lap": 124.567,
      "most_used_by": "John Doe"
    }
  ]
}
```

### Mapa en Vivo

#### GET /api/live/positions
Obtiene posiciones actuales de todos los coches.

**Respuesta**:
```json
{
  "timestamp": "2024-01-01T10:15:30Z",
  "session_id": 1,
  "positions": [
    {
      "driver": "John Doe",
      "car": "ferrari_488_gt3",
      "position": 1,
      "lap": 5,
      "sector": 2,
      "speed": 280.5,
      "coordinates": [45.123, 9.456],
      "last_lap_time": 125.456
    }
  ]
}
```

#### WebSocket /api/live/stream
Streaming en tiempo real de posiciones.

**Protocolo**: WebSocket  
**Mensajes entrantes**: Suscripción a eventos  
**Mensajes salientes**: Actualizaciones de posición

### Administración

#### POST /api/admin/session/end
Finaliza la sesión actual.

**Requiere autenticación de administrador**

**Respuesta**:
```json
{
  "success": true,
  "message": "Session ended successfully"
}
```

#### POST /api/admin/driver/kick
Expulsa a un piloto.

**Parámetros**:
```json
{
  "driver": "Problem Driver",
  "reason": "Inappropriate behavior"
}
```

#### GET /api/admin/logs
Obtiene logs del sistema.

**Parámetros de query**:
- `level`: Nivel de log (DEBUG, INFO, WARNING, ERROR)
- `limit`: Número máximo de entradas
- `since`: Timestamp desde el cual obtener logs

### Chat

#### GET /api/chat/messages
Obtiene mensajes del chat.

**Parámetros de query**:
- `session_id`: ID de sesión
- `limit`: Número máximo de mensajes

**Respuesta**:
```json
{
  "messages": [
    {
      "id": 123,
      "session_id": 1,
      "driver": "John Doe",
      "message": "Great race everyone!",
      "timestamp": "2024-01-01T10:15:30Z",
      "type": "public"
    }
  ]
}
```

#### POST /api/chat/send
Envía un mensaje al chat.

**Parámetros**:
```json
{
  "message": "Hello everyone!",
  "type": "public"
}
```

## Autenticación y Autorización

### Métodos de Autenticación

1. **Sesión HTTP**: Login tradicional con cookies
2. **Token API**: Para integraciones externas
3. **API Key**: Para aplicaciones de terceros

### Niveles de Acceso

- **Public**: Endpoints accesibles sin autenticación
- **User**: Requiere usuario válido
- **Admin**: Requiere privilegios de administrador

### Rate Limiting

- 100 requests/minuto para usuarios normales
- 1000 requests/minuto para administradores
- Límites configurables en `stracker.ini`

## Formatos de Datos

### Timestamps
Todos los timestamps están en formato ISO 8601 UTC:
```
2024-01-01T10:15:30Z
```

### Unidades
- **Tiempo**: Segundos (float)
- **Velocidad**: km/h (float)
- **Distancia**: Metros (float)
- **Temperatura**: Celsius (float)

### Códigos de Estado HTTP

- `200`: OK - Solicitud exitosa
- `201`: Created - Recurso creado
- `400`: Bad Request - Parámetros inválidos
- `401`: Unauthorized - Autenticación requerida
- `403`: Forbidden - Permisos insuficientes
- `404`: Not Found - Recurso no encontrado
- `429`: Too Many Requests - Rate limit excedido
- `500`: Internal Server Error - Error del servidor

## Ejemplos de Uso

### Python - Obtener posiciones en vivo

```python
import requests
import json

# Autenticación
auth = requests.post('http://localhost:8080/api/login',
                    json={'username': 'admin', 'password': 'password'})
session_id = auth.json()['session_id']

# Obtener posiciones
headers = {'Cookie': f'session_id={session_id}'}
positions = requests.get('http://localhost:8080/api/live/positions',
                        headers=headers)

print(json.dumps(positions.json(), indent=2))
```

### JavaScript - Streaming con WebSocket

```javascript
const ws = new WebSocket('ws://localhost:8080/api/live/stream');

ws.onopen = function(event) {
    // Suscribirse a actualizaciones
    ws.send(JSON.stringify({
        action: 'subscribe',
        type: 'positions'
    }));
};

ws.onmessage = function(event) {
    const data = JSON.parse(event.data);
    console.log('Nueva posición:', data);
};
```

### cURL - Obtener estadísticas

```bash
# Login
curl -X POST http://localhost:8080/api/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"password"}' \
  -c cookies.txt

# Obtener estadísticas
curl -b cookies.txt http://localhost:8080/api/stats/drivers
```

## Webhooks

SPTracker puede enviar notificaciones HTTP a URLs configuradas cuando ocurren eventos importantes.

### Configuración

```ini
[WEBHOOKS]
enabled = yes
url = https://your-app.com/webhook
secret = your_webhook_secret
```

### Eventos Soportados

- `session_start`: Inicio de sesión
- `session_end`: Fin de sesión
- `best_lap`: Nueva mejor vuelta
- `collision`: Colisión detectada
- `driver_join`: Piloto se une
- `driver_leave`: Piloto se va

### Formato del Payload

```json
{
  "event": "best_lap",
  "timestamp": "2024-01-01T10:15:30Z",
  "data": {
    "driver": "John Doe",
    "track": "monza",
    "car": "ferrari_488_gt3",
    "lap_time": 124.567
  },
  "signature": "sha256_signature_of_payload"
}
```

## SDK y Librerías

### Python SDK
```python
from sptracker_sdk import SPTrackerClient

client = SPTrackerClient('http://localhost:8080', 'admin', 'password')
positions = client.get_live_positions()
stats = client.get_driver_stats('John Doe')
```

### JavaScript SDK
```javascript
import { SPTracker } from 'sptracker-js-sdk';

const client = new SPTracker('http://localhost:8080');
await client.login('admin', 'password');
const positions = await client.getLivePositions();
```

## Consideraciones de Producción

### Seguridad
- Usar HTTPS en producción
- Implementar rate limiting
- Validar todos los inputs
- Usar secrets fuertes para webhooks

### Rendimiento
- Implementar caching para endpoints frecuentes
- Usar compresión de respuestas
- Configurar límites apropiados de conexión
- Monitorear uso de recursos

### Escalabilidad
- Considerar múltiples instancias detrás de load balancer
- Usar base de datos externa para alta carga
- Implementar colas para operaciones pesadas
- Configurar límites de streaming apropiados