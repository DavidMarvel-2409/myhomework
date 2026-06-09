import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/homework.dart';

class HomeworkService {
  static const String tasksKey = 'tasks';

  Future<List<Homework>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(tasksKey);

    if (jsonString == null) {
      return [];
    }

    final List<dynamic> jsonList = jsonDecode(jsonString);

    return jsonList.map((task) => Homework.fromJson(task)).toList();
  }

  Future<void> saveTasks(List<Homework> tasks) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode(tasks.map((task) => task.toJson()).toList());

    await prefs.setString(tasksKey, jsonString);
  }
}
