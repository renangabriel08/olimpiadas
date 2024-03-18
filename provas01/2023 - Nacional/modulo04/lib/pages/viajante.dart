import 'package:flutter/material.dart';
import 'package:modulo04/styles/styles.dart';

class Viajante extends StatefulWidget {
  const Viajante({super.key});

  @override
  State<Viajante> createState() => _ViajanteState();
}

class _ViajanteState extends State<Viajante> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Tela Viajante Gamificado',
          style: TextStyle(
            fontFamily: Fontes.fonte,
          color: Cores.verdeClaro,
          ),
        ),
      ),
    );
  }
}
