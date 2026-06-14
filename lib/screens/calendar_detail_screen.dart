import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/homework_card.dart';
import '../widgets/app_drawer.dart';
import '../models/homework.dart';
import '../providers/homework_provider.dart';

class CalendarDetailScreen extends StatelessWidget {
  const CalendarDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final DateTime selectedDay = args['date'];
    final allTasks = context.watch<HomeworkProvider>().tasks;

    final tasks = allTasks.where((task) {
      return task.dueDate.year == selectedDay.year &&
          task.dueDate.month == selectedDay.month &&
          task.dueDate.day == selectedDay.day;
    }).toList();

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(
          "Detalle del día",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tareas para ${selectedDay.day}/${selectedDay.month}/${selectedDay.year}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 15),

            if (tasks.isEmpty) const Text("No hay tareas para este día"),

            if (tasks.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final Homework t = tasks[index];
                    final realIndex = allTasks.indexOf(t);
                    return Dismissible(
                      key: ValueKey("${t.title}_${t.dueDate}"),

                      direction: DismissDirection.endToStart,

                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),

                      confirmDismiss: (direction) async {
                        return await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Eliminar tarea"),
                                content: Text("¿Deseas eliminar '${t.title}'?"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text("Cancelar"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text("Eliminar"),
                                  ),
                                ],
                              ),
                            ) ??
                            false;
                      },

                      onDismissed: (_) {
                        context.read<HomeworkProvider>().removeTask(realIndex);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${t.title} eliminada")),
                        );
                      },

                      child: HomeworkCard(
                        title: t.title,
                        subject: t.subject,
                        date:
                            "${t.dueDate.day}/${t.dueDate.month}/${t.dueDate.year}",
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/detail',
                            arguments: {'task': t, 'index': realIndex},
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
