import 'package:flutter/material.dart';
import 'app.dart';
import 'services/notification_service.dart';
import 'package:provider/provider.dart';
import 'providers/preferences_provider.dart';
import 'services/preferences_service.dart';
import 'viewmodels/qa_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(PreferencesService()),
        ),
        ChangeNotifierProvider(create: (_) => QaViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}
