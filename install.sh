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

Este documento mantiene un registro de todos los archivos en el proyecto.
Se actualiza automáticamente cuando se ejecuta el script \`00_update_registry.sh\`.

## Última actualización: $(date +"%Y-%m-%d %H:%M:%S")

## Estructura de directorios

\`\`\`
MemoryBank/
├── 00_master/
│   ├── 00_master_index.md
│   ├── 00_file_registry.md
│   └── 00_update_registry.sh
├── 01_basic_info/
├── 02_app_flow/
└── 06_class_relationships/
\`\`\`

## Archivos por sección

### 00_master
- [00_master_index.md](00_master_index.md) - Índice maestro que organiza toda la documentación
- [00_file_registry.md](00_file_registry.md) - Este archivo, registro completo de archivos
- [00_update_registry.sh](00_update_registry.sh) - Script para actualizar automáticamente este registro

### 01_basic_info
*Pendiente de creación*

### 02_app_flow
*Pendiente de creación*

### 06_class_relationships
*Pendiente de creación*

## Estadísticas
- Total de archivos: 3
- Total de directorios: 4
- Última actualización: $(date +"%Y-%m-%d %H:%M:%S")
EOF

# Crear script de actualización
cat > "$PROJECT_DIR/MemoryBank/00_master/00_update_registry.sh" << 'EOF'
#!/bin/bash

# Script para actualizar automáticamente el registro de archivos
# Ubicación: MemoryBank/00_master/00_update_registry.sh

# Directorio base de MemoryBank
base_dir=$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)")
registry_file="$base_dir/00_master/00_file_registry.md"
project_name=$(grep "^# Índice Maestro -" "$base_dir/00_master/00_master_index.md" | sed 's/# Índice Maestro - //')

# Colores para salida
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Actualizando registro de archivos...${NC}"

# Crear encabezado del archivo
cat > "$registry_file" << EOL
# Registro de Archivos - $project_name

Este documento mantiene un registro de todos los archivos en el proyecto.
Se actualiza automáticamente cuando se ejecuta el script \`00_update_registry.sh\`.

## Última actualización: $(date +"%Y-%m-%d %H:%M:%S")

## Estructura de directorios

\`\`\`
EOL

# Generar estructura de directorios
find "$base_dir" -type d | sort | awk -v base="$base_dir" '{gsub(base, "MemoryBank"); print $0}' | sed 's/^//' >> "$registry_file"

# Cerrar bloque de código
echo -e "\`\`\`\n" >> "$registry_file"

# Añadir secciones por directorio
echo "## Archivos por sección" >> "$registry_file"

# Obtener todos los directorios
dirs=$(find "$base_dir" -type d | sort)

# Para cada directorio, listar los archivos
for dir in $dirs; do
    # Nombre relativo del directorio
    rel_dir=$(echo "$dir" | sed "s|$base_dir|MemoryBank|")
    section_name=$(basename "$dir")
    
    echo -e "\n### $section_name" >> "$registry_file"
    
    # Verificar si hay archivos en el directorio
    if [ -z "$(ls -A "$dir" | grep -v '^\.')" ]; then
        echo "*Pendiente de creación*" >> "$registry_file"
        continue
    fi
    
    # Listar archivos
    for file in $(find "$dir" -maxdepth 1 -type f | sort); do
        filename=$(basename "$file")
        if [[ "$filename" == .* ]]; then
            continue  # Saltar archivos ocultos
        fi
        
        # Extraer título del archivo markdown si existe
        if [[ "$file" == *.md ]]; then
            title=$(head -n 1 "$file" | sed 's/^# //')
            echo "- [$filename](${file#$base_dir/00_master/}) - $title" >> "$registry_file"
        else
            echo "- [$filename](${file#$base_dir/00_master/})" >> "$registry_file"
        fi
    done
done

# Añadir estadísticas
total_files=$(find "$base_dir" -type f | grep -v '^\.' | wc -l)
total_dirs=$(find "$base_dir" -type d | grep -v '^\.' | wc -l)

echo -e "\n## Estadísticas" >> "$registry_file"
echo "- Total de archivos: $total_files" >> "$registry_file"
echo "- Total de directorios: $total_dirs" >> "$registry_file"
echo "- Última actualización: $(date +"%Y-%m-%d %H:%M:%S")" >> "$registry_file"

# Hacer ejecutable el script
chmod +x "$base_dir/00_master/00_update_registry.sh"

echo -e "${GREEN}Registro de archivos actualizado correctamente.${NC}"
EOF

# Hacer ejecutable el script
chmod +x "$PROJECT_DIR/MemoryBank/00_master/00_update_registry.sh"

# Crear archivos básicos de información del proyecto
cat > "$PROJECT_DIR/MemoryBank/01_basic_info/project_overview.md" << EOF
# Descripción General - $PROJECT_NAME

## Resumen

$PROJECT_DESCRIPTION

## Información Básica

- **Nombre del Proyecto**: $PROJECT_NAME
- **Tipo**: $PROJECT_TYPE
- **Plataforma**: $PLATFORM
- **Lenguaje Principal**: $MAIN_LANGUAGE
- **Arquitectura**: $ARCHITECTURE
- **Organización**: $COMPANY_NAME
- **Año**: $PROJECT_YEAR

## Propósito

[Describir aquí el propósito principal del proyecto]

## Objetivos

- [Objetivo 1]
- [Objetivo 2]
- [Objetivo 3]

## Usuarios Objetivo

- [Perfil de usuario 1]
- [Perfil de usuario 2]

## Características Principales

- [Característica 1]
- [Característica 2]
- [Característica 3]

## Enlaces Importantes

- [Repositorio del Proyecto](#)
- [Sistema de Gestión de Proyectos](#)
- [Documentación Adicional](#)
EOF

# Crear archivo README en la raíz del MemoryBank
cat > "$PROJECT_DIR/MemoryBank/README.md" << EOF
# Memory Bank para $PROJECT_NAME

Este directorio contiene la documentación estructurada completa del proyecto, siguiendo el patrón del Memory Context Provider.

## Estructura

- **00_master**: Archivos maestros e índices
- **01_basic_info**: Información básica del proyecto
- **02_app_flow**: Flujo de la aplicación
- **06_class_relationships**: Relaciones entre clases y componentes

## Cómo usar este banco de memoria

1. Comienza por revisar el archivo \`00_master/00_master_index.md\` para entender la estructura.
2. Consulta la sección relevante para lo que necesites.
3. Para actualizar el registro de archivos, ejecuta \`./00_master/00_update_registry.sh\`.

## Propósito

Este banco de memoria tiene como objetivo proporcionar contexto completo del proyecto para facilitar:
- La incorporación de nuevos desarrolladores
- La comprensión de la arquitectura y patrones
- La documentación del código y decisiones de diseño
EOF

echo -e "${GREEN}¡Instalación completada correctamente!${NC}"
echo -e "Archivo init.json personalizado y estructura básica creada en: ${BLUE}$PROJECT_DIR/MemoryBank${NC}"
echo -e "Puedes comenzar revisando: ${BLUE}$PROJECT_DIR/MemoryBank/README.md${NC}"
echo -e "Y el índice maestro: ${BLUE}$PROJECT_DIR/MemoryBank/00_master/00_master_index.md${NC}"
