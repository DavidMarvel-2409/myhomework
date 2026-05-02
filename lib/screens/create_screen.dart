import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  CreateScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crear tarea")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Titulo",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: "Fecha (ej: 30 Abril)",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Descripción",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newTask = {
                  'title': titleController.text,
                  'subject': subjectController.text,
                  'date': dateController.text,
                  'description': descriptionController.text,
                };
                Navigator.pop(context, newTask);
              },
              child: const Text("Guardar tarea"),
            ),
          ],
        ),
      ),

      // body: Center(child: Text("Pantalla de creación")),
    );
  }
}
