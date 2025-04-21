# Guía de Personalización del Memory Bank

Esta guía explica cómo personalizar el Memory Bank para adaptarlo a las necesidades específicas de tu proyecto.

## Personalización del archivo init.json

El archivo `init.json` es la base de toda la estructura del Memory Bank. Puedes personalizarlo de las siguientes maneras:

### 1. Información del Proyecto

La sección `projectInfo` contiene la información básica del proyecto:

```json
"projectInfo": {
  "name": "{PROJECT_NAME}",
  "type": "{PROJECT_TYPE}",
  "platform": "{PLATFORM}",
  "mainLanguage": "{MAIN_LANGUAGE}",
  "frameworks": [],
  "architecture": "{ARCHITECTURE}",
  "designPatterns": []
}
```

Puedes añadir frameworks y patrones de diseño específicos:

```json
"frameworks": ["SwiftUI", "Combine", "SwiftData"],
"designPatterns": ["MVVM", "Repository", "Factory"]
```

### 2. Estructura del Memory Bank

La sección `memoryBankStructure` define todas las secciones del banco de memoria. Cada sección tiene la siguiente estructura:

```json
{
  "id": "section-id",
  "title": "Título de la Sección",
  "priority": 1,
  "requiredFiles": ["file1.md", "file2.md"],
  "subsections": [
    {
      "id": "subsection-id",
      "title": "Título de la Subsección",
      "description": "Descripción de la subsección"
    }
  ],
  "purpose": "Propósito de esta sección"
}
```

Para añadir una nueva sección, simplemente agrega un nuevo objeto al array `sections`.

### 3. Secciones Personalizadas

La sección `customSections` te permite definir secciones específicas para tu proyecto:

```json
"customSections": [
  {
    "id": "custom-section",
    "title": "Mi Sección Personalizada",
    "description": "Descripción de mi sección personalizada",
    "priority": 20,
    "requiredFiles": ["file1.md", "file2.md"]
  }
]
```

### 4. Variables de Plantilla

La sección `templateVariables` permite definir variables que se utilizarán en todo el Memory Bank:

```json
"templateVariables": {
  "companyName": "Mi Empresa",
  "projectYear": "2025",
  "teamMembers": ["Juan", "María", "Pedro"],
  "projectDescription": "Descripción detallada del proyecto",
  "deploymentPlatforms": ["iOS", "Android"],
  "minimumVersions": {
    "iOS": "15.0",
    "Android": "10.0"
  }
}
```

### 5. Directorios a Escanear

La sección `scanDirectories` define qué directorios deben ser incluidos o excluidos del análisis:

```json
"scanDirectories": {
  "include": [
    "src",
    "app",
    "components"
  ],
  "exclude": [
    "node_modules",
    "build",
    ".git"
  ]
}
```

## Ejemplos de Personalización

En la carpeta `examples/` encontrarás ejemplos de personalización para diferentes tipos de proyectos:

- `ios-app-example.json`: Ejemplo para aplicaciones iOS/iPadOS
- `web-app-example.json`: Ejemplo para aplicaciones web
- `backend-example.json`: Ejemplo para servicios backend

Puedes usar estos ejemplos como punto de partida para personalizar tu propio Memory Bank.

## Personalización avanzada

Para una personalización más avanzada, puedes:

1. Modificar las plantillas en `templates/basic-files/`
2. Editar el script de instalación `install.sh`
3. Crear tus propias reglas de mejora en `memoryBankEnhancementRules`

## Recomendaciones

- Mantén la estructura principal intacta para aprovechar todas las funcionalidades
- Añade secciones específicas según el tipo de proyecto
- Usa ID descriptivos para facilitar la referencia a secciones específicas
- Establece prioridades numéricas coherentes para mantener un orden lógico
