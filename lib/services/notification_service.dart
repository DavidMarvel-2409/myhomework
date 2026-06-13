import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone_latest/flutter_native_timezone_latest.dart';
import '../models/homework.dart';

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

  static Future<void> _scheduleReminder(Homework task, int daysBefore) async {
    final notificationDate = DateTime(
      task.dueDate.year,
      task.dueDate.month,
      task.dueDate.day - daysBefore,
      9,
      0,
    );

    if (notificationDate.isBefore(DateTime.now())) {
      return;
    }

    final tzDate = tz.TZDateTime.from(notificationDate, tz.local);

    String body;

    if (daysBefore == 0) {
      body = '${task.subject} - ${task.title} vence hoy';
    } else if (daysBefore == 1) {
      body = '${task.subject} - ${task.title} vence mañana';
    } else {
      body = '${task.subject} - ${task.title} vence en $daysBefore días';
    }

    final notificationId = task.id.hashCode + daysBefore;

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

    await _plugin.zonedSchedule(
      notificationId,
      'Recordatorio de tarea',
      body,
      tzDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> printPendingNotifications() async {
    final pending = await _plugin.pendingNotificationRequests();

    debugPrint('Pendientes: ${pending.length}');

    for (final p in pending) {
      debugPrint('ID=${p.id} TITLE=${p.title}');
    }
  }

  static Future<void> scheduleAllNotifications(List<Homework> tasks) async {
    await _plugin.cancelAll();

    final now = DateTime.now();

    for (final task in tasks) {
      final dueDate = task.dueDate;

      final daysUntilDue = dueDate.difference(now).inDays;

      if (daysUntilDue >= 2) {
        await _scheduleReminder(task, 2);
      }

      if (daysUntilDue >= 1) {
        await _scheduleReminder(task, 1);
      }

      if (daysUntilDue >= 0) {
        await _scheduleReminder(task, 0);
      }
    }
  }
}
