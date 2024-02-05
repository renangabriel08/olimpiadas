import 'package:flutter/material.dart';

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
    return Container();
  }
}