import 'package:flutter/material.dart';
import 'package:modulo03/pages/cadastro.dart';
import 'package:modulo03/pages/home.dart';
import 'package:modulo03/pages/login.dart';
import 'package:modulo03/pages/splash.dart';
import 'package:modulo03/styles/styles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

final navKey = GlobalKey<NavigatorState>();

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
      navigatorKey: navKey,
      routes: {
        '/login': (context) => const Login(),
        '/cadastro': (context) => const Cadastro(),
        '/home': (context) => const Home(),
        '/splash': (context) => const Splash(),
      },
      initialRoute: '/splash',
    );
  }
}
