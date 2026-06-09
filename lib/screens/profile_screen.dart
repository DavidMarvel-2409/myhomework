import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text("Perfil")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<ProfileProvider>(
          builder: (context, profile, child) {
            return Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: const AssetImage(
                    'assets/images/user_image.png',
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  profile.profile.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 5),

                Text(
                  profile.profile.email,
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

                // ListTile(
                //   leading: const Icon(Icons.notifications),
                //   title: const Text("Notificaciones"),
                //   onTap: () {
                //     _showNotificationsDialog(context);
                //   },
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}

void _showEditDialog(BuildContext context) {
  final profile = context.read<ProfileProvider>();
  final emailController = TextEditingController(text: profile.profile.email);
  final nameController = TextEditingController(text: profile.profile.name);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Editar perfil"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),

            const SizedBox(height: 10),
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
                  const SnackBar(content: Text("Cambio de imagen pendiente")),
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
            onPressed: () async {
              await profile.updateProfile(
                nameController.text,
                emailController.text,
              );

              if (context.mounted) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Perfil actualizado")),
                );
              }
            },
            child: const Text("Guardar"),
          ),
        ],
      );
    },
  );
}

// void _showNotificationsDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text("Notificaciones"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: const [
//             ListTile(
//               leading: Icon(Icons.check),
//               title: Text("Recordatorios de tareas"),
//               subtitle: Text("Activado (simulado)"),
//             ),
//             ListTile(
//               leading: Icon(Icons.schedule),
//               title: Text("Aviso antes de entrega"),
//               subtitle: Text("1 día antes (simulado)"),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cerrar"),
//           ),
//         ],
//       );
//     },
//   );
// }
