import 'package:flutter/material.dart';
import 'package:modulo02/styles/styles.dart';

class CardHome extends StatelessWidget {
  final double width;
  final double height;
  final IconData icone;
  final String txt;
  final void Function() onTap;

  const CardHome({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
    required this.icone,
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * .35,
        height: width * .35,
        decoration: BoxDecoration(
          color: Cores.branco,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Cores.cinza,
              blurRadius: 5,
              offset: const Offset(0, 0),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, size: 40),
            Texto(
              txt: txt,
              textAlign: TextAlign.center,
              size: 20,
              weight: FontWeight.normal,
              cor: Cores.cinza,
            ),
          ],
        ),
      ),
    );
  }
}
