import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class NotificationPoCScreen extends StatelessWidget {
  const NotificationPoCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PoC Notificaciones")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            print("BOTON PRESIONADO");
            await NotificationService.showTestNotification();

            print("NOTIFICACION ENVIADA");

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Notificación enviada")),
            );
          },
          child: const Text("Disparar notificación"),
        ),
      ),
    );
  }
}
