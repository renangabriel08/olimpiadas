import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modulo07/firebase_options.dart';
import 'package:modulo07/pages/criar_avaliacao.dart';
import 'package:modulo07/styles/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Cores.azulEscuro),
        useMaterial3: true,
      ),
      routes: {
        '/criarAvaliacao': (context) => CriarAvaliacao(),
      },
      initialRoute: '/criarAvaliacao',
    );
  }
}
