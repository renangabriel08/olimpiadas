import 'package:flutter/material.dart';

class Cores {
  static Color azul = const Color(0xFF2ed9c3);
  static Color vermelho = const Color(0xFFff4438);
  static Color cinza = const Color(0xFF404041);
  static Color branco = const Color(0xFFFFFFFF);
}

class Fontes {
  static String fonte = 'MontserratAlternates';
}

class Textos {
  static getTxt(String txt, double size, Color cor) {
    return Text(
      txt,
      style: TextStyle(
        fontFamily: Fontes.fonte,
        fontSize: size,
        color: cor,
      ),
    );
  }
}
