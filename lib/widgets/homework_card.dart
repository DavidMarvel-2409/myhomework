import 'package:flutter/material.dart';

class HomeworkCard extends StatelessWidget {
  final String title;
  final String subject;
  final String date;
  final VoidCallback onTap;

  const HomeworkCard({
    super.key,
    required this.title,
    required this.subject,
    required this.date,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subject),
        trailing: Text(date),
        onTap: onTap,
      ),
    );
  }
}
