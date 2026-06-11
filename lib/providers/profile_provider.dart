import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _service = ProfileService();

  UserProfile profile = UserProfile(
    name: "Usuario",
    email: "usuario@email.com",
  );
  String get email => profile.email;
  String get name => profile.name;

  Future<void> loadProfile() async {
    profile = await _service.loadProfile();
    notifyListeners();
  }

  Future<void> updateProfile(String name, String email) async {
    profile = UserProfile(name: name, email: email);
    await _service.saveProfile(profile);
    notifyListeners();
  }
}
