import 'package:flutter/material.dart';
import 'package:modulo05/pages/padrao/config.dart';
import 'package:modulo05/pages/padrao/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/homePadrao': (context) => const HomePadrao(),
        '/configPadrao': (context) => const ConfigPadrao(),
      },
      initialRoute: '/configPadrao',
    );
  }
}
