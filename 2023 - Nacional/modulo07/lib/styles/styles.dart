import 'package:flutter/material.dart';

class Cores {
  static Color azulEscuro = const Color(0xFF283b87);
  static Color azulClaro = const Color(0xFF3eb1b1);
  static Color verdeClaro = const Color(0xFFabe52f);
  static Color verdeMedio = const Color(0xFF86d35a);
  static Color verdeEscuro = const Color(0xFF62c285);
}

class Fontes {
  static String fonte = 'Montserrat';
}

class Textos {
  static padrao(String txt, Color cor) {
    return Text(
      txt,
      style: TextStyle(color: cor, fontFamily: Fontes.fonte, fontSize: 16),
    );
  }

  static subtitulo(String txt, Color cor) {
    return Text(
      txt,
      textAlign: TextAlign.center,
      style: TextStyle(color: cor, fontFamily: Fontes.fonte, fontSize: 20),
    );
  }

  static titulo(String txt, Color cor) {
    return Text(
      txt,
      textAlign: TextAlign.center,
      style: TextStyle(color: cor, fontFamily: Fontes.fonte, fontSize: 25),
    );
  }
}
