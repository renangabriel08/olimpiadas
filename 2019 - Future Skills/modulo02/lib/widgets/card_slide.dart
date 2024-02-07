import 'package:flutter/material.dart';
import 'package:modulo02/styles/styles.dart';

class CardSlide extends StatefulWidget {
  const CardSlide({
    super.key,
    required this.txt,
    required this.icone,
    required this.cor,
    required this.width,
    required this.height,
  });

  final String txt;
  final IconData icone;
  final Color cor;
  final double width;
  final double height;

  @override
  State<CardSlide> createState() => _CardSlideState();
}

class _CardSlideState extends State<CardSlide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Cores.preto,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 55,
            child: Text(
              widget.txt,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.cor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: Fontes.fonte,
              ),
            ),
          ),
          Icon(
            widget.icone,
            color: widget.cor,
          ),
        ],
      ),
    );
  }
}
