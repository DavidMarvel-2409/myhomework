import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone_latest/flutter_native_timezone_latest.dart';
import '../models/homework.dart';
import '../services/preferences_service.dart';

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

  static Future<void> _scheduleReminder(
    Homework task,
    int daysBefore,
    int hour,
    bool compact,
  ) async {
    final notificationDate = DateTime(
      task.dueDate.year,
      task.dueDate.month,
      task.dueDate.day - daysBefore,
      hour,
      0,
    );

    if (notificationDate.isBefore(DateTime.now())) {
      return;
    }

    final tzDate = tz.TZDateTime.from(notificationDate, tz.local);

    final body = _buildTaskBody(task, daysBefore, compact);

    final baseId = task.id.hashCode.abs() % 1000000;

    final notificationId = baseId + (daysBefore * 100) + hour;

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

  static Future<void> _scheduleMondaySummary(
    List<Homework> tasks,
    bool compact,
  ) async {
    final now = DateTime.now();

    final daysUntilMonday = (DateTime.monday - now.weekday + 7) % 7;

    var mondayDate = DateTime(
      now.year,
      now.month,
      now.day,
      9,
      0,
    ).add(Duration(days: daysUntilMonday));

    if (mondayDate.isBefore(now)) {
      mondayDate = mondayDate.add(const Duration(days: 7));
    }

    final weekTasks = tasks.where((task) {
      final due = DateTime(
        task.dueDate.year,
        task.dueDate.month,
        task.dueDate.day,
      );

      final monday = DateTime(
        mondayDate.year,
        mondayDate.month,
        mondayDate.day,
      );

      final endWeek = monday.add(const Duration(days: 7));

      return !due.isBefore(monday) && due.isBefore(endWeek);
    }).toList();

    debugPrint('Tareas para resumen lunes: ${weekTasks.length}');
    debugPrint('Resumen lunes programado para: $mondayDate');

    if (weekTasks.isEmpty) {
      return;
    }

    final body = weekTasks
        .map((t) => compact ? t.subject : '${t.subject}: ${t.title}')
        .join('\n');

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'weekly_channel',
          'Weekly Notifications',
          channelDescription: 'Resumen semanal',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _plugin.zonedSchedule(
      999001,
      'Tareas de esta semana',
      body,
      tz.TZDateTime.from(mondayDate, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> _scheduleSaturdaySummary(
    List<Homework> tasks,
    bool compact,
  ) async {
    final now = DateTime.now();

    final daysUntilSaturday = (DateTime.saturday - now.weekday + 7) % 7;

    var saturdayDate = DateTime(
      now.year,
      now.month,
      now.day,
      9,
      0,
    ).add(Duration(days: daysUntilSaturday));

    if (saturdayDate.isBefore(now)) {
      saturdayDate = saturdayDate.add(const Duration(days: 7));
    }

    final futureTasks = tasks.where((task) {
      final daysUntilDue = task.dueDate.difference(saturdayDate).inDays;

      return daysUntilDue > 7;
    }).toList();

    if (futureTasks.isEmpty) {
      return;
    }

    final body = futureTasks
        .map((t) => compact ? t.subject : '${t.subject}: ${t.title}')
        .join('\n');
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'weekly_channel',
          'Weekly Notifications',
          channelDescription: 'Resumen semanal',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    debugPrint('Resumen sábado programado para: $saturdayDate');

    await _plugin.zonedSchedule(
      999002,
      'Tareas a futuro',
      body,
      tz.TZDateTime.from(saturdayDate, tz.local),
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

  static Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }

  static Future<void> scheduleAllNotifications(
    List<Homework> tasks,
    bool compactMode,
  ) async {
    debugPrint('scheduleAllNotifications() tasks=${tasks.length}');
    await _plugin.cancelAll();
    final preferencesService = PreferencesService();
    final notificationsEnabled = await preferencesService
        .getNotificationsEnabled();
    if (!notificationsEnabled) {
      return;
    }
    final dailyReminderEnabled = await preferencesService
        .getDailyReminderEnabled();

    final now = DateTime.now();
    // final today = DateTime(now.year, now.month, now.day);

    if (dailyReminderEnabled) {
      for (final task in tasks) {
        final dueDate = task.dueDate;

        final daysUntilDue = dueDate.difference(now).inDays;

        if (daysUntilDue >= 2) {
          await _scheduleReminder(task, 2, 9, compactMode);
          await _scheduleReminder(task, 2, 19, compactMode);
        }

        if (daysUntilDue >= 1) {
          await _scheduleReminder(task, 1, 9, compactMode);
          await _scheduleReminder(task, 1, 19, compactMode);
        }

        if (daysUntilDue >= 0) {
          await _scheduleReminder(task, 0, 9, compactMode);
          await _scheduleReminder(task, 0, 19, compactMode);
        }
      }
    }
    debugPrint('scheduleAllNotifications()');
    debugPrint('notificationsEnabled = $notificationsEnabled');
    debugPrint('dailyReminderEnabled = $dailyReminderEnabled');

    await _scheduleMondaySummary(tasks, compactMode);
    await _scheduleSaturdaySummary(tasks, compactMode);
    await printPendingNotifications();
  }

  static String _buildTaskBody(Homework task, int daysBefore, bool compact) {
    final timeText = daysBefore == 0
        ? 'vence hoy'
        : daysBefore == 1
        ? 'vence mañana'
        : 'vence en $daysBefore días';

    if (compact) {
      return '${task.subject} - $timeText';
    }

    return '${task.subject} - ${task.title} $timeText';
  }
}
