import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modulo04/firebase_options.dart';
import 'package:modulo04/pages/esqSenha.dart';
import 'package:modulo04/pages/perfil.dart';
import 'package:modulo04/pages/tarefa.dart';
import 'package:modulo04/styles/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Cores.verde),
        useMaterial3: true,
      ),
      routes: {
        '/perfil': (context) => const Perfil(),
        '/esqSenha': (context) => const EsqSenha(),
        '/tarefa': (context) => const Tarefa(),
      },
      initialRoute: '/tarefa',
    );
  }
}
