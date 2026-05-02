import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text("Ayuda")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          "Aquí puedes encontrar ayuda sobre cómo usar la aplicación.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
