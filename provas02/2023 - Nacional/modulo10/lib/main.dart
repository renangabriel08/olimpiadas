import 'package:flutter/material.dart';
import 'package:modulo10/pages/configs.dart';
import 'package:modulo10/pages/sobre.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/configs': (context) => const Configs(),
        '/sobre': (context) => const Sobre(),
      },
      initialRoute: '/sobre',
    );
  }
}
