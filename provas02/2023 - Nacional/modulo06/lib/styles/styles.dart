import 'package:flutter/material.dart';

class Cores {
  static Color azulEscuro = const Color(0xFF);
  static Color azulClaro = const Color(0xFF);
  static Color verdeEscuro = const Color(0xFF);
  static Color verdeMedio = const Color(0xFF);
  static Color verdeClaro = const Color(0xFF);
  static Color branco = const Color(0xFFFFFFFF);
}

class Fonts {
  static String font = 'MontserratAlternates';
}

class Textos {
  static padrao(String txt, TextAlign textAlign, Color cor) {
    return Text(
      txt,
      textAlign: textAlign,
      style: TextStyle(
        color: cor,
        fontFamily: Fonts.font,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
    );
  }

  static subtitulo(String txt, TextAlign textAlign, Color cor) {
    return Text(
      txt,
      textAlign: textAlign,
      style: TextStyle(
        color: cor,
        fontFamily: Fonts.font,
        fontWeight: FontWeight.normal,
        fontSize: 32,
      ),
    );
  }

  static titulo(String txt, TextAlign textAlign, Color cor) {
    return Text(
      txt,
      textAlign: textAlign,
      style: TextStyle(
        color: cor,
        fontFamily: Fonts.font,
        fontWeight: FontWeight.normal,
        fontSize: 48,
      ),
    );
  }
}
