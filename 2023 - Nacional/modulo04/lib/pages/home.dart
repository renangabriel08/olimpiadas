import 'package:flutter/material.dart';
import 'package:modulo04/styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tela Home',
        style: TextStyle(
          fontFamily: Fontes.fonte,
          color: Cores.verdeClaro,
        ),
      ),
    );
  }
}
