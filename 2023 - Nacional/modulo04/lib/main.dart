import 'package:flutter/material.dart';
import 'package:modulo04/pages/inicio.dart';

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
        '/inicio': (context) => Inicio(),
      },
      initialRoute: '/inicio',
    );
  }
}
