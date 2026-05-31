import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyHomework',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 60, 112, 158),
        primaryColor: const Color.fromARGB(255, 29, 111, 158),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6BAED6),
          primary: const Color(0xFF6BAED6),
          secondary: const Color.fromARGB(255, 91, 154, 184),
          tertiary: const Color(0xFFBDE0FE),
          surface: const Color(0xFFEAF6FF),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 5, 78, 121),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 3, 62, 97),
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
          bodySmall: TextStyle(color: Colors.white),
        ),
        cardTheme: const CardThemeData(
          color: Color.fromARGB(255, 86, 153, 184),
        ),
        listTileTheme: const ListTileThemeData(
          textColor: Colors.white,
          iconColor: Colors.white,
        ),
        drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFF8ECAE6)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 13, 102, 154),
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        expansionTileTheme: const ExpansionTileThemeData(
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          textColor: Colors.white,
          collapsedTextColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
