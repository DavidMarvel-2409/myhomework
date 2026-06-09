import 'package:flutter/material.dart';

import '../models/homework.dart';
import '../services/homework_service.dart';

class HomeworkProvider extends ChangeNotifier {
  final HomeworkService _service = HomeworkService();

  List<Homework> _tasks = [];

  List<Homework> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await _service.loadTasks();
    _sortTasks();
    notifyListeners();
  }

  Future<void> addTask(Homework task) async {
    _tasks.add(task);
    _sortTasks();
    await _service.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> removeTask(int index) async {
    _tasks.removeAt(index);
    await _service.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> updateTask(int index, Homework updatedTask) async {
    _tasks[index] = updatedTask;
    _sortTasks();
    await _service.saveTasks(_tasks);
    notifyListeners();
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
