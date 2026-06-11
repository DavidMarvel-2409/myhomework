import 'package:flutter/material.dart';
import '../widgets/homework_card.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/homework_provider.dart';
import '../services/firestore_service.dart';
import '../models/homework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<HomeworkProvider>().loadTasks();
    });
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
            Image.asset('assets/images/app_icon2.png', width: 30, height: 30),
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
              Consumer<HomeworkProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.tasks.length,
                    itemBuilder: (context, index) {
                      final currentTask = provider.tasks[index];

                      return Dismissible(
                        key: ValueKey(
                          "${currentTask.title}_${currentTask.dueDate}",
                        ),

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
                                  content: Text(
                                    "¿Deseas eliminar '${currentTask.title}'?",
                                  ),
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
                          provider.removeTask(index);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${currentTask.title} eliminada"),
                            ),
                          );
                        },

                        child: HomeworkCard(
                          title: currentTask.title,
                          subject: currentTask.subject,
                          date:
                              "${currentTask.dueDate.day}/${currentTask.dueDate.month}/${currentTask.dueDate.year}",
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/detail',
                              arguments: {'task': currentTask, 'index': index},
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 10),
              SizedBox(
                height: 350,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Consumer<HomeworkProvider>(
                    builder: (context, provider, child) {
                      return TableCalendar(
                        rowHeight: 40,
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.utc(2100, 12, 31),
                        focusedDay: DateTime.now(),

                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                          leftChevronIcon: const Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                          rightChevronIcon: const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                        ),

                        daysOfWeekStyle: const DaysOfWeekStyle(
                          weekdayStyle: TextStyle(color: Colors.white),
                          weekendStyle: TextStyle(color: Colors.white),
                        ),

                        calendarStyle: CalendarStyle(
                          defaultTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          weekendTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          outsideTextStyle: TextStyle(
                            color: Colors.white..withValues(alpha: 0.4),
                          ),

                          todayDecoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),

                          selectedDecoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            shape: BoxShape.circle,
                          ),

                          markerDecoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            shape: BoxShape.circle,
                          ),
                        ),

                        eventLoader: (day) {
                          return provider.tasks.where((task) {
                            return task.dueDate.year == day.year &&
                                task.dueDate.month == day.month &&
                                task.dueDate.day == day.day;
                          }).toList();
                        },

                        onDaySelected: (selectedDay, focusedDay) {
                          final tasksOfDay = provider.tasks.where((task) {
                            return task.dueDate.year == selectedDay.year &&
                                task.dueDate.month == selectedDay.month &&
                                task.dueDate.day == selectedDay.day;
                          }).toList();

                          Navigator.pushNamed(
                            context,
                            '/calendar_detail',
                            arguments: {
                              'date': selectedDay,
                              'tasks': tasksOfDay,
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
