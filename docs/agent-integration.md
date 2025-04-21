# Guía de Integración para Agentes IA

Esta guía explica cómo los agentes de IA como Claude pueden interactuar con el Memory Bank para proporcionar un contexto completo del proyecto.

## Identificando el Estado del Memory Bank

Cada proyecto que utiliza Memory Bank contiene un archivo `.mcp-status.json` en la raíz del directorio MemoryBank. Este archivo es crucial para que los agentes entiendan el estado actual del proyecto.

```json
{
  "version": "1.0.0",
  "initialized": true,
  "lastUpdated": "2025-04-21T15:00:00Z",
  "project": {
    "name": "SimpleAPI",
    "type": "Backend",
    "platform": "NodeJS",
    "language": "TypeScript",
    "architecture": "MVC"
  },
  "sections": {
    "basic-info": true,
    "app-flow": false,
    ...
  },
  "customSections": {},
  "fileCount": 4,
  "lastAnalysis": "2025-04-21T15:00:00Z"
}
```

### Información importante en este archivo:

- **initialized**: Indica si el Memory Bank ya ha sido inicializado
- **project**: Contiene la información básica del proyecto
- **sections**: Indica qué secciones ya están documentadas (true) y cuáles faltan por documentar (false)
- **customSections**: Lista las secciones personalizadas específicas del proyecto
- **lastUpdated**: Fecha de la última actualización del Memory Bank
- **lastAnalysis**: Fecha del último análisis del código del proyecto

## Estrategia de Actuación para Agentes

Los agentes deben seguir esta estrategia cuando interactúan con un proyecto que utiliza Memory Bank:

### 1. Verificación de Estado

```javascript
async function checkMemoryBankStatus(projectPath) {
  const statusFilePath = `${projectPath}/MemoryBank/.mcp-status.json`;
  
  try {
    // Verificar si existe el archivo de estado
    const statusExists = await fileExists(statusFilePath);
    
    if (!statusExists) {
      // Memory Bank no inicializado o no presente
      return {
        initialized: false,
        message: "Memory Bank no detectado. Se recomienda inicializar."
      };
    }
    
    // Leer el archivo de estado
    const statusData = await readJsonFile(statusFilePath);
    
    // Analizar qué secciones faltan
    const missingSections = Object.entries(statusData.sections)
      .filter(([_, completed]) => !completed)
      .map(([section, _]) => section);
    
    return {
      initialized: true,
      project: statusData.project,
      missingSections,
      lastUpdated: statusData.lastUpdated
    };
  } catch (error) {
    // Error al analizar el estado
    return {
      error: true,
      message: "Error al analizar el estado del Memory Bank"
    };
  }
}
```

### 2. Algoritmo de Decisión

1. **Si el Memory Bank no existe**:
   - Recomendar inicializar el Memory Bank
   - Ofrecer descargar el init.json del repositorio central
   - Solicitar información básica del proyecto

2. **Si el Memory Bank existe pero está incompleto**:
   - Identificar secciones faltantes
   - Priorizar la creación de las secciones más importantes
   - Ofrecer completar secciones específicas

3. **Si el Memory Bank está completo pero desactualizado**:
   - Analizar el código actual del proyecto
   - Identificar discrepancias entre la documentación y el código
   - Ofrecer actualizar las secciones desactualizadas

### 3. Actualización del Archivo de Estado

Después de cualquier modificación al Memory Bank, el agente debe actualizar el archivo `.mcp-status.json`:

```javascript
async function updateMemoryBankStatus(projectPath, updates) {
  const statusFilePath = `${projectPath}/MemoryBank/.mcp-status.json`;
  
  try {
    // Leer estado actual
    const currentStatus = await readJsonFile(statusFilePath);
    
    // Actualizar fecha
    const now = new Date().toISOString();
    currentStatus.lastUpdated = now;
    
    // Actualizar secciones completadas
    if (updates.completedSections) {
      updates.completedSections.forEach(section => {
        currentStatus.sections[section] = true;
      });
    }
    
    // Actualizar contador de archivos
    if (updates.newFileCount) {
      currentStatus.fileCount = updates.newFileCount;
    }
    
    // Si se realizó análisis de código
    if (updates.analyzed) {
      currentStatus.lastAnalysis = now;
    }
    
    // Guardar cambios
    await writeJsonFile(statusFilePath, currentStatus);
    
    return {
      success: true,
      message: "Estado del Memory Bank actualizado"
    };
  } catch (error) {
    return {
      error: true,
      message: "Error al actualizar el estado del Memory Bank"
    };
  }
}
```

## Interacciones comunes con usuarios

### Usuario sin Memory Bank inicializado

**Agente**: "Observo que este proyecto no tiene un Memory Bank inicializado. ¿Te gustaría que cree uno para proporcionar documentación estructurada del proyecto?"

**Acción**: Si el usuario acepta, el agente debe descargar el init.json, solicitar información básica y generar la estructura inicial.

### Usuario con Memory Bank parcial

**Agente**: "He detectado que tu Memory Bank tiene las secciones de información básica y flujo de aplicación, pero faltan documentos sobre la arquitectura de dominio. ¿Quieres que complete esa sección basándome en el código existente?"

**Acción**: Si el usuario acepta, el agente debe analizar el código del proyecto y generar la documentación faltante.

### Usuario con Memory Bank desactualizado

**Agente**: "Tu Memory Bank fue actualizado por última vez hace 3 meses. Desde entonces, veo que se han añadido 5 nuevos componentes al proyecto. ¿Quieres que actualice la documentación para reflejar estos cambios?"

**Acción**: El agente debe identificar las discrepancias y actualizar los documentos relevantes.

## Buenas prácticas para agentes

1. **Respetar el trabajo existente**: No sobrescribir secciones ya completadas sin permiso explícito
2. **Mantener la coherencia**: Seguir el estilo y formato de la documentación existente
3. **Ser transparente**: Informar claramente qué cambios se han realizado
4. **Priorizar lo importante**: Enfocarse primero en las secciones más críticas para la comprensión del proyecto
5. **Actualizar el estado**: Siempre actualizar el archivo `.mcp-status.json` después de realizar cambios

## Comandos comunes para gestionar el Memory Bank

```bash
# Ver secciones completas e incompletas
jq '.sections' MemoryBank/.mcp-status.json

# Actualizar registro de archivos
./MemoryBank/00_master/00_update_registry.sh

# Ver última actualización
jq '.lastUpdated' MemoryBank/.mcp-status.json
```

## Análisis de código automático

Los agentes pueden realizar análisis de código para generar o actualizar documentación:

1. **Análisis estructural**: Identificar componentes, clases, funciones y sus relaciones
2. **Análisis de patrones**: Detectar patrones de diseño utilizados
3. **Análisis de flujo**: Mapear el flujo de datos y control en la aplicación
4. **Análisis de dependencias**: Identificar dependencias externas e internas

Este análisis debe documentarse en las secciones correspondientes y actualizarse en el archivo de estado.
