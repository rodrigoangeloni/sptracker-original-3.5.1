# 📚 Documentación de SPTracker

<div align="center">

![SPTracker Logo](../images/brand_icon_large_wob.png)

**Bienvenido a la documentación completa de SPTracker**

*Este índice le ayudará a encontrar rápidamente la información que necesita*

[![🏠 Inicio](https://img.shields.io/badge/🏠_Inicio-README.md-3776AB?style=flat-square)](../README.md)
[![🐛 Issues](https://img.shields.io/github/issues/rodrigoangeloni/sptracker-original-3.5.1?style=flat-square)](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/issues)
[![💬 Discusiones](https://img.shields.io/github/discussions/rodrigoangeloni/sptracker-original-3.5.1?style=flat-square)](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/discussions)
[![📖 Wiki](https://img.shields.io/badge/📖_Wiki-GitHub-181717?style=flat-square)](https://github.com/rodrigoangeloni/sptracker-original-3.5.1/wiki)

</div>

---

## 📚 Guías principales

### Para usuarios

| Documento | Descripción | Nivel |
|-----------|-------------|-------|
| [`../README.md`](../README.md) | Visión general y inicio rápido | Principiante |
| [`CONFIGURATION.md`](CONFIGURATION.md) | Configuración completa del sistema | Intermedio |
| [`TROUBLESHOOTING.md`](TROUBLESHOOTING.md) | Solución de problemas comunes | Todos |

### Para desarrolladores

| Documento | Descripción | Nivel |
|-----------|-------------|-------|
| [`ARCHITECTURE.md`](ARCHITECTURE.md) | Arquitectura del sistema | Intermedio |
| [`MODULES.md`](MODULES.md) | Referencia de módulos y APIs | Avanzado |
| [`API.md`](API.md) | API REST y webhooks | Avanzado |
| [`DEVELOPMENT.md`](DEVELOPMENT.md) | Guía de desarrollo y contribución | Avanzado |

## 🗂️ Estructura de archivos

```
docs/
├── README.md              # Este archivo (índice)
├── ARCHITECTURE.md        # Arquitectura del sistema
├── CONFIGURATION.md       # Configuración detallada
├── MODULES.md            # Documentación de módulos
├── API.md                # API REST
├── DEVELOPMENT.md        # Guía de desarrollo
└── TROUBLESHOOTING.md    # Solución de problemas
```

## 🚀 Inicio rápido

### Para usuarios nuevos

1. **Lea el README principal** ([`../README.md`](../README.md))
   - Visión general del proyecto
   - Instalación básica
   - Uso inicial

2. **Configure el sistema** ([`CONFIGURATION.md`](CONFIGURATION.md))
   - Archivo `stracker.ini`
   - Opciones de base de datos
   - Configuración de red

3. **Solucione problemas** ([`TROUBLESHOOTING.md`](TROUBLESHOOTING.md))
   - Si algo no funciona
   - Diagnóstico de issues
   - Comandos de debug

### Para desarrolladores

1. **Entienda la arquitectura** ([`ARCHITECTURE.md`](ARCHITECTURE.md))
   - Componentes del sistema
   - Flujo de datos
   - Tecnologías utilizadas

2. **Explore los módulos** ([`MODULES.md`](MODULES.md))
   - APIs disponibles
   - Funciones principales
   - Dependencias

3. **Contribuya** ([`DEVELOPMENT.md`](DEVELOPMENT.md))
   - Configuración de desarrollo
   - Convenciones de código
   - Proceso de contribución

## 📋 Temas específicos

### Configuración
- [Archivo de configuración principal](CONFIGURATION.md#archivo-de-configuración-principal)
- [Base de datos](CONFIGURATION.md#configuración-por-base-de-datos)
- [Red y conectividad](CONFIGURATION.md#configuración-de-red)
- [Seguridad](CONFIGURATION.md#configuración-de-seguridad)

### Desarrollo
- [Convenciones de código](DEVELOPMENT.md#convenciones-de-código)
- [Testing](DEVELOPMENT.md#testing)
- [Debugging](DEVELOPMENT.md#debugging-y-debugging)
- [Contribución](DEVELOPMENT.md#contribución)

### API e integración
- [Endpoints REST](API.md#endpoints-principales)
- [Autenticación](API.md#autenticación-y-autorización)
- [Webhooks](API.md#webhooks)
- [Ejemplos de uso](API.md#ejemplos-de-uso)

### Solución de problemas
- [Instalación](TROUBLESHOOTING.md#problemas-de-instalación)
- [Inicio del sistema](TROUBLESHOOTING.md#problemas-de-inicio)
- [Rendimiento](TROUBLESHOOTING.md#problemas-de-rendimiento)
- [Base de datos](TROUBLESHOOTING.md#problemas-de-base-de-datos)

## 🔍 Búsqueda por componente

### Cliente (ptracker.py)
- [Arquitectura cliente](ARCHITECTURE.md#1-cliente-ptrackerpy)
- [Módulos de interfaz](MODULES.md#qtbrowser-py--qtbrowser_common-py)
- [Configuración](CONFIGURATION.md#stracker_config)

### Servidor (ptracker-server.py)
- [Arquitectura servidor](ARCHITECTURE.md#2-servidor-ptracker-serverpy)
- [Protocolo de comunicación](MODULES.md#client_server)
- [Procesamiento de datos](MODULES.md#ac_logparser-py)

### Interfaz web (stracker/)
- [Arquitectura web](ARCHITECTURE.md#3-servidor-web-stracker)
- [API REST](API.md)
- [Templates](MODULES.md#plantillas-http)

### Base de datos
- [Soporte de motores](ARCHITECTURE.md#base-de-datos)
- [Configuración](CONFIGURATION.md#database)
- [Módulos DB](MODULES.md#módulos-de-base-de-datos)

## 🐛 Reportar problemas

Si encuentra errores en la documentación o necesita ayuda:

1. **Verifique la documentación** - Busque en los documentos relevantes
2. **Revise troubleshooting** - [`TROUBLESHOOTING.md`](TROUBLESHOOTING.md)
3. **Reportar issue** - Cree un issue en GitHub con:
   - Documento afectado
   - Sección específica
   - Descripción del problema
   - Sugerencia de mejora

## 📝 Contribuir a la documentación

La documentación es parte integral del proyecto. Para contribuir:

1. **Siga la guía de desarrollo** ([`DEVELOPMENT.md`](DEVELOPMENT.md))
2. **Use formato Markdown** consistente
3. **Incluya ejemplos** cuando sea relevante
4. **Mantenga actualizado** el índice cuando agregue documentos

### Convenciones de documentación

- **Idioma**: Español para documentación principal
- **Formato**: Markdown con tablas y código resaltado
- **Enlaces**: Referencias relativas dentro del proyecto
- **Ejemplos**: Código funcional y comandos verificados

## 🔄 Versiones y actualización

Esta documentación corresponde a **SPTracker v3.5.1**.

Para versiones anteriores, consulte:
- Tags de Git para versiones específicas
- Historial de commits para cambios
- Issues relacionados con documentación

---

**¿No encuentra lo que busca?** Revise el [README principal](../README.md) o cree un issue para solicitar documentación adicional.