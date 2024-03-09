import 'package:flutter/material.dart';
import 'package:modulo09/pages/cadastro.dart';
import 'package:modulo09/pages/lista.dart';
import 'package:modulo09/styles/styles.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Cores.verde3),
        useMaterial3: true,
      ),
      routes: {
        '/lista': (context) => const Lista(),
        '/cadastro': (context) => const Cadastro(),
      },
      initialRoute: '/lista',
    );
  }
}
