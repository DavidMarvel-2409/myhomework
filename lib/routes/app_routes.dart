import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/create_screen.dart';
import '../screens/detail_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    '/': (context) => HomeScreen(),
    '/create': (context) => CreateScreen(),
    '/detail': (context) => DetailScreen(),
  };
}
