import 'package:flutter/material.dart';
import 'package:modulo05/pages/home.dart';
import 'package:modulo05/styles/styles.dart';

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
        '/home': (context) => const Home(),
      },
      initialRoute: '/home',
    );
  }
}
