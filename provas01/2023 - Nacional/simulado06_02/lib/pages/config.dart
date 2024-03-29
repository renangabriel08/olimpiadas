import 'package:flutter/material.dart';
import 'package:simulado06_02/styles/styles.dart';

class Configs extends StatelessWidget {
  const Configs({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Textos.titulo('Tela de Configurações'),
        ),
      ),
    );
  }
}