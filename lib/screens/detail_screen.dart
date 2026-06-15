import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../models/homework.dart';
import 'package:provider/provider.dart';
import '../providers/homework_provider.dart';
import 'package:share_plus/share_plus.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final Homework task = args['task'];

    final int index = args['index'];

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Detalles de tarea"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/edit',
                arguments: {'task': task, 'index': index},
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Eliminar tarea"),
                    content: const Text("¿Deseas eliminar esta tarea?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Eliminar"),
                      ),
                    ],
                  );
                },
              );

              if (confirm == true && context.mounted) {
                await context.read<HomeworkProvider>().removeTask(index);

                Navigator.pop(context);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share(
                'Tarea: ${task.title}\n'
                'Asignatura: ${task.subject}\n'
                'Fecha de entrega: ${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}\n'
                'Descripción: ${task.description}',
              );
            },
          ),
        ],
      ),
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
                Text(task.title, style: Theme.of(context).textTheme.titleLarge),

                const SizedBox(height: 15),

                Text(
                  "Asignatura: ${task.subject}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 10),

                Text(
                  "Fecha de entrega: ${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 15),

                Text(
                  "Descripción:",
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 5),
                Text(
                  task.description.isEmpty
                      ? "Sin descripción"
                      : task.description,
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
