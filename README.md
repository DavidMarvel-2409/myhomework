# MyHomework: Sistema de gestión y recordatorios académicos

## Descripción
MyHomework es una aplicación móvil diseñada para ayudar a estudiantes a organizar sus tareas académicas de manera eficiente.

La aplicación permite registrar actividades con fechas límite, descripciones y niveles de prioridad, además de generar recordatorios automáticos para evitar olvidos y mejorar la planificación del tiempo.

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

- El sistema debe permitir crear tareas
- El sistema debe permitir editar tareas
- El sistema debe permitir eliminar tareas
- El sistema debe permitir visualizar tareas
- El sistema debe generar recordatorios

---

### Requerimientos no funcionales

- La aplicación debe ser rápida y responsiva
- Debe ser fácil de usar
- Debe funcionar en dispositivos Android
- Debe tener bajo consumo de recursos

---

## Diagrama de flujo

```mermaid
flowchart TD
    A[Inicio] --> B[Ver lista de tareas]
    B --> C[Agregar tarea]
    C --> D[Ingresar datos]
    D --> E[Guardar tarea]
    E --> B
    B --> F[Seleccionar tarea]
    F --> G[Editar o eliminar]
    G --> B
