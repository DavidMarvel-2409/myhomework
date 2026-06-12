import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveProfile({
    required String uid,
    required String name,
    required String email,
  }) async {
    await _db.collection('users').doc(uid).set({'name': name, 'email': email});
  }

  Future<Map<String, dynamic>?> loadProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();

    if (!doc.exists) {
      return null;
    }

    return doc.data();
  }

  Future<String?> getUserName(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();

    if (!doc.exists) {
      return null;
    }

    return doc.data()?['name'];
  }

  Future<void> updateUserName({
    required String uid,
    required String name,
  }) async {
    await _db.collection('users').doc(uid).update({'name': name});
  }

  Future<Map<String, dynamic>?> getProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();

    if (!doc.exists) return null;

    return doc.data();
  }
}
