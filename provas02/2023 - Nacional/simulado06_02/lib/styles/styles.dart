import 'package:flutter/material.dart';

class Cores {
  static Color ciano = const Color(0xFF2ed9c3);
  static Color vermelho = const Color(0xFFff4438);
  static Color cinza = const Color(0xFF404041);
  static Color branco = const Color(0xFFFFFFFF);
}

class Fonts {
  static String font = 'MontserratAlternates';
}

class Textos extends StatelessWidget {
  final String txt;
  final TextAlign textAlign;
  final Color cor;
  final double size;
  final FontWeight weight;
  const Textos({
    super.key,
    required this.txt,
    required this.textAlign,
    required this.cor,
    required this.size,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: Fonts.font,
        color: cor,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
