import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modulo03/styles/styles.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController controller;

  Timer? timer;
  int i = 0;
  int tempo = 0;

  atualiza() {
    while (true) {
      int n = Random().nextInt(3);
      if (n != i) {
        return n;
      }
    }
  }

  start() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        i = atualiza();
        tempo++;

        if (tempo == 10) {
          timer.cancel();
          Navigator.pushNamed(context, '/login');
        }
      });
    });
  }

  @override
  void initState() {
    start();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List gradients = [
    LinearGradient(colors: [Cores.azulEscuro, Cores.azulClaro]),
    LinearGradient(colors: [Cores.verdeClaro, Cores.verdeMedio]),
    LinearGradient(
      colors: [Cores.verdeClaro, Cores.verdeMedio, Cores.verdeEscuro],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (Rect rect) {
                  return gradients[i].createShader(rect);
                },
                child: Textos.subtitulo(
                  'EUVOUNATRIP',
                  TextAlign.center,
                  Cores.branco,
                ),
              ),
              Container(height: height * .2),
              Textos.padrao(
                'Carregando...',
                TextAlign.center,
                Cores.verdeEscuro,
              ),
              Container(height: height * .02),
              LinearProgressIndicator(
                value: controller.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
