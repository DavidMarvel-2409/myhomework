import 'package:flutter/material.dart';
import '../models/homework.dart';
import '../services/firestore_service.dart';
import '../services/profile_service.dart';

class HomeworkProvider extends ChangeNotifier {
  final FirestoreService _service = FirestoreService();
  final ProfileService _profileService = ProfileService();

  List<Homework> _tasks = [];
  String _userEmail = "";

  void setUserEmail(String email) {
    _userEmail = email;
  }

  List<Homework> get tasks => _tasks;

  Future<void> loadTasks() async {
    final profile = await _profileService.loadProfile();
    _tasks = await _service.getTasks(profile.email);
    _sortTasks();
    notifyListeners();
  }

  Future<void> addTask(Homework task) async {
    final profile = await _profileService.loadProfile();
    await _service.addTask(task, profile.email);
    await loadTasks();
  }

  Future<void> removeTask(int index) async {
    await _service.deleteTask(_userEmail, _tasks[index].id!);
    await loadTasks();
  }

  Future<void> updateTask(int index, Homework updatedTask) async {
    updatedTask.id = _tasks[index].id;
    await _service.updateTask(updatedTask, _userEmail);
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
