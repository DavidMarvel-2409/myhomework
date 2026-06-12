import 'package:flutter/material.dart';
import '../models/homework.dart';
import '../services/firestore_service.dart';
import '../services/profile_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeworkProvider extends ChangeNotifier {
  final FirestoreService _service = FirestoreService();
  final ProfileService _profileService = ProfileService();

  List<Homework> _tasks = [];

  List<Homework> get tasks => _tasks;

  Future<void> loadTasks() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    _tasks = await _service.getTasks(user.email!);
    _sortTasks();
    notifyListeners();
  }

  Future<void> addTask(Homework task) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await _service.addTask(task, user.email!);
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
      if (dateComparison != 0) {
        return dateComparison;
      }
      return a.title.compareTo(b.title);
    });
  }
}
