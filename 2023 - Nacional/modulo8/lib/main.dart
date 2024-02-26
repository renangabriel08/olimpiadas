import 'package:flutter/material.dart';
import 'package:modulo8/pages/lista.dart';
import 'package:modulo8/pages/mapa.dart';
import 'package:modulo8/pages/ofertas.dart';

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
        '/ofertas': (context) => const Ofertas(),
        '/mapa': (context) => const Mapa(),
        Lista.routeName: (context) => const Lista(),
      },
      initialRoute: '/ofertas',
    );
  }
}
