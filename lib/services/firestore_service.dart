import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/homework.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> addTask(Homework task, String userEmail) async {
    final docRef = await _db.collection('tasks').add({
      'userEmail': userEmail,
      'title': task.title,
      'subject': task.subject,
      'description': task.description,
      'dueDate': task.dueDate.toIso8601String(),
    });
    return docRef.id;
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

  Future<void> deleteTask(String id) async {
    await _db.collection('tasks').doc(id).delete();
  }

  Future<void> updateTask(Homework task) async {
    await _db.collection('tasks').doc(task.id).update(task.toJson());
  }

  int notificationIdFromTask(String taskId) {
    return taskId.hashCode.abs();
  }
}
