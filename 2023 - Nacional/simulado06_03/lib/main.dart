import 'package:flutter/material.dart';
import 'package:simulado06_03/pages/home.dart';
import 'package:simulado06_03/pages/mapa.dart';
import 'package:simulado06_03/pages/perfil.dart';
import 'package:simulado06_03/styles/styles.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: CoresClaro.t1),
        useMaterial3: true,
      ),
      routes: {
        '/perfil': (context) => const Perfil(),
        '/home': (context) => const Home(),
        '/mapa': (context) => const Mapa(),
      },
      initialRoute: '/mapa',
    );
  }
}
