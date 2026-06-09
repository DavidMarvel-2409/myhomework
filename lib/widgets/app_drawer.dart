import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: colors.secondary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 39, 94, 130)),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/app_icon2.png',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 10),
                Text(
                  'MyHomework',
                  style: TextStyle(
                    color: colors.onPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            leading: Icon(Icons.home, color: colors.onSecondary),
            title: Text('Inicio', style: TextStyle(color: colors.onSecondary)),
            onTap: () {
              _navigate(context, '/home');
            },
          ),

          ListTile(
            leading: Icon(Icons.add, color: colors.onSecondary),
            title: Text(
              'Crear tarea',
              style: TextStyle(color: colors.onSecondary),
            ),
            onTap: () {
              _navigate(context, '/create');
            },
          ),

          ListTile(
            leading: Icon(Icons.calendar_today, color: colors.onSecondary),
            title: Text(
              'Calendario',
              style: TextStyle(color: colors.onSecondary),
            ),
            onTap: () {
              _navigate(context, '/home');
            },
          ),

          Divider(color: colors.onSecondary.withValues(alpha: 0.4)),

          ListTile(
            leading: Icon(Icons.person, color: colors.onSecondary),
            title: Text('Perfil', style: TextStyle(color: colors.onSecondary)),
            onTap: () {
              _navigate(context, '/profile');
            },
          ),

          ListTile(
            leading: Icon(Icons.settings, color: colors.onSecondary),
            title: Text(
              'Preferencias',
              style: TextStyle(color: colors.onSecondary),
            ),
            onTap: () {
              _navigate(context, '/preferences');
            },
          ),

          ListTile(
            leading: Icon(Icons.info, color: colors.onSecondary),
            title: Text(
              'Sobre la app',
              style: TextStyle(color: colors.onSecondary),
            ),
            onTap: () {
              _navigate(context, '/about');
            },
          ),

          ListTile(
            leading: Icon(Icons.help, color: colors.onSecondary),
            title: Text('Ayuda', style: TextStyle(color: colors.onSecondary)),
            onTap: () {
              _navigate(context, '/help');
            },
          ),

          ListTile(
            leading: Icon(Icons.notifications, color: colors.onSecondary),
            title: Text(
              'PoC Notificaciones',
              style: TextStyle(color: colors.onSecondary),
            ),
            onTap: () {
              _navigate(context, '/poc_notifications');
            },
          ),
          ListTile(
            leading: Icon(Icons.star_rate, color: colors.onSecondary),
            title: Text(
              'Valorización',
              style: TextStyle(color: colors.onSecondary),
            ),
            onTap: () {
              _navigate(context, '/qa');
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
