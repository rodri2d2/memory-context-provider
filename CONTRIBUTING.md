# Guía de Contribución

¡Gracias por tu interés en contribuir al proyecto Memory Context Provider! Esta guía te ayudará a entender cómo puedes colaborar con nosotros.

## Código de Conducta

Al participar en este proyecto, te comprometes a mantener un ambiente respetuoso y colaborativo. Esperamos que todos los colaboradores se adhieran a los siguientes principios:

- Ser respetuoso y considerado con los demás
- Aceptar críticas constructivas
- Enfocarse en lo que es mejor para la comunidad
- Mostrar empatía hacia otros miembros de la comunidad

## Cómo Contribuir

Existen varias maneras de contribuir a este proyecto:

### 1. Reportar Problemas (Issues)

Si encuentras un problema o tienes una sugerencia, por favor crea un issue siguiendo estos pasos:

1. Revisa si ya existe un issue similar
2. Utiliza la plantilla de issue para proporcionar toda la información necesaria
3. Incluye capturas de pantalla si es relevante
4. Etiqueta el issue adecuadamente (bug, feature, documentation, etc.)

### 2. Enviar Pull Requests

Para contribuir con código:

1. Crea un fork del repositorio
2. Crea una rama para tu contribución (`git checkout -b feature/nueva-caracteristica`)
3. Realiza tus cambios
4. Asegúrate de seguir las convenciones de código y documentación
5. Realiza pruebas para verificar que tu contribución funciona correctamente
6. Haz commit de tus cambios (`git commit -m 'Añadir nueva característica'`)
7. Envía tu rama al repositorio (`git push origin feature/nueva-caracteristica`)
8. Crea un Pull Request desde GitHub

### 3. Mejorar la Documentación

La documentación es crucial para este proyecto. Puedes contribuir:

- Corrigiendo errores o imprecisiones
- Añadiendo ejemplos o casos de uso
- Mejorando la claridad de las explicaciones existentes
- Traduciendo la documentación a otros idiomas

### 4. Crear Plantillas Personalizadas

Puedes contribuir con nuevas plantillas para diferentes tipos de proyectos:

1. Crea una personalización del archivo `init.json`
2. Documenta las características específicas de tu plantilla
3. Agrégala al directorio `examples/`

## Estructura del Proyecto

Para contribuir eficazmente, es útil entender la estructura del proyecto:

```
/
├── init.json            # Archivo principal de configuración
├── install.sh           # Script de instalación
├── README.md            # Documentación principal
├── CONTRIBUTING.md      # Esta guía
├── docs/                # Documentación detallada
│   └── customization.md # Guía de personalización
├── examples/            # Ejemplos para diferentes tipos de proyectos
│   ├── ios-app-example.json
│   ├── web-app-example.json
│   └── backend-example.json
└── templates/           # Plantillas básicas
    └── basic-files/     # Archivos iniciales para la instalación
        ├── 00_master_index.md
        ├── 00_file_registry.md
        └── 00_update_registry.sh
```

## Convenciones de Código y Estilo

- Usa indentación de 2 espacios para los archivos JSON
- Sigue la estructura existente para mantener consistencia
- Documenta claramente cualquier nueva funcionalidad
- Mantén los nombres de archivo descriptivos y en inglés
- Usa markdown para toda la documentación

## Proceso de Revisión

Una vez que hayas enviado un Pull Request:

1. El mantenedor revisará tus cambios
2. Puede que te pidan realizar ajustes
3. Una vez aprobado, tus cambios se fusionarán con la rama principal

## Reconocimiento

¡Las contribuciones de cualquier tipo son valoradas y reconocidas! Los contribuyentes serán mencionados en el archivo README.md.

## Preguntas

Si tienes alguna pregunta o necesitas ayuda, puedes:

- Abrir un issue con la etiqueta "question"
- Contactar directamente a los mantenedores

¡Gracias por contribuir al proyecto Memory Context Provider!
