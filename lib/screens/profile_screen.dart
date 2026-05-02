import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text("Perfil")),
      body: Center(
        child: Text(
          "Pantalla de perfil",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
