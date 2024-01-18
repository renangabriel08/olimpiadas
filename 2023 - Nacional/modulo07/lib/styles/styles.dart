import 'package:flutter/material.dart';

class Cores {
  static Color azulEscuro = const Color(0xFF283b87);
  static Color azulClaro = const Color(0xFF3eb1b1);
  static Color verdeEscuro = const Color(0xFF62c285);
  static Color verdeMedio = const Color(0xFF86d35a);
  static Color verdeClaro = const Color(0xFFabe52f);
}

class Fontes {
  static String fonte = 'Montserrat';
}

class Textos {
  static padrao(String txt, Color cor) {
    return Text(
      txt,
      style: TextStyle(fontFamily: Fontes.fonte, fontSize: 16, color: cor),
    );
  }

  static titulo(String txt, Color cor) {
    return Text(
      txt,
      style: TextStyle(fontFamily: Fontes.fonte, fontSize: 24, color: cor),
    );
  }

  static subtitulo(String txt, Color cor) {
    return Text(
      txt,
      style: TextStyle(fontFamily: Fontes.fonte, fontSize: 20, color: cor),
    );
  }
}
