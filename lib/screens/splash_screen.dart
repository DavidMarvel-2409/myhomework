import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/app_drawer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home');
    });

    return Scaffold(
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/app_icon.png', width: 120, height: 120),
            SizedBox(height: 20),
            Text("MyHomework", style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
