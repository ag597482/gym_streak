import 'package:flutter/material.dart';
import 'package:gym_streak/screens/exersises.dart';
import 'package:gym_streak/screens/splash.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          'list': (context) => SiteAbooutScreen(),
        });
  }
}
