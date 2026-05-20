# POC.md

# Proof of Concept (PoC)
## Validación Técnica de Notificaciones Locales

---

# Proyecto

**MyHomework**  
Sistema de gestión y recordatorios académicos desarrollado en Flutter.

---

# Rama de desarrollo

```bash
feature/poc_notifications
```
---

## 1.Contexto

Dentro del proyecto MyHomework se identificó como principal riesgo técnico la implementación de recordatorios automáticos mediante notificaciones locales en dispositivos Android.

La aplicación busca asistir a estudiantes en la organización de tareas, entregas y actividades académicas, por lo que la capacidad de generar alertas y recordatorios constituye una funcionalidad crítica dentro del flujo principal de la solución.

La implementación de notificaciones móviles introduce distintos desafíos técnicos relacionados con:

- Comunicación entre Flutter y APIs nativas Android.
- Inicialización asíncrona de servicios.
- Gestión de permisos runtime en Android 13+.
- Compatibilidad entre versiones del sistema operativo.
- Restricciones impuestas por fabricantes (MIUI/Xiaomi).
- Configuración de canales de notificación.
- Integración futura con persistencia y programación automática.

Debido a la complejidad técnica y asincronía involucrada, se decidió aislar esta funcionalidad en una rama experimental para validar su viabilidad antes de integrarla completamente a la arquitectura principal del proyecto.

---
## 2. Objetivo de la PoC

Validar técnicamente que la aplicación Flutter es capaz de:

Inicializar correctamente servicios de notificaciones locales.
Solicitar permisos dinámicos requeridos por Android moderno.
Comunicarse correctamente con el sistema operativo Android.
Mostrar notificaciones locales funcionales.
Integrar la lógica mediante una arquitectura desacoplada basada en capas.
---

### 3. Estrategia de Validación

La validación fue desarrollada siguiendo las restricciones definidas para la PoC:

Uso de interfaz mínima.
Implementación enfocada exclusivamente en lógica.
Aislamiento del experimento en rama independiente.
Eliminación de complejidad visual innecesaria.

Se creó una pantalla experimental denominada:

```bash
NotificationPoCScreen

```
La pantalla contiene únicamente:

Un botón básico de prueba.
Ejecución directa del servicio de notificaciones.
Validación visual mediante notificación Android.

---
## 4. Decisión Técnica Adoptada
Librería seleccionada

Se seleccionó el paquete:

```bash
flutter_local_notifications: ^17.0.0
```
---
## 5. Justificación Técnica

| Criterio           | Justificación                                                               |
| ------------------ | --------------------------------------------------------------------------- |
| Madurez            | Plugin ampliamente utilizado y consolidado dentro del ecosistema Flutter    |
| Compatibilidad     | Compatible con Android moderno y Flutter SDK actual                         |
| Mantenimiento      | Posee soporte activo y actualizaciones frecuentes                           |
| Integración Nativa | Permite comunicación directa con Notification Manager de Android            |
| Escalabilidad      | Soporta notificaciones programadas, repetitivas y avanzadas                 |
| Documentación      | Posee documentación oficial extensa y casos de uso ampliamente documentados |

---

## 6. Arquitectura Implementada

La PoC fue desarrollada utilizando separación de responsabilidades por capas.

Capa de Presentación

Responsable de:

- Capturar interacción del usuario.
- Disparar eventos de prueba.
- Mostrar estado mínimo de ejecución.
Componentes:
- NotificationPoCScreen


Capa de Servicios

Responsable de:

- Inicializar el plugin.
- Configurar permisos.
- Ejecutar notificaciones.
- Encapsular lógica de comunicación nativa.
Componentes:
- NotificationService


Capa de Infraestructura

Responsable de:

- Comunicación con Android Notification Manager.
- Ejecución de APIs nativas.
- Gestión del canal de notificaciones.
Componentes:
- flutter_local_notifications
- Android Notification Manager

---
## 7. Flujo Arquitectónico de la PoC

La integración implementada sigue el siguiente flujo desacoplado:

UI (NotificationPoCScreen)
↓
NotificationService
↓
flutter_local_notifications
↓
Android Notification Manager
↓
Sistema Operativo Android

Esta separación permitió desacoplar la lógica de negocio respecto de la infraestructura nativa, facilitando futuras extensiones y refactorización hacia una arquitectura MVVM completa.
---

## 8. Implementación Realizada
Funcionalidades implementadas
- Inicialización del plugin.
- Solicitud de permisos runtime.
- Configuración AndroidManifest.xml.
- Configuración de Notification Channel.
- Ejecución de notificaciones locales.
- Integración con Flutter mediante servicio desacoplado.

---

## 9. Flujo Validado
1. Usuario acciona botón de prueba.
2. Flutter ejecuta NotificationService.
3. NotificationService comunica con flutter_local_notifications.
4. Plugin interactúa con Android Notification Manager.
5. Android genera la notificación local.
6. Usuario recibe la notificación correctamente.
---
## 10. Configuración Técnica Aplicada
AndroidManifest.xml

Se agregó:

```bash
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```
Inicialización temprana

Se implementó:
```bash
WidgetsFlutterBinding.ensureInitialized();
await NotificationService.init();
```
antes de
```bash
runApp()
```
Solicitud de permisos runtime

Se implementó:
```bash
requestNotificationsPermission()
```
para soportar Android 13+.
---
## 11. Problemas Detectados Durante la Investigación
Restricciones Android 13+

Se identificó que Android moderno requiere permisos dinámicos para notificaciones, incluso cuando los permisos ya están declarados en AndroidManifest.xml.

Inicialización obligatoria del plugin

El plugin no funciona correctamente si no es inicializado antes de runApp().

Esto generaba que las notificaciones no aparecieran pese a ejecutarse correctamente el método show().

Configuración Gradle (Desugaring)

La librería requirió habilitar:

```bash
coreLibraryDesugaringEnabled true
```
además de agregar:

```bash
com.android.tools:desugar_jdk_libs
```
para compatibilidad Android moderna.
---

## 12. Resultados de la PoC

| Validación                            | Resultado |
| ------------------------------------- | --------- |
| Integración Flutter ↔ Android         | Exitosa   |
| Inicialización asíncrona              | Exitosa   |
| Solicitud de permisos runtime         | Exitosa   |
| Configuración de Notification Channel | Exitosa   |
| Comunicación con Notification Manager | Exitosa   |
| Ejecución de notificaciones locales   | Exitosa   |
| Compatibilidad con Android Emulator   | Exitosa   |
| Compatibilidad con dispositivo físico | Exitosa   |
---

## 13. Consecuencias de la Investigación

La PoC permitió validar exitosamente la viabilidad técnica del sistema de recordatorios locales del proyecto MyHomework.

Además, permitió identificar tempranamente:

- Dependencias necesarias.
- Configuraciones Android críticas.
- Restricciones del sistema operativo.
- Consideraciones de compatibilidad futura.

La investigación redujo significativamente el riesgo técnico asociado a la funcionalidad de notificaciones.
---
## 14. Limitaciones de la PoC

La prueba de concepto fue diseñada únicamente para validar la comunicación e integración técnica con el sistema de notificaciones Android.

Por restricciones deliberadas de la actividad:

- No se implementó persistencia de datos.
- No se programaron notificaciones calendarizadas reales.
- No se implementó almacenamiento local o Firebase.
- No se desarrolló interfaz visual avanzada.
- No se integró aún con TaskViewModel ni HomeworkModel.

El objetivo exclusivo fue validar la viabilidad técnica del componente crítico.
---
## 15. Plan de Integración Futura

Como siguiente etapa del proyecto se proyecta:

- Integrar NotificationService dentro de arquitectura MVVM.
- Asociar recordatorios directamente con HomeworkModel.
- Programar notificaciones automáticas según dueDate.
- Implementar persistencia local.
- Permitir configuración personalizada de recordatorios.
- Implementar cancelación y edición de notificaciones.
- Incorporar recordatorios recurrentes.
## 16. Conclusión

La prueba de concepto permitió validar exitosamente la integración de notificaciones locales dentro del ecosistema Flutter utilizando comunicación con Android nativo.

La solución demostró ser técnicamente viable, escalable y compatible con una futura integración basada en arquitectura desacoplada tipo MVVM/Clean Architecture.

La utilización de una rama experimental permitió aislar el riesgo técnico y realizar validaciones controladas sin comprometer la estabilidad de la maqueta funcional principal.

La investigación permitió además identificar restricciones reales del entorno móvil moderno, particularmente relacionadas con permisos runtime y políticas de fabricantes Android, fortaleciendo la planificación técnica futura del proyecto.