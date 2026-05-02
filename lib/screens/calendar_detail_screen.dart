import 'package:flutter/material.dart';
import '../widgets/homework_card.dart';

class CalendarDetailScreen extends StatelessWidget {
  const CalendarDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final DateTime selectedDay =
    //     ModalRoute.of(context)!.settings.arguments as DateTime;
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    final DateTime selectedDay = args['date'];
    final List tasks = args['tasks'];

    return Scaffold(
      appBar: AppBar(title: const Text("Detalle del día")),
      // body: Center(
      //   child: Text(
      //     "Seleccionaste: ${selectedDay.day}/${selectedDay.month}/${selectedDay.year}",
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tareas para ${selectedDay.day}/${selectedDay.month}/${selectedDay.year}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            if (tasks.isEmpty) const Text("No hay tareas para este dia"),
            if (tasks.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final t = tasks[index];
                    return HomeworkCard(
                      title: t['title'],
                      subject: t['subject'],
                      date: t['date'],
                      onTap: () {
                        Navigator.pushNamed(context, '/detail', arguments: t);
                      },
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
