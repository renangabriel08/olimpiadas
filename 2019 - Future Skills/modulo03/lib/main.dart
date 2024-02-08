import 'package:flutter/material.dart';
import 'package:modulo03/pages/home.dart';
import 'package:modulo03/styles/styles.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Cores.verde),
        useMaterial3: true,
      ),
      routes: {
        '/home': (context) => const Home(),
      },
      initialRoute: '/home',
    );
  }
}
