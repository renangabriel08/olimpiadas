import 'package:flutter/material.dart';
import 'package:modulo04/pages/inicio.dart';
import 'package:modulo04/pages/login.dart';

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
       Inicio.routeName :(context) => const Inicio(),
        '/login': (context) => const Login(),
      },
      initialRoute: '/login',
    );
  }
}
