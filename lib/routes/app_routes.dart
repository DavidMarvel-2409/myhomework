import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/create_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/calendar_detail_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/about_screen.dart';
import '../screens/help_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    '/': (context) => const SplashScreen(),
    '/home': (context) => const HomeScreen(),
    '/create': (context) => CreateScreen(),
    '/detail': (context) => DetailScreen(),
    '/calendar_detail': (context) => CalendarDetailScreen(),
    '/profile': (context) => const ProfileScreen(),
    '/about': (context) => const AboutScreen(),
    '/help': (context) => const HelpScreen(),
  };
}
