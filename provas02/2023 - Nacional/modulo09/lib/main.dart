import 'package:flutter/material.dart';
import 'package:modulo09/pages/cadastro.dart';
import 'package:modulo09/pages/lista.dart';
import 'package:modulo09/styles/styles.dart';

void main() {
  runApp(const MyApp());
}

final navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Cores.verdeEscuro),
        useMaterial3: true,
      ),
      routes: {
        '/lista': (context) => const Lista(),
        '/cadastro': (context) => const Cadastro(),
      },
      initialRoute: '/cadastro',
    );
  }
}
