import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyHomework',
      theme: ThemeData(
        primaryColor: Colors.blue,

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),

        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
