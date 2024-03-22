import 'package:flutter/material.dart';
import 'package:modulo01/pages/login.dart';
import 'package:modulo01/pages/splash.dart';
import 'package:modulo01/styles/styles.dart';

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
        '/splash': (context) => const Splash(),
        '/login': (context) => const Login(),
      },
      initialRoute: '/splash',
    );
  }
}
