# Índice Maestro - {PROJECT_NAME}

## Información General
- **Proyecto**: {PROJECT_NAME}
- **Tipo**: {PROJECT_TYPE}
- **Plataforma**: {PLATFORM}
- **Lenguaje Principal**: {MAIN_LANGUAGE}
- **Arquitectura**: {ARCHITECTURE}
- **Empresa**: {COMPANY_NAME}
- **Año**: {PROJECT_YEAR}

## Secciones

### 1. Información Básica del Proyecto
- [Descripción General](../01_basic_info/project_overview.md)
- [Tecnologías](../01_basic_info/technologies.md)
- [Arquitectura](../01_basic_info/architecture.md)

### 2. Flujo de la Aplicación
- [Flujo Principal](../02_app_flow/main_flow.md)
- [Puntos de Entrada](../02_app_flow/entry_points.md)
- [Jornadas de Usuario](../02_app_flow/user_journeys.md)

### 3. Arquitectura por Dominios
- [Dominio de Autenticación](../03_domain_architecture/auth_domain.md)
- [Dominio de Usuario](../03_domain_architecture/user_domain.md)
- [Otros Dominios...](../03_domain_architecture/)

### 4. Componentes de UI
- [Vistas Principales](../04_ui_components/main_views.md)
- [Componentes Reutilizables](../04_ui_components/reusable_components.md)
- [Navegación](../04_ui_components/navigation.md)

### 5. Patrones de Comunicación
- [Flujo de Datos](../05_communication_patterns/data_flow.md)
- [Inyección de Dependencias](../05_communication_patterns/dependency_injection.md)
- [Manejo de Eventos](../05_communication_patterns/event_handling.md)

### 6. Relaciones entre Clases
- [Gráfico de Dependencias](../06_class_relationships/dependencies_graph.md)
- [Mapa de Llamadas](../06_class_relationships/call_map.md)
- [Diagrama de Inyección](../06_class_relationships/injection_diagram.md)

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
   ```
   ./00_master/00_update_registry.sh
   ```
