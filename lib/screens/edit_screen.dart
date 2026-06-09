import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/homework.dart';
import '../providers/homework_provider.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController titleController;
  late TextEditingController subjectController;
  late TextEditingController descriptionController;

  DateTime? selectedDate;

  late Homework task;
  late int index;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    task = args['task'];
    index = args['index'];

    titleController = TextEditingController(text: task.title);

    subjectController = TextEditingController(text: task.subject);

    descriptionController = TextEditingController(text: task.description);

    selectedDate = task.dueDate;
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar tarea")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Título",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: subjectController,
              decoration: const InputDecoration(
                labelText: "Asignatura",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Descripción",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            ListTile(
              title: Text(
                selectedDate == null
                    ? "Seleccionar fecha"
                    : "Fecha: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: pickDate,
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text("Guardar cambios"),
              onPressed: () async {
                if (titleController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Debes ingresar un título")),
                  );
                  return;
                }

                final updatedTask = Homework(
                  title: titleController.text.trim(),
                  subject: subjectController.text.trim(),
                  description: descriptionController.text.trim(),
                  dueDate: selectedDate!,
                );

                await context.read<HomeworkProvider>().updateTask(
                  index,
                  updatedTask,
                );

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
