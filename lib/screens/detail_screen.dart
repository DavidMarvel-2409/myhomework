import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final task =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text("Detalles de tarea")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task['title']!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 15),

                Text(
                  "Asignatura: ${task['subject']}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 10),

                Text(
                  "Fecha de entrega: ${task['date']}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 15),

                Text(
                  "Descripción:",
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 5),
                Text(
                  task['description']!.isEmpty
                      ? "Sin descripción"
                      : task['description']!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
      // body: Center(child: Text("Pantalla de detalle")),
    );
  }
}
