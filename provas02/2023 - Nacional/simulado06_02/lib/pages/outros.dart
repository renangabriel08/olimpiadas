import 'package:flutter/material.dart';
import 'package:simulado06_02/styles/styles.dart';

class Outros extends StatelessWidget {
  final String txt;
  const Outros({super.key, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Textos(
          txt: txt,
          textAlign: TextAlign.center,
          cor: Cores.cinza,
          size: 30,
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}
