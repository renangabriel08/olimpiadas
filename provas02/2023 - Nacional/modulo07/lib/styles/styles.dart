import 'package:flutter/material.dart';

class Cores {
  static Color azulEscuro = const Color(0xFF283B87);
  static Color azulClaro = const Color(0xFF3EB1B1);
  static Color verdeEscuro = const Color(0xFF62C285);
  static Color verdeMedio = const Color(0xFF86D35A);
  static Color verdeClaro = const Color(0xFFABE52F);
  static Color branco = const Color(0xFFFFFFFF);
}

class Fonts {
  static String font = '';
}

class Textos {
  static txt1(String txt, Color cor, TextAlign textAlign) {
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

  static txt2(String txt, Color cor, TextAlign textAlign) {
    return Text(
      txt,
      textAlign: textAlign,
      style: TextStyle(
        color: cor,
        fontFamily: Fonts.font,
        fontSize: 32,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static txt3(String txt, Color cor, TextAlign textAlign) {
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
