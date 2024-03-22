import 'package:flutter/material.dart';
import 'package:modulo02/pages/andamento.dart';
import 'package:modulo02/pages/finalizar.dart';
import 'package:modulo02/pages/home.dart';
import 'package:modulo02/pages/iniciar.dart';
import 'package:modulo02/styles/styles.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Cores.ciano),
        useMaterial3: true,
      ),
      routes: {
        '/home': (context) => const Home(),
        Iniciar.routeName: (context) => const Iniciar(),
        Andamento.routeName: (context) => const Andamento(),
        Finalizar.routeName: (context) => const Finalizar(),
      },
      initialRoute: '/home',
    );
  }
}
