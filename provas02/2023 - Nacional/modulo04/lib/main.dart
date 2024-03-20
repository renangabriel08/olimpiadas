import 'package:flutter/material.dart';
import 'package:modulo04/pages/inicio.dart';
import 'package:modulo04/pages/login.dart';
import 'package:modulo04/styles/styles.dart';

void main() {
  runApp(const MyApp());
}

final navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Cores.verdeEscuro),
        useMaterial3: true,
      ),
      routes: {
        '/login': (context) => const Login(),
        '/inicio': (context) => const Inicio(),
      },
      initialRoute: '/login',
    );
  }
}
