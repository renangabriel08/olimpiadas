import 'package:flutter/material.dart';

class Lista extends StatefulWidget {
  const Lista({super.key});
  static const routeName = '/lista';

  @override
  State<Lista> createState() => _ListaState();
}

class ScreenArguments {
  final String estado;
  final String cidade;
  final String preco;

  ScreenArguments(this.estado, this.cidade, this.preco);
}

class _ListaState extends State<Lista> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Container();
  }
}
