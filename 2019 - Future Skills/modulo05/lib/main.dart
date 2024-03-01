import 'package:flutter/material.dart';
import 'package:modulo05/pages/relogio/erro.dart';
import 'package:modulo05/pages/relogio/login.dart';
import 'package:modulo05/pages/relogio/tarefa.dart';
import 'package:modulo05/pages/tv/login.dart';
import 'package:modulo05/pages/tv/mapa.dart';
import 'package:modulo05/pages/tv/splash.dart';
import 'package:modulo05/styles/styles.dart';

void main() {
  runApp(const MyApp());
}

final navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Cores.ciano),
        useMaterial3: true,
      ),
      routes: {
        //Relogio
        '/loginRelogio': (context) => const LoginRelogio(),
        '/erroRelogio': (context) => const ErroRelogio(),
        '/tarefasRelogio': (context) => const TarefaRelogio(),

        //Tv
        '/splash': (context) => const Splash(),
        '/loginTv': (context) => const LoginTv(),
        '/mapa': (context) => const Mapa()
      },
      initialRoute: width < 500.0 ? '/loginRelogio' : '/mapa',
    );
  }
}
