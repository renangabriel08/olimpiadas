import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo02/controllers/mapa.dart';
import 'package:modulo02/pages/finalizar.dart';
import 'package:modulo02/styles/styles.dart';

class Andamento extends StatefulWidget {
  const Andamento({super.key});
  static const routeName = '/andamento';

  @override
  State<Andamento> createState() => _AndamentoState();
}

class AndamentoArguments {
  final String tipo;
  final LatLng locInicial;
  final DateTime hrInicio;

  AndamentoArguments(this.tipo, this.locInicial, this.hrInicio);
}

class _AndamentoState extends State<Andamento> {
  String dis = '00KM';

  Timer? timer;

  int h = 0;
  int m = 0;
  int s = 0;

  String hF = '00';
  String mF = '00';
  String sF = '00';

  bool iniciado = false;
  bool started = false;

  iniciar() {
    iniciado = true;
    started = true;

    setState(() {});

    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      s++;

      if (s == 60) {
        m++;
        s = 0;
      }
      if (m == 60) {
        h++;
        m = 0;
      }

      hF = h < 10 ? '0$h' : h.toString();
      mF = m < 10 ? '0$m' : m.toString();
      sF = s < 10 ? '0$s' : s.toString();

      dis = await MapaController.getDistance();

      setState(() {});
    });
  }

  pausar() {
    started = false;
    timer!.cancel();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final args =
        ModalRoute.of(context)!.settings.arguments as AndamentoArguments;

    concluir() {
      Navigator.pushNamed(
        context,
        Finalizar.routeName,
        arguments: FinalizarArguments(
          args.tipo,
          args.locInicial,
          args.hrInicio,
          '$hF:$mF:$sF',
          dis,
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width,
              height: height * .65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Texto(
                        txt: 'Tempo',
                        textAlign: TextAlign.center,
                        size: 20,
                        weight: FontWeight.normal,
                        cor: Cores.cinza,
                      ),
                      Texto(
                        txt: '$hF:$mF:$sF',
                        textAlign: TextAlign.center,
                        size: 38,
                        weight: FontWeight.bold,
                        cor: Cores.cinza,
                      ),
                    ],
                  ),
                  Container(height: height * .1),
                  Column(
                    children: [
                      Texto(
                        txt: 'Distância (KM)',
                        textAlign: TextAlign.center,
                        size: 20,
                        weight: FontWeight.normal,
                        cor: Cores.cinza,
                      ),
                      Texto(
                        txt: dis,
                        textAlign: TextAlign.center,
                        size: 38,
                        weight: FontWeight.bold,
                        cor: Cores.cinza,
                      ),
                    ],
                  )
                ],
              ),
            ),
            started
                ? GestureDetector(
                    onTap: () => pausar(),
                    child: Container(
                      width: width * .3,
                      height: width * .3,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Cores.cinza),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Center(
                        child: Texto(
                          txt: 'Pausar',
                          textAlign: TextAlign.center,
                          size: 16,
                          weight: FontWeight.normal,
                          cor: Cores.cinza,
                        ),
                      ),
                    ),
                  )
                : !iniciado
                    ? GestureDetector(
                        onTap: () => iniciar(),
                        child: Container(
                          width: width * .3,
                          height: width * .3,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Cores.cinza),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Center(
                            child: Texto(
                              txt: 'Iniciar',
                              textAlign: TextAlign.center,
                              size: 16,
                              weight: FontWeight.normal,
                              cor: Cores.cinza,
                            ),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () => iniciar(),
                            child: Container(
                              width: width * .3,
                              height: width * .3,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Cores.cinza),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Center(
                                child: Texto(
                                  txt: 'Continuar',
                                  textAlign: TextAlign.center,
                                  size: 16,
                                  weight: FontWeight.normal,
                                  cor: Cores.cinza,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => concluir(),
                            child: Container(
                              width: width * .3,
                              height: width * .3,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Cores.cinza),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Center(
                                child: Texto(
                                  txt: 'Concluir',
                                  textAlign: TextAlign.center,
                                  size: 16,
                                  weight: FontWeight.normal,
                                  cor: Cores.cinza,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}
