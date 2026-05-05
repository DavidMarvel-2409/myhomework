import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text("Sobre la app")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Image.asset('assets/images/app_icon.png', height: 100),

            const SizedBox(height: 20),

            Text(
              "MyHomework",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            Text(
              "Aplicación móvil desarrollada en Flutter para la gestión de tareas académicas.",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            Text("Información", style: Theme.of(context).textTheme.titleMedium),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Desarrollador"),
              subtitle: const Text("David Valdés Hernández (DavidMarvel)"),
            ),

            ListTile(
              leading: const Icon(Icons.code),
              title: const Text("Tecnología"),
              subtitle: const Text("Flutter"),
            ),

            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("Versión"),
              subtitle: const Text("1.0.0 (Maqueta)"),
            ),

            const SizedBox(height: 20),

            Text(
              "Proyecto académico - Programación de Dispositivos Móviles",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
