import 'package:flutter/material.dart';
import 'package:simulado06_02/pages/login.dart';
import 'package:simulado06_02/pages/splash.dart';
import 'package:simulado06_02/styles/styles.dart';

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
