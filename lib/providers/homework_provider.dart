import 'package:flutter/material.dart';

import '../models/homework.dart';
import '../services/homework_service.dart';

class HomeworkProvider extends ChangeNotifier {
  final HomeworkService _service = HomeworkService();

  List<Homework> _tasks = [];

  List<Homework> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await _service.loadTasks();
    notifyListeners();
  }

  Future<void> addTask(Homework task) async {
    _tasks.add(task);

    await _service.saveTasks(_tasks);

    notifyListeners();
  }

  Future<void> removeTask(int index) async {
    _tasks.removeAt(index);

    await _service.saveTasks(_tasks);

    notifyListeners();
  }
}
