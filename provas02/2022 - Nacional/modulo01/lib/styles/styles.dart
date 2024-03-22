import 'package:flutter/material.dart';

class Cores {
  static Color ciano = const Color(0xFF2ed9c3);
  static Color vermelho = const Color(0xFFff4438);
  static Color branco = const Color(0xFFFFFFFF);
  static Color cinza = const Color(0xFF404041);
}

class Fonts {
  static String font = 'MontserratAlternates';
}

class MyText extends StatelessWidget {
  final String txt;
  final double size;
  final TextAlign textAlign;
  final Color cor;
  const MyText({
    super.key,
    required this.txt,
    required this.size,
    required this.textAlign,
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
        color: cor,
      ),
    );
  }
}
