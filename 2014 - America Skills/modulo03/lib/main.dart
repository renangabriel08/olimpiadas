import 'package:flutter/material.dart';
import 'package:modulo03/pages/home.dart';
import 'package:modulo03/pages/jogo.dart';
import 'package:modulo03/pages/scores.dart';

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
        '/home' :(context) => const Home(),
        '/jogo' :(context) => const Jogo(),
        Scores.routeName :(context) => const Scores(),
      },
      initialRoute: '/home',
    );
  }
}