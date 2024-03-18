import 'package:flutter/material.dart';

class Cores {
  static Color verde = const Color(0xFF00E1C2);
  static Color cinza1 = const Color(0xFF2C2C2D);
  static Color preto = const Color(0xFF171717);
  static Color amarelo = const Color(0xFFDDE100);
  static Color vermelho = const Color(0xFFE10051);
  static Color cinza2 = const Color(0xFFD6E1E0);
  static Color azul = const Color(0xFF0068E1);
  static Color branco = const Color(0xFFFFFFFF);
}

class Fontes {
  static String fonte = 'MontserratAlternates';
}

class Textos {
  static rText(String txt, double size, FontWeight weight, Color cor) {
    return Text(
      txt,
      style: TextStyle(
        fontFamily: Fontes.fonte,
        fontSize: size,
        fontWeight: weight,
        color: cor,
      ),
    );
  }
}
