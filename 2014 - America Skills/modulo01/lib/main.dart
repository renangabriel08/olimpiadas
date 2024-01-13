import 'package:flutter/material.dart';
import 'package:modulo01/controllers/notificacao.dart';
import 'package:modulo01/pages/desejos.dart';
import 'package:modulo01/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Notificar.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const Home(),
        '/desejos': (context) => const Desejos(),
      },
      initialRoute: '/home',
    );
  }
}
