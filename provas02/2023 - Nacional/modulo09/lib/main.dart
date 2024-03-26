import 'package:flutter/material.dart';
import 'package:modulo09/pages/cadastro.dart';
import 'package:modulo09/pages/lista.dart';
import 'package:modulo09/styles/styles.dart';
import 'package:quick_actions/quick_actions.dart';

void main() {
  runApp(const MyApp());
}

final navKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final QuickActions quickActions = const QuickActions();
  @override
  void initState() {
    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'action_lista',
        localizedTitle: 'Reclamações',
        icon: 'icon_main',
      ),
      const ShortcutItem(
        type: 'action_rec',
        localizedTitle: 'Registro',
        icon: 'icon_help',
      )
    ]);

    quickActions.initialize((shortcutType) {
      if (shortcutType == 'action_lista') {
        navKey.currentState!.pushNamed('/lista');
      }
      if (shortcutType == 'action_rec') {
        navKey.currentState!.pushNamed('/cadastro');
      }
      // More handling code...
    });

    super.initState();
  }

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
        '/lista': (context) => const Lista(),
        '/cadastro': (context) => const Cadastro(),
      },
      initialRoute: '/lista',
    );
  }
}
