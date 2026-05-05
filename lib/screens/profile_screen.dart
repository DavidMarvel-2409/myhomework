import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text("Perfil")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/user_image.png'),
            ),

            const SizedBox(height: 15),

            Text("David Marvel", style: Theme.of(context).textTheme.titleLarge),

            const SizedBox(height: 5),

            Text(
              "david.marvel.programer.2409@email.com",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 30),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Configuración"),
              onTap: () {
                _showEditDialog(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text("Notificaciones"),
              onTap: () {
                _showNotificationsDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _showEditDialog(BuildContext context) {
  final emailController = TextEditingController(
    text: "david.marvel.programer.2409@email.com",
  );

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Editar perfil"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Correo electrónico",
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Imagen cambiada (simulado)")),
                );
              },
              child: const Text("Cambiar imagen"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Cambios guardados (simulado)")),
              );
            },
            child: const Text("Guardar"),
          ),
        ],
      );
    },
  );
}

void _showNotificationsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Notificaciones"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            ListTile(
              leading: Icon(Icons.check),
              title: Text("Recordatorios de tareas"),
              subtitle: Text("Activado (simulado)"),
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text("Aviso antes de entrega"),
              subtitle: Text("1 día antes (simulado)"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          ),
        ],
      );
    },
  );
}
