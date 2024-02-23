import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo02/controllers/mapa.dart';
import 'package:modulo02/controllers/user.dart';
import 'package:modulo02/pages/progresso.dart';
import 'package:modulo02/styles/styles.dart';
import 'package:modulo02/widgets/toast.dart';

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
  Timer? timer;
  bool? started;

  int s = 0;
  int m = 0;
  int h = 0;

  String sF = '00';
  String mF = '00';
  String hF = '00';

  int distancia = 0;
  LatLng origem = const LatLng(0, 0);

  start() async {
    setState(() {});
    MapaController.atualizarPos();
    if (started == null || !started!) {
      started = true;
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

        sF = s < 10 ? '0$s' : '$s';
        mF = m < 10 ? '0$m' : '$m';
        hF = h < 10 ? '0$h' : '$h';

        distancia = await MapaController.getDistancia(origem);

        setState(() {});
      });
    }
  }

  pause() {
    if (started!) {
      started = false;
      timer!.cancel();
      setState(() {});
    }
  }

  setar(value) {
    origem = LatLng(value.latitude, value.longitude);
    MapaController.points.add(origem);
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([MapaController.posicaoAtal()]).then(
      (value) => setar(value[0]),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final args = ModalRoute.of(context)!.settings.arguments as DadosExercicios;

    String dia =
        args.horario.day < 10 ? '0${args.horario.day}' : '${args.horario.day}';
    String mes = args.horario.month < 10
        ? '0${args.horario.month}'
        : '${args.horario.month}';

    String data = '${args.horario.year}-$mes-$dia';

    String sec = args.horario.second < 10
        ? '0${args.horario.second}'
        : '${args.horario.second}';
    String min = args.horario.minute < 10
        ? '0${args.horario.minute}'
        : '${args.horario.minute}';
    String hr = args.horario.hour < 10
        ? '0${args.horario.hour}'
        : '${args.horario.hour}';

    String hora = '$hr:$min:$sec';

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.timer_outlined, size: 25),
                    Container(width: 5),
                    Textos.getTxt('Tempo:', 25, Cores.cinza)
                  ],
                ),
                Textos.getTxt('$hF:$mF:$sF', 35, Cores.cinza),
              ],
            ),
            Container(height: 40),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.map, size: 25),
                    Container(width: 5),
                    Textos.getTxt('Distância:', 25, Cores.cinza),
                  ],
                ),
                Textos.getTxt('${distancia / 1000} Km', 35, Cores.cinza),
              ],
            ),
            Container(height: 40),
            started == null
                ? GestureDetector(
                    onTap: () => start(),
                    child: Container(
                      width: width * .35,
                      height: width * .35,
                      decoration: BoxDecoration(
                        color: Cores.branco,
                        border: Border.all(width: 2, color: Cores.cinza),
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: Cores.cinza,
                            blurRadius: 2,
                            offset: const Offset(1, 1),
                          )
                        ],
                      ),
                      child: Center(
                        child: Textos.getTxt('Iniciar', 20, Cores.cinza),
                      ),
                    ),
                  )
                : !started!
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => start(),
                            child: Container(
                              width: width * .35,
                              height: width * .35,
                              decoration: BoxDecoration(
                                color: Cores.branco,
                                border: Border.all(
                                  width: 2,
                                  color: Cores.cinza,
                                ),
                                borderRadius: BorderRadius.circular(999),
                                boxShadow: [
                                  BoxShadow(
                                    color: Cores.cinza,
                                    blurRadius: 2,
                                    offset: const Offset(1, 1),
                                  )
                                ],
                              ),
                              child: Center(
                                child: Textos.getTxt(
                                  'Continuar',
                                  20,
                                  Cores.cinza,
                                ),
                              ),
                            ),
                          ),
                          Container(width: 20),
                          GestureDetector(
                            onTap: () {
                              MyToast.gerar('Parabéns! Você concluiu');
                              UserController.salvar(
                                '$data $hora',
                                distancia / 1000,
                                '$hF:$mF:$sF',
                              );
                              Navigator.pushNamed(
                                context,
                                Progresso.routeName,
                                arguments: DadosProgresso(
                                  args.horario,
                                  args.localizacao,
                                  args.tipo,
                                  '$hF:$mF:$sF',
                                  '${distancia / 1000} Km',
                                ),
                              );
                            },
                            child: Container(
                              width: width * .35,
                              height: width * .35,
                              decoration: BoxDecoration(
                                color: Cores.branco,
                                border: Border.all(
                                  width: 2,
                                  color: Cores.cinza,
                                ),
                                borderRadius: BorderRadius.circular(999),
                                boxShadow: [
                                  BoxShadow(
                                    color: Cores.cinza,
                                    blurRadius: 2,
                                    offset: const Offset(1, 1),
                                  )
                                ],
                              ),
                              child: Center(
                                child: Textos.getTxt(
                                  'Concluír',
                                  20,
                                  Cores.cinza,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: () => pause(),
                        child: Container(
                          width: width * .35,
                          height: width * .35,
                          decoration: BoxDecoration(
                            color: Cores.branco,
                            border: Border.all(width: 2, color: Cores.cinza),
                            borderRadius: BorderRadius.circular(999),
                            boxShadow: [
                              BoxShadow(
                                color: Cores.cinza,
                                blurRadius: 2,
                                offset: const Offset(1, 1),
                              )
                            ],
                          ),
                          child: Center(
                            child: Textos.getTxt('Pausar', 20, Cores.cinza),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
