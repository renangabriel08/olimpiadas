import 'package:flutter/material.dart';

class Cores {
  static Color azulEscuro = const Color(0xFF0E47A1);
  static Color azulClasro = const Color(0xFF1564BF);
  static Color amarelo = const Color(0xFFFFEB3C);
  static Color preto = const Color(0xFF272727);
  static Color vermelho = const Color(0xFFF44236);
  static Color verde = const Color(0xFF4CB050);
}

class Fontes {
  static String fonte = 'Montserrat';
}

class Textos {
  static Text titulo(String txt, Color cor) {
    return Text(
      txt,
      style: TextStyle(
        color: cor,
        fontSize: 18,
        fontFamily: Fontes.fonte,
      ),
    );
  }

  static Text subTitulo(String txt, Color cor) {
    return Text(
      txt,
      style: TextStyle(
        color: cor,
        fontSize: 16,
        fontFamily: Fontes.fonte,
      ),
    );
  }

  static Text padrao(String txt, Color cor) {
    return Text(
      txt,
      style: TextStyle(
        color: cor,
        fontSize: 14,
        fontFamily: Fontes.fonte,
      ),
    );
  }
}
