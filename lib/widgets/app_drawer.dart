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

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              _navigate(context, '/home');
            },
          ),

          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Crear tarea'),
            onTap: () {
              _navigate(context, '/create');
            },
          ),

          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Calendario'),
            onTap: () {
              _navigate(context, '/home');
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              _navigate(context, '/profile');
            },
          ),

          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre la app'),
            onTap: () {
              _navigate(context, '/about');
            },
          ),

          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Ayuda'),
            onTap: () {
              _navigate(context, '/help');
            },
          ),
        ],
      ),
    );
  }
}

void _navigate(BuildContext context, String route) {
  Navigator.pop(context); // cierra el drawer
  Navigator.pushReplacementNamed(context, route);
}
