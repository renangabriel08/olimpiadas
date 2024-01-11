import 'package:flutter/material.dart';
import 'package:modulo01/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home' : (context) => const Home(),
      },
      initialRoute: '/home',
    );
  }
}