import 'package:flutter/material.dart';

class Cores {
  static Color verdeEscuro = const Color(0xFF62c285);
  static Color verdeMedio = const Color(0xFF86d35a);
  static Color verdeClaro = const Color(0xFFabe52f);
  static Color azulEscuro = const Color(0xFF283b87);
  static Color azulClaro = const Color(0xFF3eb1b1);
  static Color branco = const Color(0xFFFFFFFF);
}

class Textos {
  static padrao(String txt, TextAlign textAlign, Color cor) {
    return Text(
      txt,
      textAlign: textAlign,
      style: TextStyle(
        color: cor,
        fontFamily: Fonts.font,
        fontSize: 16,
        fontWeight: FontWeight.normal,
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
        fontSize: 32,
        fontWeight: FontWeight.normal,
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
        fontSize: 48,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class Fonts {
  static String font = 'MontserratAlternates';
}
