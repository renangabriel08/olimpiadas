import 'package:flutter/material.dart';
import 'package:modulo06/pages/viajante.dart';
import 'package:modulo06/styles/styles.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Cores.azul1),
        useMaterial3: true,
      ),
      routes: {
        '/viajante': (context) => const Viajante(),
      },
      initialRoute: '/viajante',
    );
  }
}
