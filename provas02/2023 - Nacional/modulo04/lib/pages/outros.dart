import 'package:flutter/material.dart';
import 'package:modulo04/styles/styles.dart';

class Outros extends StatefulWidget {
  final String titulo;
  const Outros({super.key, required this.titulo});

  @override
  State<Outros> createState() => _OutrosState();
}

class _OutrosState extends State<Outros> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Textos.subtitulo(
          widget.titulo,
          TextAlign.center,
          Cores.verdeEscuro,
        ),
      ),
    );
  }
}
