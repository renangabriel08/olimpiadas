import 'package:flutter/material.dart';

class Cores {
  static Color ciano = const Color(0xFF00E1C2);
  static Color cinza = const Color(0xFF2C2C2D);
  static Color vermelho = const Color(0xFFE10051);
  static Color azul = const Color(0xFF0068E1);
  static Color preto = const Color(0xFF171717);
  static Color branco = const Color(0xFFFFFFFF);
}

class Fonts {
  static String font = 'MontserratAlternates';
}

class Textos {
  static txt(
    String data,
    double size,
    TextAlign txtAlign,
    Color cor,
    FontWeight fontWeight,
  ) {
    return Text(
      data,
      textAlign: txtAlign,
      style: TextStyle(
        fontFamily: Fonts.font,
        fontSize: size,
        color: cor,
        fontWeight: fontWeight,
      ),
    );
  }
}
