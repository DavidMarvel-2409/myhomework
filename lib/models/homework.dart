class Homework {
  String title;
  String description;
  String subject;
  DateTime dueDate;

  Homework({
    required this.title,
    required this.description,
    required this.subject,
    required this.dueDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'subject': subject,
      'dueDate': dueDate.toIso8601String(),
    };
  }

  factory Homework.fromJson(Map<String, dynamic> json) {
    return Homework(
      title: json['title'],
      description: json['description'],
      subject: json['subject'],
      dueDate: DateTime.parse(json['dueDate']),
    );
  }
}
