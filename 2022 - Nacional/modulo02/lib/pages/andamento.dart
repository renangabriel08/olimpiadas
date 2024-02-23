import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Andamento extends StatefulWidget {
  const Andamento({super.key});
  static const routeName = '/andamento';

  @override
  State<Andamento> createState() => _AndamentoState();
}

class DadosExercicios {
  final DateTime horario;
  final LatLng localizacao;
  final String tipo;

  DadosExercicios(this.horario, this.localizacao, this.tipo);
}

class _AndamentoState extends State<Andamento> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final args = ModalRoute.of(context)!.settings.arguments as DadosExercicios;
    return Scaffold();
  }
}
