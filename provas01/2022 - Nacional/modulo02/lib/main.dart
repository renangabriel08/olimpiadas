import 'package:flutter/material.dart';
import 'package:modulo02/pages/andamento.dart';
import 'package:modulo02/pages/exercicio.dart';
import 'package:modulo02/pages/home.dart';
import 'package:modulo02/pages/progresso.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/home': (context) => const Home(),
        Exercicio.routeName: (context) => const Exercicio(),
        Andamento.routeName: (context) => const Andamento(),
        Progresso.routeName: (context) => const Progresso(),
      },
      initialRoute: '/home',
    );
  }
}
