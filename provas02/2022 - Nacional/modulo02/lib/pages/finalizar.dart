import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo02/controllers/mapa.dart';
import 'package:modulo02/styles/styles.dart';

class Finalizar extends StatefulWidget {
  const Finalizar({super.key});
  static const routeName = '/Finalizar';

  @override
  State<Finalizar> createState() => _FinalizarState();
}

class FinalizarArguments {
  final String tipo;
  final LatLng locInicial;
  final DateTime hrInicio;
  final String tempo;
  final String dis;

  FinalizarArguments(
    this.tipo,
    this.locInicial,
    this.hrInicio,
    this.tempo,
    this.dis,
  );
}

class _FinalizarState extends State<Finalizar> {
  bool loading = true;

  set() {
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([MapaController.getPosition()]).then((value) => set());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final args =
        ModalRoute.of(context)!.settings.arguments as FinalizarArguments;

    return Scaffold(
      appBar: AppBar(
        title: Texto(
          txt: args.tipo,
          textAlign: TextAlign.center,
          size: 16,
          weight: FontWeight.bold,
          cor: Cores.cinza,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: !loading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width,
                    height: height * .65,
                  ),
                  Container(
                    width: width * .3,
                    height: width * .3,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Cores.cinza),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Center(
                      child: Texto(
                        txt: 'Finalizar',
                        textAlign: TextAlign.center,
                        size: 16,
                        weight: FontWeight.normal,
                        cor: Cores.cinza,
                      ),
                    ),
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(color: Cores.ciano),
              ),
      ),
    );
  }
}
