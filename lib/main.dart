import 'package:flutter/material.dart';
import 'app.dart';
import 'services/notification_service.dart';
import 'package:provider/provider.dart';
import 'providers/preferences_provider.dart';
import 'services/preferences_service.dart';
import 'viewmodels/qa_viewmodel.dart';
import 'providers/homework_provider.dart';
import 'providers/profile_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(PreferencesService()),
        ),
        ChangeNotifierProvider(create: (_) => QaViewModel()),
        ChangeNotifierProvider(create: (_) => HomeworkProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
