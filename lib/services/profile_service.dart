import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';

class ProfileService {
  static const String profileKey = 'user_profile';

  Future<UserProfile> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(profileKey);

    if (jsonString == null) {
      return UserProfile(
        name: "Nuevo Usuario",
        email: "nuevousuario@email.com",
      );
    }
    final json = jsonDecode(jsonString);
    return UserProfile.fromJson(json);
  }

  Future<void> saveProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(profileKey, jsonEncode(profile.toJson()));
  }
}
