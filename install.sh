#!/bin/bash

# Memory Context Provider Initializer
# Script para instalar el archivo init.json y crear la estructura básica

# Colores para mensajes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Memory Context Provider - Instalador${NC}"
echo "--------------------------------------"

# Directorio del proyecto
PROJECT_DIR="."
if [ ! -z "$1" ]; then
  PROJECT_DIR="$1"
  # Crear directorio si no existe
  mkdir -p "$PROJECT_DIR"
fi

# Descargar el archivo init.json
echo -e "${BLUE}Descargando init.json...${NC}"
curl -s "https://raw.githubusercontent.com/rodri2d2/memory-context-provider/main/init.json" -o "$PROJECT_DIR/init.json"

if [ ! -f "$PROJECT_DIR/init.json" ]; then
  echo -e "${RED}Error: No se pudo descargar init.json${NC}"
  exit 1
fi

# Preguntar por la información básica del proyecto
echo -e "${BLUE}Configurando el proyecto...${NC}"
read -p "Nombre del proyecto: " PROJECT_NAME
read -p "Tipo de proyecto (iOS, Web, Backend): " PROJECT_TYPE
read -p "Plataforma principal: " PLATFORM
read -p "Lenguaje principal: " MAIN_LANGUAGE
read -p "Arquitectura (MVVM, Clean, etc): " ARCHITECTURE
read -p "Descripción breve: " PROJECT_DESCRIPTION
read -p "Empresa/Organización: " COMPANY_NAME
read -p "Año: " PROJECT_YEAR

# Crear archivo con el nombre reemplazado para evitar problemas con sed
cat "$PROJECT_DIR/init.json" | \
  sed "s/{PROJECT_NAME}/$PROJECT_NAME/g" | \
  sed "s/{PROJECT_TYPE}/$PROJECT_TYPE/g" | \
  sed "s/{PLATFORM}/$PLATFORM/g" | \
  sed "s/{MAIN_LANGUAGE}/$MAIN_LANGUAGE/g" | \
  sed "s/{ARCHITECTURE}/$ARCHITECTURE/g" | \
  sed "s/{PROJECT_DESCRIPTION}/$PROJECT_DESCRIPTION/g" | \
  sed "s/{COMPANY_NAME}/$COMPANY_NAME/g" | \
  sed "s/{PROJECT_YEAR}/$PROJECT_YEAR/g" > "$PROJECT_DIR/init_custom.json"

# Reemplazar el archivo original
mv "$PROJECT_DIR/init_custom.json" "$PROJECT_DIR/init.json"

# Crear estructura básica de directorios para MemoryBank
echo -e "${BLUE}Creando estructura básica...${NC}"
mkdir -p "$PROJECT_DIR/MemoryBank/00_master"
mkdir -p "$PROJECT_DIR/MemoryBank/01_basic_info"
mkdir -p "$PROJECT_DIR/MemoryBank/02_app_flow"
mkdir -p "$PROJECT_DIR/MemoryBank/06_class_relationships"

# Crear archivo maestro de índice
cat > "$PROJECT_DIR/MemoryBank/00_master/00_master_index.md" << EOF
# Índice Maestro - $PROJECT_NAME

## Información General
- **Proyecto**: $PROJECT_NAME
- **Tipo**: $PROJECT_TYPE
- **Plataforma**: $PLATFORM
- **Lenguaje Principal**: $MAIN_LANGUAGE
- **Arquitectura**: $ARCHITECTURE
- **Empresa**: $COMPANY_NAME
- **Año**: $PROJECT_YEAR

## Secciones

### 1. Información Básica del Proyecto
- [Descripción General](../01_basic_info/project_overview.md)
- [Tecnologías](../01_basic_info/technologies.md)
- [Arquitectura](../01_basic_info/architecture.md)

### 2. Flujo de la Aplicación
- [Flujo Principal](../02_app_flow/main_flow.md)
- [Puntos de Entrada](../02_app_flow/entry_points.md)
- [Jornadas de Usuario](../02_app_flow/user_journeys.md)

<!-- Agregar más secciones según se vayan creando -->

## Archivos Importantes
- [Registro de Archivos](00_file_registry.md)
- [Script de Actualización](00_update_registry.sh)

## Guías Rápidas
- [Cómo actualizar este índice](#cómo-actualizar-este-índice)
- [Cómo añadir nueva documentación](#cómo-añadir-nueva-documentación)

---

## Cómo actualizar este índice

1. Abra este archivo (00_master_index.md)
2. Añada nuevas secciones o enlaces a documentos según sea necesario
3. Mantenga la estructura y el formato consistentes

## Cómo añadir nueva documentación

1. Identifique la sección adecuada para su documento
2. Cree el archivo en la carpeta correspondiente
3. Añada un enlace al documento en este índice maestro
4. Ejecute el script de actualización para registrar el archivo:
   \`\`\`
   ./00_master/00_update_registry.sh
   \`\`\`
EOF

# Crear registro de archivos
cat > "$PROJECT_DIR/MemoryBank/00_master/00_file_registry.md" << EOF
# Registro de Archivos - $PROJECT_NAME

Este documento mantiene un registro actualizado de todos los archivos en el Memory Bank.

## Archivos Maestros
- [00_master_index.md](00_master_index.md) - Índice maestro del proyecto
- [00_file_registry.md](00_file_registry.md) - Este archivo de registro
- [00_update_registry.sh](00_update_registry.sh) - Script para actualizar automáticamente este registro

## Secciones
### 01_basic_info
*Archivos pendientes de crear*

### 02_app_flow
*Archivos pendientes de crear*

## Última actualización
$(date)

EOF

# Crear script de actualización de registro
cat > "$PROJECT_DIR/MemoryBank/00_master/00_update_registry.sh" << EOF
#!/bin/bash

# Script para actualizar automáticamente el registro de archivos
# Versión 1.0.0

# Colores para mensajes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "\${BLUE}Actualizando registro de archivos...${NC}"

# Directorio base
BASE_DIR=".."
REGISTRY_FILE="00_file_registry.md"
PROJECT_NAME="$PROJECT_NAME"

# Crear encabezado del archivo
cat > "\${REGISTRY_FILE}" << HEADER
# Registro de Archivos - \${PROJECT_NAME}

Este documento mantiene un registro actualizado de todos los archivos en el Memory Bank.

## Archivos Maestros
- [00_master_index.md](00_master_index.md) - Índice maestro del proyecto
- [00_file_registry.md](00_file_registry.md) - Este archivo de registro
- [00_update_registry.sh](00_update_registry.sh) - Script para actualizar automáticamente este registro

## Secciones
HEADER

# Obtener todas las carpetas (excluyendo la actual y ocultas)
for dir in \$(find \${BASE_DIR} -type d | sort | grep -v "^\${BASE_DIR}/\." | grep -v "^\."); do
  # Obtener nombre de directorio relativo
  rel_dir=\$(echo \${dir} | sed "s|\${BASE_DIR}/||")
  
  # Saltar el directorio actual
  if [ "\${rel_dir}" = "00_master" ]; then
    continue
  fi
  
  # Añadir encabezado de sección
  echo "### \${rel_dir}" >> "\${REGISTRY_FILE}"
  
  # Contar archivos en la carpeta
  file_count=\$(find "\${dir}" -type f | wc -l)
  
  if [ \${file_count} -eq 0 ]; then
    echo "*Archivos pendientes de crear*" >> "\${REGISTRY_FILE}"
  else
    # Listar archivos en la carpeta
    for file in \$(find "\${dir}" -type f -name "*.md" | sort); do
      filename=\$(basename "\${file}")
      # Obtener el título del archivo (primera línea que empieza con #)
      title=\$(grep -m 1 "^# " "\${file}" | sed 's/^# //')
      if [ -z "\${title}" ]; then
        title="\${filename}"
      fi
      echo "- [\${filename}](\${dir}/\${filename}) - \${title}" >> "\${REGISTRY_FILE}"
    done
  fi
  
  echo "" >> "\${REGISTRY_FILE}"
done

# Añadir fecha de última actualización
echo "## Última actualización" >> "\${REGISTRY_FILE}"
echo "\$(date)" >> "\${REGISTRY_FILE}"

echo -e "\${GREEN}Registro de archivos actualizado correctamente.${NC}"
EOF

# Hacer ejecutable el script de actualización
chmod +x "$PROJECT_DIR/MemoryBank/00_master/00_update_registry.sh"

# Crear README en la raíz del MemoryBank
cat > "$PROJECT_DIR/MemoryBank/README.md" << EOF
# Memory Bank para $PROJECT_NAME

Este directorio contiene la documentación estructurada completa del proyecto, siguiendo el patrón del Memory Context Provider.

## Estructura

- **00_master**: Archivos maestros e índices
- **01_basic_info**: Información básica del proyecto
- **02_app_flow**: Flujo de la aplicación
- **06_class_relationships**: Relaciones y dependencias entre clases
- ...

## Cómo usar este banco de memoria

1. Comienza por revisar el archivo \`00_master/00_master_index.md\` para entender la estructura.
2. Consulta la sección relevante para lo que necesites.
3. Para actualizar el registro de archivos, ejecuta \`./00_master/00_update_registry.sh\`.

## Propósito

Este banco de memoria tiene como objetivo proporcionar contexto completo del proyecto para facilitar:
- La incorporación de nuevos desarrolladores
- La comprensión de la arquitectura y patrones
- La documentación del código y decisiones de diseño

## Proyecto

- **Nombre**: $PROJECT_NAME
- **Tipo**: $PROJECT_TYPE
- **Plataforma**: $PLATFORM
- **Lenguaje**: $MAIN_LANGUAGE
- **Descripción**: $PROJECT_DESCRIPTION
EOF

# Crear archivos básicos de información
mkdir -p "$PROJECT_DIR/MemoryBank/01_basic_info"
cat > "$PROJECT_DIR/MemoryBank/01_basic_info/project_overview.md" << EOF
# Descripción General del Proyecto

## $PROJECT_NAME

**Descripción**: $PROJECT_DESCRIPTION

*Este documento proporciona una visión general del proyecto, sus objetivos y alcance.*

## Objetivos

*[Añadir objetivos principales del proyecto]*

## Alcance

*[Definir el alcance del proyecto]*

## Características Principales

*[Listar las características principales]*

## Usuarios Objetivo

*[Describir los usuarios objetivo]*

## Estado Actual

*[Indicar el estado actual del proyecto]*
EOF

cat > "$PROJECT_DIR/MemoryBank/01_basic_info/technologies.md" << EOF
# Tecnologías Utilizadas

## Lenguajes
- $MAIN_LANGUAGE
- *[Añadir otros lenguajes si aplica]*

## Frameworks y Bibliotecas
- *[Listar frameworks utilizados]*

## Herramientas de Desarrollo
- *[Enumerar herramientas de desarrollo]*

## Entornos
- *[Detallar entornos: Desarrollo, Pruebas, Producción, etc.]*

## Servicios Externos
- *[Describir servicios externos integrados]*
EOF

cat > "$PROJECT_DIR/MemoryBank/01_basic_info/architecture.md" << EOF
# Arquitectura del Proyecto

## Patrón Arquitectónico: $ARCHITECTURE

*Este documento describe la arquitectura general del proyecto y sus componentes principales.*

## Diagrama de Arquitectura

*[Insertar diagrama de arquitectura aquí]*

## Capas de la Aplicación

*[Describir las diferentes capas de la aplicación]*

## Componentes Principales

*[Enumerar y describir los componentes principales]*

## Flujo de Datos

*[Explicar cómo fluyen los datos a través del sistema]*

## Patrones de Diseño Utilizados

*[Listar patrones de diseño implementados]*
EOF

echo -e "${GREEN}¡Instalación completada correctamente!${NC}"
echo -e "Archivo init.json personalizado y estructura básica creada en: ${BLUE}$PROJECT_DIR/MemoryBank${NC}"
echo -e "Puedes comenzar revisando: ${BLUE}$PROJECT_DIR/MemoryBank/README.md${NC}"
