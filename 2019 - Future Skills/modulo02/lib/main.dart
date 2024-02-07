import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modulo02/pages/bussola.dart';
import 'package:modulo02/pages/comentarios.dart';
import 'package:modulo02/pages/home.dart';
import 'package:modulo02/styles/styles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
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
        '/bussola': (context) => const Bussola(),
        Comentarios.routeName: (context) => const Comentarios(),
      },
      initialRoute: '/home',
    );
  }
}
