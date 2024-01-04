import 'package:flutter/material.dart';
import 'package:modulo03/pages/home.dart';
import 'package:modulo03/pages/quiz.dart';
import 'package:modulo03/pages/troca.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const Home(),
        '/quiz': (context) => const Quiz(),
        '/troca': (context) => const Troca(),
      },
      initialRoute: '/home',
    );
  }
}
