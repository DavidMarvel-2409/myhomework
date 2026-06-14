import 'package:flutter/material.dart';
import '../services/preferences_service.dart';
import 'homework_provider.dart';
import '../services/notification_service.dart';

class PreferencesProvider extends ChangeNotifier {
  final PreferencesService _preferencesService;

  HomeworkProvider _homeworkProvider;

  PreferencesProvider(this._preferencesService, this._homeworkProvider) {
    loadPreferences();
  }
  void updateHomeworkProvider(HomeworkProvider provider) {
    _homeworkProvider = provider;
  }

  bool _notificationsEnabled = true;
  bool _dailyReminderEnabled = false;
  bool _compactModeEnabled = false;
  String _userName = 'Usuario';
  bool _isLoading = true;

  bool get notificationsEnabled => _notificationsEnabled;
  bool get dailyReminderEnabled => _dailyReminderEnabled;
  bool get compactModeEnabled => _compactModeEnabled;
  String get userName => _userName;
  bool get isLoading => _isLoading;

  Future<void> loadPreferences() async {
    _isLoading = true;
    notifyListeners();

    _notificationsEnabled = await _preferencesService.getNotificationsEnabled();
    _dailyReminderEnabled = await _preferencesService.getDailyReminderEnabled();
    _compactModeEnabled = await _preferencesService.getCompactModeEnabled();
    _userName = await _preferencesService.getUserName();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateNotificationsEnabled(bool value) async {
    debugPrint('Notifications Enabled = $value');
    _notificationsEnabled = value;
    notifyListeners();
    await _preferencesService.setNotificationsEnabled(value);
    await _homeworkProvider.refreshNotifications();
  }

  Future<void> updateDailyReminderEnabled(bool value) async {
    debugPrint('Daily Reminder Enabled = $value');
    _dailyReminderEnabled = value;
    notifyListeners();
    await _preferencesService.setDailyReminderEnabled(value);
    await _homeworkProvider.refreshNotifications();
  }

  Future<void> updateCompactModeEnabled(bool value) async {
    _compactModeEnabled = value;
    notifyListeners();

    await _preferencesService.setCompactModeEnabled(value);
  }

  Future<void> updateUserName(String value) async {
    _userName = value;
    notifyListeners();

    await _preferencesService.setUserName(value);
  }
}
