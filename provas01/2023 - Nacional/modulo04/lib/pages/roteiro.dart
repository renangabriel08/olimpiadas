import 'package:flutter/material.dart';
import 'package:modulo04/styles/styles.dart';

class Roteiro extends StatefulWidget {
  const Roteiro({super.key});

  @override
  State<Roteiro> createState() => _RoteiroState();
}

class _RoteiroState extends State<Roteiro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Tela Roteiro Personalizado',
          style: TextStyle(
            fontFamily: Fontes.fonte,
          color: Cores.verdeClaro,
          ),
        ),
      ),
    );
  }
}
