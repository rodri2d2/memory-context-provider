# Memory Context Provider

Un inicializador para generar Memory Banks de contexto completo para proyectos de software. Este repositorio proporciona herramientas para crear una estructura de documentación completa y organizada que ayuda a mantener el contexto del proyecto, facilitando la incorporación de nuevos desarrolladores y mejorando la comunicación entre el equipo.

## 🚀 Inicio rápido

```bash
# Instalar en el directorio actual
curl -s https://raw.githubusercontent.com/rodri2d2/memory-context-provider/main/install.sh | bash

# O instalar en un directorio específico
curl -s https://raw.githubusercontent.com/rodri2d2/memory-context-provider/main/install.sh | bash -s mi-proyecto
```

## 🤖 Prompt para agentes IA (Claude, ChatGPT, etc.)

Para inicializar o actualizar tu Memory Bank con un agente IA, copia y pega el siguiente prompt:

```
Quiero que inicialices o actualices el Memory Bank para mi proyecto utilizando el patrón Memory Context Provider. Sigue estos pasos:

1. Verifica si ya existe una carpeta MemoryBank en mi proyecto:
   - Si existe, analiza su contenido para entender la estructura actual
   - Si no existe, prepárate para crear una nueva estructura

2. Descarga el archivo init.json del repositorio:
   - URL: https://raw.githubusercontent.com/rodri2d2/memory-context-provider/main/init.json

3. Personaliza el init.json para este proyecto con los siguientes datos:
   - Nombre del proyecto: [NOMBRE DEL PROYECTO]
   - Tipo: [TIPO DE PROYECTO: iOS, Web, Backend, etc.]
   - Plataforma: [PLATAFORMA: iOS, Web, Android, etc.]
   - Lenguaje principal: [LENGUAJE: Swift, TypeScript, Python, etc.]
   - Arquitectura: [ARQUITECTURA: MVVM, Clean, MVC, etc.]
   - Descripción: [BREVE DESCRIPCIÓN DEL PROYECTO]

4. Genera o actualiza la estructura del Memory Bank:
   - Crea la carpeta "MemoryBank" si no existe
   - Crea o actualiza los archivos maestros en 00_master/
   - Asegúrate de incluir un archivo .mcp-status.json que indique la versión y última actualización

5. Si es posible, analiza mi código fuente para:
   - Identificar componentes principales
   - Detectar patrones de diseño
   - Documentar la estructura de archivos

6. Al finalizar, indícame:
   - Qué archivos has creado o actualizado
   - Cómo puedo utilizar el Memory Bank
   - Qué secciones debo completar manualmente
```

Modifica el prompt según las necesidades específicas de tu proyecto.

## 📋 ¿Qué es un Memory Bank?

Un Memory Bank es una estructura de documentación organizada que proporciona un contexto completo del proyecto, incluyendo:

- Arquitectura y flujo de la aplicación
- Dominios funcionales
- Componentes de UI
- Patrones de comunicación
- Gestión de estado
- Servicios externos
- Guías de implementación
- Convenciones y estándares
- Y mucho más...

## 🔍 Identificación del estado del Memory Bank

Cada Memory Bank incluye un archivo `.mcp-status.json` en su directorio raíz que contiene:

```json
{
  "version": "1.0.0",
  "initialized": true,
  "lastUpdated": "2025-04-21T12:00:00Z",
  "sections": {
    "basic-info": true,
    "app-flow": true,
    "domain-architecture": false,
    ...
  }
}
```

Los agentes pueden usar este archivo para:
- Verificar si el Memory Bank ya ha sido inicializado
- Comprobar qué secciones están completas y cuáles faltan
- Conocer la fecha de la última actualización

## 🛠️ Estructura del repositorio

- `init.json`: Archivo principal que define la estructura completa del Memory Bank
- `install.sh`: Script de instalación que configura el Memory Bank en tu proyecto
- `examples/`: Ejemplos de configuración para diferentes tipos de proyectos
- `templates/`: Plantillas de archivos básicos para iniciar el Memory Bank

## 📚 Cómo usar el Memory Bank

Una vez instalado, encontrarás una carpeta `MemoryBank` en tu proyecto con la siguiente estructura:

```
/MemoryBank
  ├── 00_master/
  │   ├── 00_master_index.md
  │   ├── 00_file_registry.md
  │   └── 00_update_registry.sh
  ├── 01_basic_info/
  ├── 02_app_flow/
  └── ...
```

1. Comienza por revisar `00_master/00_master_index.md` para entender la estructura
2. Consulta la sección relevante para lo que necesites
3. Para actualizar el registro de archivos, ejecuta `./00_master/00_update_registry.sh`

## 📝 Personalización

Puedes personalizar la estructura del Memory Bank editando el archivo `init.json`. Consulta la [documentación](./docs/customization.md) para más detalles.

## 🤝 Contribución

Las contribuciones son bienvenidas. Por favor, consulta [CONTRIBUTING.md](./CONTRIBUTING.md) para más detalles.

## 📄 Licencia

Este proyecto está licenciado bajo la Licencia MIT - vea el archivo [LICENSE](./LICENSE) para más detalles.

## 📞 Contacto

- Twitter: [@rodri2d2](https://twitter.com/rodri2d2)
- GitHub: [rodri2d2](https://github.com/rodri2d2)
