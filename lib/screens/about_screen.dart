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
        padding: const EdgeInsets.all(16),
        child: Text(
          "MyHomework es una aplicación para gestionar tareas académicas.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
