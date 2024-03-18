import 'package:flutter/material.dart';

class Cores {
  static Color azulClaro = const Color(0xFF3C54D0);
  static Color azulMedio = const Color(0xFF273580);
  static Color azulEscuro = const Color(0xFF1C2550);
  static Color cinza = const Color(0xFF272727);
}

class Fontes {
  static String fonte = 'Montserrat';
}

class Textos {
  static titulo(String txt, Color cor) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: 24,
        fontFamily: Fontes.fonte,
        color: cor,
      ),
    );
  }

  static subTitulo(String txt, Color cor) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: 20,
        fontFamily: Fontes.fonte,
        color: cor,
      ),
    );
  }

  static padrao(String txt, Color cor) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: 16,
        fontFamily: Fontes.fonte,
        color: cor,
      ),
    );
  }
}
