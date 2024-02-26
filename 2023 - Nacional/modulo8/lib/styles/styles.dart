import 'package:flutter/material.dart';

class Cores {
  static Color azul1 = const Color(0xFF3eb1b1);
  static Color azul2 = const Color(0xFF283b87);
  static Color verde1 = const Color(0xFFabe52f);
  static Color verde2 = const Color(0xFF86d35a);
  static Color verde3 = const Color(0xFF62c285);
  static Color branco = const Color(0xFFFFFFFF);
}

class Fontes {
  static String fonte = 'MontserratAlternates';
}

class Textos {
  static txt1(String txt, Color cor) {
    return Text(
      txt,
      style: TextStyle(
        color: cor,
        fontSize: 16,
        fontFamily: Fontes.fonte,
      ),
    );
  }

  static txt2(String txt, Color cor) {
    return Text(
      txt,
      style: TextStyle(
        color: cor,
        fontSize: 32,
        fontFamily: Fontes.fonte,
      ),
    );
  }

  static txt3(String txt, Color cor) {
    return Text(
      txt,
      style: TextStyle(
        color: cor,
        fontSize: 48,
        fontFamily: Fontes.fonte,
      ),
    );
  }
}
