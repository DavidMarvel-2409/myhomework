import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text("Ayuda y documentación")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            "Guía de uso de MyHomework",
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 16),

          Text(
            "Esta sección explica cómo funciona la aplicación y sus principales módulos.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 24),

          ExpansionTile(
            leading: const Icon(Icons.task_alt),
            title: const Text("Gestión de tareas"),
            children: const [
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "• Puedes crear tareas desde el botón '+' en la pantalla principal.\n"
                  "• Las tareas se almacenan localmente mediante el sistema de persistencia.\n"
                  "• Puedes editar, completar o eliminar tareas desde el detalle.\n"
                  "• Las tareas se organizan por estado y fecha de entrega.",
                ),
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.notifications_active),
            title: const Text("Sistema de notificaciones"),
            children: const [
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "• Las notificaciones son locales y se gestionan desde NotificationService.\n"
                  "• Se programan recordatorios automáticos para tareas pendientes.\n"
                  "• También existen notificaciones de resumen semanal.\n"
                  "• Puedes activar o desactivar notificaciones desde Preferencias.",
                ),
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.settings),
            title: const Text("Preferencias de usuario"),
            children: const [
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "• El modo compacto cambia la densidad de información en listas.\n"
                  "• Las preferencias se guardan de forma persistente.\n"
                  "• Los cambios se aplican inmediatamente en la interfaz.\n"
                  "• Incluye configuración de notificaciones y visualización.",
                ),
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.architecture),
            title: const Text("Arquitectura de la aplicación"),
            children: const [
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "• El proyecto sigue el patrón MVVM.\n"
                  "• La UI (Views) no contiene lógica de negocio.\n"
                  "• La lógica está centralizada en Providers (ViewModels).\n"
                  "• Los servicios (como notificaciones y persistencia) están desacoplados.",
                ),
              ),
            ],
          ),

          ExpansionTile(
            leading: const Icon(Icons.quiz),
            title: const Text("Evaluación QA / Beta Testing"),
            children: const [
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "• La aplicación incluye un sistema de preguntas en JSON.\n"
                  "• Se evalúan usabilidad, contenido y experiencia de uso.\n"
                  "• Los resultados son utilizados para análisis de mejora.\n"
                  "• El instrumento está diseñado para usuarios reales (beta testing).",
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.share),
            title: const Text("Compartir tareas"),
            children: const [
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "• Desde el detalle de una tarea puedes compartirla con otros.\n"
                  "• Usa el ícono de compartir en la barra superior.\n"
                  "• Se abre el menú nativo del dispositivo (WhatsApp, correo, etc.).\n"
                  "• Se comparte el título, asignatura, fecha y descripción de la tarea.",
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Text("Soporte", style: Theme.of(context).textTheme.titleMedium),

          const SizedBox(height: 10),

          const ListTile(
            leading: Icon(Icons.email),
            title: Text("Contacto"),
            subtitle: Text(
              "myhomework.soporte@gmail.com\nRespuesta no garantizada inmediata.",
            ),
          ),
        ],
      ),
    );
  }
}
