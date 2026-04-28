import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyHomework',
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
