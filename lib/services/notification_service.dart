import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone_latest/flutter_native_timezone_latest.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );
    await _plugin.initialize(settings);
    await _plugin.cancelAll();
    tz.initializeTimeZones();

    final String timeZoneName =
        await FlutterNativeTimezoneLatest.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(timeZoneName));

    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.requestNotificationsPermission();
    await androidPlugin?.requestExactAlarmsPermission();
  }

  static Future<void> showTestNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'poc_channel',
          'PoC Notifications',
          channelDescription: 'Canal de pruebas',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _plugin.show(
      0,
      'Prueba PoC',
      'La notificación funciona correctamente',
      details,
    );
  }

  static Future<void> cancelTaskNotification(int notificationId) async {
    await _plugin.cancel(notificationId);
  }

  static Future<void> scheduleTaskNotification({
    required int notificationId,
    required String title,
    required String subject,
    required DateTime dueDate,
  }) async {
    // final scheduledDate = DateTime(
    //   dueDate.year,
    //   dueDate.month,
    //   dueDate.day - 1,
    //   9,
    //   0,
    // );
    // final scheduledDate = DateTime.now().add(const Duration(seconds: 20));
    final tzDate = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 20));
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'task_channel',
          'Task Notifications',
          channelDescription: 'Recordatorios de tareas',
          importance: Importance.max,
          priority: Priority.high,
        );
    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );
    debugPrint('================================');
    debugPrint('Programando notificación');
    debugPrint('notificationId: $notificationId');
    // debugPrint('scheduledDate: $scheduledDate');
    debugPrint('tzDate: $tzDate');
    debugPrint('now: ${DateTime.now()}');
    debugPrint('================================');
    await _plugin.zonedSchedule(
      notificationId,
      'Tarea próxima a vencer',
      '$subject - $title vence mañana',
      tzDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    debugPrint('Notificación programada correctamente');

    final pending = await _plugin.pendingNotificationRequests();
    for (final notification in pending) {
      debugPrint(
        'ID=${notification.id} '
        'TITLE=${notification.title}',
      );
    }
  }

  static Future<void> printPendingNotifications() async {
    final pending = await _plugin.pendingNotificationRequests();

    debugPrint('Pendientes: ${pending.length}');

    for (final p in pending) {
      debugPrint('ID=${p.id} TITLE=${p.title}');
    }
  }
}
