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
1. Al iniciar la aplicación, se muestra una pantalla de inicio (Splash Screen).
2. Luego se accede a la pantalla principal con la lista de tareas.
3. Cada tarea se presenta en formato de tarjeta con título, asignatura y fecha.
4. Al presionar una tarea, se accede a la pantalla de detalle.
5. El botón "+" permite acceder a la pantalla de creación de nuevas tareas.
6. El menú lateral (Drawer) permite navegar entre las distintas secciones.
7. Actualmente, las funcionalidades utilizan datos simulados y no se almacenan de forma persistente.

---

## Estado actual del proyecto

El proyecto corresponde a una maqueta funcional, que implementa el flujo principal de la aplicación:

- Splash Screen inicial
- Listado de tareas
- Visualización de tareas en calendario
- Creación de tareas
- Pantalla de detalle
- Pantallas adicionales (Perfil, Ayuda, Sobre la app)
- Navegación completa mediante Drawer
- Uso de Theme global para consistencia visual

---

## Arquitectura del proyecto

El proyecto sigue una estructura modular basada en Flutter:

- **screens/**: contiene todas las pantallas de la aplicación
- **widgets/**: componentes reutilizables (tarjetas, drawer, etc.)
- **main.dart**: punto de entrada de la aplicación
- **app_routes.dart**: configuración de rutas y navegación

Se utiliza navegación basada en rutas mediante (`Navigator`), permitiendo la transición entre pantallas y el flujo de la aplicación.

---
## Estructura del proyecto

```text
lib/
├── models/
├── routes/
├── screens/
├── services/
├── widgets/
├── app.dart
└── main.dart
```
---

## Datos de ejemplo
La aplicación utiliza datos simulados para representar tareas, incluyendo:
- Título de la tarea
- Asignatura
- Fecha de entrega
Estos datos permiten demostrar el funcionamiento de la interfaz sin requerir persistencia.

---

## Características del dispositivo móvil
La aplicación aprovecha funcionalidades propias de dispositivos móviles como:

- Interfaz táctil intuitiva
- Acceso rápido desde cualquier lugar
- Organización visual de datos
- Simulación de recordatorios

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
- Los datos utilizados son simulados

---

## Tecnologías utilizadas

- Flutter (framework de desarrollo multiplataforma)
- Dart (lenguaje de programación)
- Material Design (sistema de diseño)
- Navigator (gestión de rutas)
- TableCalendar (visualización de calendario)

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

    B --> K[Menú lateral - Drawer]

    K --> L[Perfil]
    K --> M[Sobre la app]
    K --> N[Ayuda]

    L --> B
    M --> B
    N --> B
```
---
## Investigacion
[RESEARCH.md](RESEARCH.md)
---
# Arquitectura y Modelado

Como parte del proceso de validación técnica y diseño de la solución móvil, se desarrollaron distintos artefactos de ingeniería de software orientados a modelar:

- Separación de responsabilidades.
- Flujo asíncrono de la aplicación.
- Gestión de estados críticos.
- Integración entre Flutter y servicios nativos Android.
---
# Artefactos de Ingeniería de Software
---
## Diagrama Estructural
```mermaid
graph TD

%% =========================
%% CAPA DE PRESENTACIÓN
%% =========================
subgraph Presentacion["Capa de Presentación (Flutter UI)"]
    HS[HomeScreen]
    CS[CreateScreen]
    DS[DetailScreen]
    CDS[CalendarDetailScreen]
    PS[ProfileScreen]
    AS[AboutScreen]
    HES[HelpScreen]
    SPL[SplashScreen]
end

%% =========================
%% WIDGETS REUTILIZABLES
%% =========================
subgraph Widgets["Widgets UI Reutilizables"]
    DW[AppDrawer]
    HC[HomeworkCard]
end

%% =========================
%% NAVEGACIÓN
%% =========================
subgraph Routing["Capa de Navegación"]
    AR[AppRoutes]
    NAV[Navigator]
end

%% =========================
%% MODELO DE DATOS
%% =========================
subgraph Modelos["Modelo de Dominio (Simple)"]
    HW[Homework]
    TASKS["Tasks (Map / List en memoria)"]
end

%% =========================
%% FRAMEWORK / EXTERNOS
%% =========================
subgraph Framework["Framework / Librerías"]
    FLUTTER[Flutter Material]
    CAL[TableCalendar]
end

%% =========================
%% RELACIONES
%% =========================

%% Screens usan widgets
HS --> HC
HS --> DW
CS --> DW
DS --> DW
CDS --> DW
PS --> DW
AS --> DW
HES --> DW
SPL --> FLUTTER

%% Navegación
HS --> NAV
CS --> NAV
DS --> NAV
CDS --> NAV
PS --> NAV
AS --> NAV
HES --> NAV
NAV --> AR

%% Datos
HS --> TASKS
CDS --> TASKS
TASKS --> HW

%% Framework
HS --> CAL
HS --> FLUTTER
CS --> FLUTTER
DS --> FLUTTER
CDS --> FLUTTER
PS --> FLUTTER
AS --> FLUTTER
HES --> FLUTTER
```
---
## Diagrama de Secuencia

```mermaid
sequenceDiagram

actor Usuario

participant Home as HomeScreen
participant CreateScreen as CrearTareaScreen
participant Detail as DetailScreen
participant Calendar as CalendarDetailScreen
participant Store as TaskMemory
participant Navigator as FlutterNavigator

%% =========================
%% INICIO APP
%% =========================
Usuario->>Home: Abre aplicación
Home->>Store: Cargar tareas en memoria
Store-->>Home: Lista de tareas
Home-->>Usuario: Renderiza UI

%% =========================
%% VER DETALLE
%% =========================
Usuario->>Home: Selecciona tarea
Home->>Navigator: pushNamed('/detail', task)
Navigator->>DetailScreen: Enviar argumentos
DetailScreen-->>Usuario: Mostrar detalle

%% =========================
%% CREAR TAREA
%% =========================
Usuario->>Home: Presiona botón "+"
Home->>Navigator: pushNamed('/create')
Navigator->>CreateScreen: Abrir formulario

Usuario->>CreateScreen: Ingresa datos
CreateScreen->>Navigator: pop(newTask)
Navigator->>Home: Retorna resultado

Home->>Store: Agregar tarea
Home-->>Usuario: UI actualizada

%% =========================
%% CALENDARIO
%% =========================
Usuario->>Home: Selecciona día
Home->>Store: Filtrar por fecha
Store-->>Home: Tareas del día
Home->>Navigator: pushNamed('/calendar_detail', args)
Navigator->>CalendarDetailScreen: Mostrar datos

CalendarDetailScreen-->>Usuario: Mostrar lista
```
---
## Diagrama de estados

```mermaid
stateDiagram-v2

[*] --> SplashScreen

SplashScreen --> HomeScreen: App inicia

state HomeScreen {
    [*] --> Reposo

    Reposo --> CreateScreen: "+"
    Reposo --> DetailScreen: seleccionar tarea
    Reposo --> CalendarScreen: abrir calendario
    Reposo --> ProfileScreen: drawer
    Reposo --> HelpScreen: drawer
    Reposo --> AboutScreen: drawer
}

CreateScreen --> HomeScreen: guardar tarea
DetailScreen --> HomeScreen: back
CalendarScreen --> CalendarDetailScreen: seleccionar día
CalendarDetailScreen --> HomeScreen: back

state NotificationPoC {
    [*] --> Idle
    Idle --> Permisos: inicialización plugin
    Permisos --> Programada: scheduleNotification()
    Programada --> Espera
    Espera --> Disparada: Android OS
    Disparada --> Mostrada
}

HomeScreen --> NotificationPoC: trigger desde UI
NotificationPoC --> HomeScreen: retorno flujo
```
---
## Matriz de Dependencias Técnicas

| Dominio de necesidad | Tecnología seleccionada | Justificación técnica |
|----------------------|--------------------------|------------------------|
| Gestión de notificaciones locales en dispositivo | flutter_local_notifications | Se adopta este plugin debido a su madurez en ecosistema Flutter, soporte activo y capacidad de abstracción sobre el Notification Manager nativo de Android/iOS. Permite programación de notificaciones síncronas y diferidas sin dependencia de servicios backend, reduciendo acoplamiento con infraestructura externa. |
| Interfaz de usuario multiplataforma | Flutter (Material Design) | Framework oficial de Google que garantiza consistencia UI/UX entre Android e iOS. Su motor de renderizado propio reduce dependencia del sistema operativo, mejorando portabilidad y control del ciclo de vida de la UI. |
| Gestión de estado de la aplicación | setState y datos en memoria | Se utiliza gestión de estado local simplificada adecuada para una maqueta funcional y pruebas de navegación entre pantallas. |
| Arquitectura de lógica de negocio | Arquitectura modular basada en capas | Se separan responsabilidades entre pantallas, widgets reutilizables, rutas y servicios, permitiendo escalabilidad progresiva hacia arquitecturas más robustas como MVVM. |
| Acceso a sistema operativo (notificaciones nativas) | Android Notification Manager | Componente nativo del sistema operativo responsable de la ejecución de notificaciones. Su uso indirecto mediante plugins permite mantener independencia del framework Flutter mientras se conserva acceso a capacidades del SO. |
| Persistencia temporal de datos (modelo en memoria) | TaskModel en memoria | Se utiliza almacenamiento en memoria como decisión deliberada de PoC, eliminando dependencia de BaaS o bases de datos para enfocar la validación en la viabilidad de notificaciones asíncronas. |
---

## Proof of Concept (PoC)
La validación técnica de notificaciones locales fue desarrollada en la rama:

feature/poc_notificaciones_locales

Documentación completa disponible en:

[POC.md](POC.md)

---

## Autor

Desarrollado por David Valdés Hernández  
Proyecto académico — Programación de Dispositivos Móviles

---