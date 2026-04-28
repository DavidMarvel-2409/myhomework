import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final List<Map<String, String>> task = const [
    {'title': 'Guia de 4', 'subject': 'Calculo2', 'date': '30 Abril'},
    {
      'title': 'Avance proyecto',
      'subject': 'Programacion Dispositivos Moviles',
      'date': '28 Abril',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MyHomework"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bienvenid@ a MyHomework",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),
            const Text(
              "Gestiona tus tareas, revisa fechas de entrega y organiza tu estudio.",
            ),
            const SizedBox(height: 20),
            const Text(
              "Tareas pendientes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: task.length,
                itemBuilder: (context, index) {
                  final currentTask = task[index];
                  return Card(
                    child: ListTile(
                      title: Text(currentTask['title']!),
                      subtitle: Text(currentTask['subject']!),
                      trailing: Text(currentTask['date']!),
                      onTap: () {
                        Navigator.pushNamed(context, '/detail');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
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
