class QaQuestion {
  final String category;
  final String title;
  final int value;
  final String minDescription;
  final String maxDescription;

  const QaQuestion({
    required this.category,
    required this.title,
    required this.value,
    required this.minDescription,
    required this.maxDescription,
  });

  factory QaQuestion.fromJson({
    required String category,
    required Map<String, dynamic> json,
  }) {
    return QaQuestion(
      category: category,
      title: json['titulo'] as String,
      value: json['valor'] as int,
      minDescription: json['min'] as String,
      maxDescription: json['max'] as String,
    );
  }

  QaQuestion copyWith({
    String? category,
    String? title,
    int? value,
    String? minDescription,
    String? maxDescription,
  }) {
    return QaQuestion(
      category: category ?? this.category,
      title: title ?? this.title,
      value: value ?? this.value,
      minDescription: minDescription ?? this.minDescription,
      maxDescription: maxDescription ?? this.maxDescription,
    );
  }
}
