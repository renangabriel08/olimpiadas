import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  bool iniciado = false;
  bool started = false;

  iniciar() {
    iniciado = true;
    started = true;

    setState(() {});
  }

  pausar() {
    started = false;

    setState(() {});
  }

  concluir() {}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final args =
        ModalRoute.of(context)!.settings.arguments as AndamentoArguments;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: width,
              height: height * .65,
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
