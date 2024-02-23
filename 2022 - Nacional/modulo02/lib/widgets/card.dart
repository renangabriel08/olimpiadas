import 'package:flutter/material.dart';
import 'package:modulo02/styles/styles.dart';

class MyCard extends StatelessWidget {
  final String label;
  final IconData icone;
  const MyCard({super.key, required this.label, required this.icone});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width * .35,
      height: height * .3,
      decoration: BoxDecoration(
        color: Cores.branco,
        border: Border.all(width: 2, color: Cores.cinza),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Cores.cinza,
            blurRadius: 2,
            offset: const Offset(1, 1),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icone,
            size: 60,
            color: Cores.azul,
          ),
          Container(width: 10),
          Textos.getTxt(label, 18, Cores.cinza),
        ],
      ),
    );
  }
}
