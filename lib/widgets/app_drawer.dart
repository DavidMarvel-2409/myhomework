import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/app_icon.png',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 10),
                const Text(
                  'MyHomework',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),

          // 🏠 Home
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),

          // ➕ Crear tarea
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Crear tarea'),
            onTap: () {
              Navigator.pushNamed(context, '/create');
            },
          ),

          // 📅 Calendario (opcional: vuelve al home)
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Calendario'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),

          const Divider(),

          // 👤 Perfil
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),

          // ℹ️ About
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre la app'),
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),

          // ❓ Ayuda
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Ayuda'),
            onTap: () {
              Navigator.pushNamed(context, '/help');
            },
          ),
        ],
      ),
    );
  }
}
