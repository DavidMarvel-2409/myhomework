# Investigación del Proyecto

## Aplicaciones similares

Existen diversas aplicaciones que permiten la gestión de tareas y recordatorios. Algunas de las más conocidas son:

- **Google Keep**: Permite crear notas rápidas y recordatorios, con una interfaz simple y sincronización en la nube.
- **Todoist**: Aplicación enfocada en la productividad, que permite organizar tareas por proyectos, prioridades y fechas.
- **Microsoft To Do**: Ofrece listas de tareas con integración al ecosistema de Microsoft.

Estas aplicaciones abordan la organización de tareas de forma general, pero no están específicamente orientadas al contexto académico, lo que abre la oportunidad de desarrollar una solución enfocada en estudiantes.

---

## Propuesta de implementación

La aplicación será desarrollada utilizando Flutter, lo que permite crear aplicaciones móviles multiplataforma a partir de un único código base.

Desde el punto de vista técnico, se utilizarán los siguientes componentes:

- **Widgets**: Para construir la interfaz de usuario de forma modular.
- **ListView**: Para mostrar dinámicamente la lista de tareas.
- **Modelos de datos**: Se definirá una clase `Task` que representará cada tarea.
- **Navegación**: Uso de `Navigator` para moverse entre pantallas.
- **Almacenamiento local**: Uso de herramientas como `SharedPreferences` o `SQLite` para guardar las tareas.
- **Notificaciones**: Implementación de recordatorios mediante paquetes como `flutter_local_notifications`.

Esta arquitectura permite una aplicación escalable, mantenible y alineada con los requerimientos definidos.