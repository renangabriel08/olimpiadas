import 'package:flutter/material.dart';

class Cores {
  static Color ciano = const Color(0xFF2ED9C3);
  static Color cinza = const Color(0xFF404041);
  static Color branco = const Color(0xFFFFFFFF);
  static Color vermelho = const Color(0xFFFF4438);
}

class Fonts {
  static String font = 'MontserratAlternates';
}

class Texto extends StatelessWidget {
  final String txt;
  final TextAlign textAlign;
  final double size;
  final FontWeight weight;
  final Color cor;
  const Texto({
    super.key,
    required this.txt,
    required this.textAlign,
    required this.size,
    required this.weight,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: Fonts.font,
        fontSize: size,
        fontWeight: weight,
        color: cor,
      ),
    );
  }
}
