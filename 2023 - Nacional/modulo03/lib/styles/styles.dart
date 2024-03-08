import 'package:flutter/material.dart';

class Fonts {
  static String font = 'MontserratAlternates';
}

class Cores {
  static Color verde1 = const Color(0xFFABE52F);
  static Color verde2 = const Color(0xFF86D35A);
  static Color verde3 = const Color(0xFF62c285);
  static Color azul1 = const Color(0xFF3eb1b1);
  static Color azul2 = const Color(0xFF283b87);
  static Color branco = const Color(0xFFFFFFFF);
}

class Textos {
  static txt1(String txt, TextAlign textAlign, Color cor) {
    return Text(
      txt,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: Fonts.font,
        fontSize: 16,
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
        color: cor,
      ),
    );
  }
}
