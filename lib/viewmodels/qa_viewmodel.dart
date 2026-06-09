import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/qa_question.dart';

class QaViewModel extends ChangeNotifier {
  final List<QaQuestion> _questions = [];
  bool _isLoading = false;

  List<QaQuestion> get questions => List.unmodifiable(_questions);
  bool get isLoading => _isLoading;

  bool get hasQuestions => _questions.isNotEmpty;

  bool get allQuestionsAnswered {
    return _questions.every((question) => question.value > 0);
  }

  Future<void> loadQuestions() async {
    _isLoading = true;
    notifyListeners();

    final jsonString = await rootBundle.loadString(
      'assets/data/qa_questions.json',
    );

    final Map<String, dynamic> jsonData = json.decode(jsonString);

    _questions.clear();

    for (final entry in jsonData.entries) {
      final category = entry.key;
      final questionsJson = entry.value as List<dynamic>;

      for (final questionJson in questionsJson) {
        _questions.add(
          QaQuestion.fromJson(
            category: category,
            json: questionJson as Map<String, dynamic>,
          ),
        );
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  void updateAnswer(int index, int value) {
    if (index < 0 || index >= _questions.length) {
      return;
    }

    _questions[index] = _questions[index].copyWith(value: value);
    notifyListeners();
  }

  String buildEmailMessage() {
    final buffer = StringBuffer();

    buffer.writeln('Reporte de valoración de MyHomework');
    buffer.writeln('');
    buffer.writeln('Respuestas:');
    buffer.writeln('');

    for (final question in _questions) {
      buffer.writeln(question.category.toUpperCase());
      buffer.writeln(question.title);
      buffer.writeln('Valoración: ${question.value}/5');
      buffer.writeln('');
    }

    return buffer.toString();
  }
}
