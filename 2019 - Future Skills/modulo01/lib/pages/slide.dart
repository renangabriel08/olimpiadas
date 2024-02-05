import 'package:flutter/material.dart';
import 'package:modulo01/styles/styles.dart';

class Slide extends StatefulWidget {
  const Slide({super.key, required this.txt, required this.img});
  final String txt;
  final String img;

  @override
  State<Slide> createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      color: Cores.ciano,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(widget.img),
          Container(height: height * .15),
          Text(
            widget.txt,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
