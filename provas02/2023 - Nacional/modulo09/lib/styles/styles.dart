import 'package:flutter/material.dart';

class Cores {
  static Color azulEscuro = const Color(0xFF283B87);
  static Color azulClaro = const Color(0xFF3EB1B1);
  static Color verdeEscuro = const Color(0xFF62C285);
  static Color verdeClaro = const Color(0xFFABE52F);
  static Color verdeMedio = const Color(0xFF86D35A);
  static Color branco = const Color(0xFFFFFFFF);
}

class Fonts {
  static String font = 'MontserratAlternates';
}

class Textos {
  static txt1(String txt, TextAlign textAlign, Color cor) {
    return Text(
      txt,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: Fonts.font,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: cor,
      ),
    );
  }

  static txt2(String txt, TextAlign textAlign, Color cor) {
    return Text(
      txt,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: Fonts.font,
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: cor,
      ),
    );
  }

  static txt3(String txt, TextAlign textAlign, Color cor) {
    return Text(
      txt,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: Fonts.font,
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: cor,
      ),
    );
  }
}
