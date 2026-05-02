import 'package:flutter/material.dart';
import '../widgets/homework_card.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final List<Map<String, String>> task = const [
    {
      'title': 'Guia de 4',
      'subject': 'Calculo2',
      'date': '30 Abril',
      'description': 'Resolver ejercicios del capítulo 4',
    },
    {
      'title': 'Avance proyecto',
      'subject': 'Programacion Dispositivos Moviles',
      'date': '28 Abril',
      'description': 'Implementar pantalla principal en Flutter',
    },
    {
      'title': 'Entrega final de app',
      'subject': 'Programacion Dispositivos Moviles',
      'date': '5 Mayo',
      'description':
          'Entrega final con la implementacion de todas las pantallas con su flujo de trabajo actualizado',
    },
  ];
  DateTime parseDate(String date) {
    final parts = date.split(' ');
    final day = int.parse(parts[0]);

    const months = {
      'Enero': 1,
      'Febrero': 2,
      'Marzo': 3,
      'Abril': 4,
      'Mayo': 5,
      'Junio': 6,
      'Julio': 7,
      'Agosto': 8,
      'Septiembre': 9,
      'Octubre': 10,
      'Noviembre': 11,
      'Diciembre': 12,
    };

    final month = months[parts[1]]!;
    final now_ = DateTime.now();
    return DateTime(now_.year, month, day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/app_icon.png', width: 30, height: 30),
            const SizedBox(width: 8),
            const Text("MyHomework"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bienvenid@ a MyHomework",
                style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(height: 8),
              Text(
                "Gestiona tus tareas, revisa fechas de entrega y organiza tu estudio.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Text(
                "Tareas pendientes",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: task.length,
                itemBuilder: (context, index) {
                  final currentTask = task[index];
                  return HomeworkCard(
                    title: currentTask['title']!,
                    subject: currentTask['subject']!,
                    date: currentTask['date']!,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: currentTask,
                      );
                    },
                  );
                },
              ),

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: task.length,
              //     itemBuilder: (context, index) {
              //       final currentTask = task[index];
              //       return HomeworkCard(
              //         title: currentTask['title']!,
              //         subject: currentTask['subject']!,
              //         date: currentTask['date']!,
              //         onTap: () {
              //           Navigator.pushNamed(context, '/detail');
              //         },
              //       );
              //     },
              //   ),
              // ),
              const SizedBox(height: 10),
              SizedBox(
                height: 350,
                child: TableCalendar(
                  rowHeight: 40,
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2100, 12, 31),
                  focusedDay: DateTime.now(),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),

                  eventLoader: (day) {
                    final normalized = DateTime(day.year, day.month, day.day);

                    return task.where((t) {
                      final parsed = parseDate(t['date']!);
                      return parsed.year == normalized.year &&
                          parsed.month == normalized.month &&
                          parsed.day == normalized.day;
                    }).toList();
                  },

                  onDaySelected: (selectedDay, focusedDay) {
                    final tasksOfDay = task.where((t) {
                      final parsed = parseDate(t['date']!);
                      return parsed.year == selectedDay.year &&
                          parsed.month == selectedDay.month &&
                          parsed.day == selectedDay.day;
                    }).toList();
                    Navigator.pushNamed(
                      context,
                      '/calendar_detail',
                      arguments: {'date': selectedDay, 'tasks': tasksOfDay},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.pushNamed(context, '/create');

          if (newTask != null) {
            print(newTask);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
