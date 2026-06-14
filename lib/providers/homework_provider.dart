import 'package:flutter/material.dart';
import '../models/homework.dart';
import '../services/firestore_service.dart';
import '../services/preferences_service.dart';
import '../services/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeworkProvider extends ChangeNotifier {
  final FirestoreService _service = FirestoreService();
  final PreferencesService _preferencesService = PreferencesService();

  List<Homework> _tasks = [];
  bool _compactMode = false;

  List<Homework> get tasks => _tasks;
  bool get compactMode => _compactMode;

  Future<void> loadTasks() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    _tasks = await _service.getTasks(user.email!);
    _sortTasks();
    _compactMode = await _preferencesService.getCompactModeEnabled();
    await NotificationService.scheduleAllNotifications(_tasks, _compactMode);
    await NotificationService.printPendingNotifications();
    notifyListeners();
  }

  Future<void> refreshNotifications() async {
    debugPrint('refreshNotifications tasks=${_tasks.length}');
    _compactMode = await _preferencesService.getCompactModeEnabled();
    await NotificationService.scheduleAllNotifications(_tasks, _compactMode);
  }

  Future<void> addTask(Homework task) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final taskId = await _service.addTask(task, user.email!);
    task.id = taskId;
    await loadTasks();
  }

  Future<void> removeTask(int index) async {
    await _service.deleteTask(_tasks[index].id!);
    await loadTasks();
  }

  Future<void> updateTask(int index, Homework updatedTask) async {
    updatedTask.id = _tasks[index].id;
    await _service.updateTask(updatedTask);
    await loadTasks();
  }

  void _sortTasks() {
    _tasks.sort((a, b) {
      final dateComparison = a.dueDate.compareTo(b.dueDate);
      if (dateComparison != 0) return dateComparison;
      return a.title.compareTo(b.title);
    });
  }
}
