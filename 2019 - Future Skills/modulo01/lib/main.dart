import 'package:flutter/material.dart';
import 'package:modulo01/pages/cadastro.dart';
import 'package:modulo01/pages/login.dart';
import 'package:modulo01/pages/splash.dart';
import 'package:modulo01/pages/tutorial.dart';
import 'package:modulo01/styles/styles.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Cores.ciano),
        useMaterial3: true,
      ),
      routes: {
        '/splash': (context) => const Splash(),
        '/tutorial': (context) => const Tutorial(),
        '/login': (context) => const Login(),
        '/cadastro': (context) => const Cadastro(),
      },
      initialRoute: '/splash',
    );
  }
}
