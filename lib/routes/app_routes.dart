import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/create_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/calendar_detail_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    '/': (context) => HomeScreen(),
    '/create': (context) => CreateScreen(),
    '/detail': (context) => DetailScreen(),
    '/calendar_detail': (context) => CalendarDetailScreen(),
  };
}
