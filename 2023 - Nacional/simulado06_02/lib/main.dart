import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simulado06_02/pages/cadastro.dart';
import 'package:simulado06_02/pages/home.dart';
import 'package:simulado06_02/pages/login.dart';
import 'package:simulado06_02/pages/splash.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/splash': (context) => const Splash(),
        '/cadastro': (context) => const Cadastro(),
        '/login': (context) => const Login(),
        '/home': (context) => const Home(),
      },
      initialRoute: '/home',
    );
  }
}
