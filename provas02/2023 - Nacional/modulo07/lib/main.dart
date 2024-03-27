import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modulo07/firebase_options.dart';
import 'package:modulo07/pages/cadastro.dart';
import 'package:modulo07/pages/lista.dart';
import 'package:modulo07/styles/styles.dart';

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
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Cores.verdeEscuro),
        useMaterial3: true,
      ),
      routes: {
        '/cadastro': (context) => const Cadastro(),
        '/lista': (context) => const Lista(),
      },
      initialRoute: '/cadastro',
    );
  }
}
