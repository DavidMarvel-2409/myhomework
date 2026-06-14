import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/profile_firestore_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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

                FutureBuilder<Map<String, dynamic>?>(
                  future: user != null
                      ? ProfileFirestoreService().getProfile(user.uid)
                      : Future.value(null),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text(
                        "Cargando...",
                        style: Theme.of(context).textTheme.titleLarge,
                      );
                    }

                    final data = snapshot.data;

                    return Text(
                      data?['name'] ?? "Usuario",
                      style: Theme.of(context).textTheme.titleLarge,
                    );
                  },
                ),

                const SizedBox(height: 5),

                Text(
                  user?.email ?? '',
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
                const SizedBox(height: 20),

                // ElevatedButton.icon(
                //   icon: const Icon(Icons.logout),
                //   label: const Text("Cerrar sesión"),
                //   onPressed: () async {
                //     await FirebaseAuth.instance.signOut();
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
              final user = FirebaseAuth.instance.currentUser;

              if (user != null) {
                await ProfileFirestoreService().saveProfile(
                  uid: user.uid,
                  name: nameController.text,
                  email: user.email!,
                );
              }

              await profile.updateProfile(
                nameController.text,
                profile.profile.email,
              );

              if (context.mounted) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    content: const Text(
                      "Perfil actualizado",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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
