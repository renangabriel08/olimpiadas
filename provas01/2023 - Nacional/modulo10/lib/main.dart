import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:modulo10/firebase_options.dart';
import 'package:modulo10/pages/config.dart';
import 'package:modulo10/pages/home.dart';
import 'package:modulo10/pages/sobre.dart';
import 'package:modulo10/styles/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final notificationSettings =
      await FirebaseMessaging.instance.requestPermission(provisional: true);

  final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
  if (apnsToken != null) {
    print(apnsToken);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Cores.t1),
        useMaterial3: true,
      ),
      routes: {
        '/config': (context) => const Configs(),
        '/sobre': (context) => const Sobre(),
        '/home': (context) => const Home(),
      },
      initialRoute: '/home',
    );
  }
}
