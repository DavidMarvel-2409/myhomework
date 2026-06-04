import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/preferences_provider.dart';
import '../widgets/app_drawer.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('Preferencias')),
      body: Consumer<PreferencesProvider>(
        builder: (context, preferencesProvider, child) {
          if (preferencesProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Preferencias de Usuario',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: TextEditingController(
                      text: preferencesProvider.userName,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Nombre de Usuario',
                      prefixIcon: Icon(Icons.person),
                    ),
                    onSubmitted: preferencesProvider.updateUserName,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Card(
                child: SwitchListTile(
                  activeThumbColor: colors.primary,
                  activeTrackColor: colors.tertiary,
                  title: const Text('Notificaciones'),
                  subtitle: const Text('Recibir avisos de tareas pendientes'),
                  secondary: const Icon(Icons.notifications),
                  value: preferencesProvider.notificationsEnabled,
                  onChanged: preferencesProvider.updateNotificationsEnabled,
                ),
              ),

              Card(
                child: SwitchListTile(
                  activeThumbColor: colors.primary,
                  activeTrackColor: colors.tertiary,
                  title: const Text('Recordatorio diario'),
                  subtitle: const Text('Mostrar recordatorios cada día'),
                  secondary: const Icon(Icons.schedule),
                  value: preferencesProvider.dailyReminderEnabled,
                  onChanged: preferencesProvider.updateDailyReminderEnabled,
                ),
              ),

              Card(
                child: SwitchListTile(
                  activeThumbColor: colors.primary,
                  activeTrackColor: colors.tertiary,
                  title: const Text('Modo compacto'),
                  subtitle: const Text(
                    'Reducir el espacio visual de las listas',
                  ),
                  secondary: const Icon(Icons.view_agenda),
                  value: preferencesProvider.compactModeEnabled,
                  onChanged: preferencesProvider.updateCompactModeEnabled,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Los cambios se guardan automáticamente.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          );
        },
      ),
    );
  }
}
