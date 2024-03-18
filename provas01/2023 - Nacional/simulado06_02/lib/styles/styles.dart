import 'package:flutter/material.dart';

class Fonte {
  static String fonte = 'Montserrat';
}

class Textos {
  static padrao(String msg) {
    return Text(
      msg,
      style: TextStyle(
        fontFamily: Fonte.fonte,
        fontSize: 18,
      ),
    );
  }

  static subtitulo(String msg) {
    return Text(
      msg,
      style: TextStyle(
        fontFamily: Fonte.fonte,
        fontSize: 21,
      ),
    );
  }

  static titulo(String msg) {
    return Text(
      msg,
      style: TextStyle(
        fontFamily: Fonte.fonte,
        fontSize: 25,
      ),
    );
  }
}
