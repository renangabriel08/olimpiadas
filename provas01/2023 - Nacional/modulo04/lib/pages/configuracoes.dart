import 'package:flutter/material.dart';
import 'package:modulo04/styles/styles.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Tela Configuraçoes de Usuário.',
          style: TextStyle(
            fontFamily: Fontes.fonte,
            color: Cores.verdeClaro,
          ),
        ),
      ),
    );
  }
}
