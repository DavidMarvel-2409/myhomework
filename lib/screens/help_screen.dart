import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text("Ayuda")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text("Ayuda", style: Theme.of(context).textTheme.titleLarge),

            const SizedBox(height: 20),

            ExpansionTile(
              leading: const Icon(Icons.home),
              title: const Text("¿Qué puedo hacer en la pantalla principal?"),
              children: const [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Puedes ver tus tareas pendientes, acceder al detalle de cada una y agregar nuevas tareas.",
                  ),
                ),
              ],
            ),

            ExpansionTile(
              leading: const Icon(Icons.add),
              title: const Text("¿Cómo agrego una tarea?"),
              children: const [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Presiona el botón '+' en la pantalla principal para crear una nueva tarea.",
                  ),
                ),
              ],
            ),

            ExpansionTile(
              leading: const Icon(Icons.person),
              title: const Text("¿Cómo edito mi perfil?"),
              children: const [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Ve a la pantalla de perfil y selecciona 'Configuración' para editar tus datos.",
                  ),
                ),
              ],
            ),

            ExpansionTile(
              leading: const Icon(Icons.notifications),
              title: const Text("¿Cómo funcionan las notificaciones?"),
              children: const [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Las notificaciones son simuladas en esta versión y muestran recordatorios de tareas.",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              "¿Necesitas más ayuda?",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 10),

            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Contacto"),
              subtitle: const Text("soporte@myhomework.com"),
            ),
          ],
        ),
      ),
    );
  }
}
