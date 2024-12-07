import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'pages/game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jeu du 2048',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: SplashScreen(), // Ecran de chargement
    );
  }
}
