import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/preferences_provider.dart';
import '../widgets/app_drawer.dart';
import '../providers/homework_provider.dart';
import '../services/notification_service.dart';

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

              const SizedBox(height: 12),

              Card(
                child: SwitchListTile(
                  activeThumbColor: colors.primary,
                  activeTrackColor: colors.tertiary,
                  title: const Text('Notificaciones'),
                  subtitle: const Text('Recibir avisos de tareas pendientes'),
                  secondary: const Icon(Icons.notifications),
                  value: preferencesProvider.notificationsEnabled,
                  onChanged: (value) async {
                    await preferencesProvider.updateNotificationsEnabled(value);

                    if (!value) {
                      await NotificationService.cancelAllNotifications();
                    } else {
                      await context.read<HomeworkProvider>().loadTasks();
                    }
                  },
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
