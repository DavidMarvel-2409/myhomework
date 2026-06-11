import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/homework.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTask(Homework task, String userEmail) async {
    await _db.collection('tasks').add({
      'userEmail': userEmail,
      'title': task.title,
      'subject': task.subject,
      'description': task.description,
      'dueDate': task.dueDate.toIso8601String(),
    });
  }

  Future<List<Homework>> getTasks(String userEmail) async {
    final snapshot = await _db
        .collection('tasks')
        .where('userEmail', isEqualTo: userEmail)
        .get();
    return snapshot.docs.map((doc) {
      return Homework.fromJson(doc.data(), doc.id);
    }).toList();
  }

  Future<void> deleteTask(String email, String id) async {
    await _db
        .collection('users')
        .doc(email)
        .collection('tasks')
        .doc(id)
        .delete();
  }

  Future<void> updateTask(Homework task, String email) async {
    await _db
        .collection('users')
        .doc(email)
        .collection('tasks')
        .doc(task.id)
        .update(task.toJson());
  }
}
