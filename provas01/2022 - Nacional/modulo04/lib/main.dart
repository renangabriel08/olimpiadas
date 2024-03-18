import 'package:flutter/material.dart';
import 'package:modulo04/pages/cadastro.dart';
import 'package:modulo04/pages/produtos.dart';

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
        '/produtos': (context) => const Produtos(),
        '/cadastro': (context) => const Cadastro(),
      },
      initialRoute: '/produtos',
    );
  }
}
