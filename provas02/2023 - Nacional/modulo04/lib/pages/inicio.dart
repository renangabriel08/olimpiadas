import 'package:flutter/material.dart';
import 'package:modulo04/styles/styles.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: Textos.padrao('Home', TextAlign.start, Cores.verdeEscuro),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Textos.padrao('Home', TextAlign.start, Cores.verdeEscuro),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Textos.padrao('Home', TextAlign.start, Cores.verdeEscuro),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Textos.padrao('Home', TextAlign.start, Cores.verdeEscuro),
            ),
          ],
        ),
      ),
    );
  }
}
