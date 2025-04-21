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
