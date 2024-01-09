import 'package:flutter/material.dart';
import 'package:modulo04/pages/config.dart';
import 'package:modulo04/pages/home.dart';
import 'package:modulo04/pages/jogo.dart';

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
        '/config': (context) => const Config(),
        '/jogo': (context) => const Jogo(),
      },
      initialRoute: '/home',
    );
  }
}
