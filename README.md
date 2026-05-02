# MyHomework: Sistema de gestión y recordatorios académicos

## Descripción
MyHomework es una aplicación móvil diseñada para ayudar a estudiantes a organizar sus tareas académicas de manera eficiente.

La aplicación permite registrar actividades con fechas límite, descripciones y niveles de prioridad, además de generar recordatorios automáticos para evitar olvidos y mejorar la planificación del tiempo.

---

## Funcionalidades implementadas

- Visualización de tareas en pantalla principal
- Navegación a detalle de cada tarea
- Creación de nuevas tareas (formulario)
- Visualización de tareas por fecha mediante calendario
- Navegación mediante menú lateral (Drawer)
- Pantalla de inicio (Splash Screen)
- Pantallas adicionales: Perfil, Ayuda y Sobre la aplicación

---

## Instrucciones de uso
1. Al iniciar la aplicación, se muestra la pantalla principal con una lista de tareas.
2. Cada tarea se presenta en formato de tarjeta con título, asignatura y fecha.
3. Al presionar una tarea, se accede a la pantalla de detalle con información completa.
4. El botón "+" permite acceder a la pantalla de creación de nuevas tareas.
5. También es posible visualizar tareas por fecha utilizando el calendario integrado.
6. Actualmente, las funcionalidades utilizan datos de ejemplo y no se almacenan de forma persistente.

---

## Estado actual del proyecto

El proyecto actualmente cuenta con una implementación funcional del flujo principal de la aplicación, incluyendo:

- Pantalla de inicio (Splash Screen)
- Pantalla principal con listado de tareas
- Calendario interactivo con visualización de tareas por fecha
- Pantalla de creación de tareas
- Pantalla de detalle de tareas
- Navegación completa mediante Drawer
- Uso de Theme global para consistencia visual

Las tareas aún no se almacenan de forma persistente y se utilizan datos simulados.

---

## Arquitectura del proyecto

El proyecto sigue una estructura modular basada en Flutter:

- **screens/**: contiene todas las pantallas de la aplicación
- **widgets/**: componentes reutilizables como tarjetas de tareas y menú lateral
- **main.dart**: punto de entrada con configuración de rutas y Theme global

Se utiliza el patrón de navegación basado en rutas (`Navigator`) y paso de parámetros entre pantallas.

---

## Características del dispositivo móvil
La aplicación aprovecha funcionalidades propias de dispositivos móviles como:

- Notificaciones para recordatorios de tareas
- Acceso rápido desde cualquier lugar
- Interfaz táctil intuitiva
- Posibilidad de almacenamiento local de datos

---

## Requerimientos

### Historias de usuario

- Como estudiante, quiero agregar tareas para organizar mis actividades.
- Como estudiante, quiero asignar fechas límite para no olvidar entregas.
- Como estudiante, quiero recibir recordatorios antes de una tarea.
- Como estudiante, quiero visualizar todas mis tareas en una lista.

---

### Requerimientos funcionales

- El sistema permite crear tareas
- El sistema permite visualizar tareas
- El sistema permite ver el detalle de una tarea
- El sistema permite visualizar tareas en un calendario
- El sistema permite navegar entre distintas pantallas mediante un menú lateral

---

### Requerimientos no funcionales

- La aplicación debe ser rápida y responsiva
- Debe ser fácil de usar
- Debe funcionar en dispositivos Android
- Debe tener bajo consumo de recursos

---

## Limitaciones actuales

- No existe persistencia de datos (las tareas no se guardan)
- No se implementan notificaciones reales
- No se pueden editar ni eliminar tareas

---

## Tecnologías utilizadas

- Flutter
- Dart
- Material Design
- TableCalendar (para visualización de calendario)

---

## Diagrama de flujo

```mermaid
flowchart TD

    A[Inicio - Splash Screen] --> B[Home]

    B --> C[Ver lista de tareas]
    B --> D[Abrir calendario]

    C --> E[Seleccionar tarea]
    E --> F[Ver detalle de tarea]

    D --> G[Seleccionar día]
    G --> H[Ver tareas del día]
    H --> F

    B --> I[Botón crear tarea]
    I --> J[Formulario de creación]
    J --> B

    B --> K[Menú lateral (Drawer)]

    K --> L[Perfil]
    K --> M[Sobre la app]
    K --> N[Ayuda]

    L --> B
    M --> B
    N --> B
```
## Investigacion
[RESEARCH.md](RESEARCH.md)
