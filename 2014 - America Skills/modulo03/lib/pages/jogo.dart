import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modulo03/controllers/cache.dart';
import 'package:modulo03/pages/scores.dart';
import 'package:modulo03/styles/styles.dart';
import 'package:modulo03/widgets/buraco.dart';
import 'package:modulo03/widgets/toast.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Jogo extends StatefulWidget {
  const Jogo({super.key});

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  //Posição
  bool startGiroscopio = false;

  double posX = 70;
  double posZ = 45;

  double eventX = 0;
  double eventZ = 0;

  //Cronometro
  bool started = false;
  Timer? timer;

  int milisec = 0;
  int sec = 0;
  int min = 0;

  String milisecFormatada = '00';
  String secFormatada = '00';
  String minFormatada = '00';

  void start(height, width) {
    startGiroscopio = true;
    timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      milisec++;

      if (milisec == 100) {
        sec++;
        milisec = 0;
      }
      if (sec == 60) {
        min++;
        sec = 0;
      }
      if (min == 99) {
        reset();
      }

      if (milisec < 100) {
        milisecFormatada = '00$milisec';
      }
      if (milisec < 10) {
        milisecFormatada = '0$milisec';
      } else {
        milisecFormatada = '$milisec';
      }
      if (sec < 10) {
        secFormatada = '0$sec';
      } else {
        secFormatada = '$sec';
      }
      if (min < 10) {
        minFormatada = '0$min';
      } else {
        minFormatada = '$min';
      }

      //Movimento do personagem
      gyroscopeEvents.listen(
        (GyroscopeEvent event) {
          if (startGiroscopio) {
            if (event.x < 0 && eventX > event.x) {
              eventX = event.x;
            }
            if (event.x > 0 && eventX < event.x) {
              eventX = event.x;
            }
            if (event.z < 0 && eventZ > event.z) {
              eventZ = event.z;
            }
            if (event.z > 0 && eventZ < event.z) {
              eventZ = event.z;
            }

            //1 linha do jogo

            if ((posX + eventX > height * .08 &&
                    posX + eventX < height * .143) &&
                (posZ + eventZ > width * .1 && posZ + eventZ < width * .825)) {
              posZ += eventZ / 1000;
              posX += eventX / 1000;
              setState(() {});
              if (posZ > width * .825 - 30 && posX < height * .08 + 30) {
                perder();
              } else if ((posX > height * .143 - 30) &&
                  (posZ < width * .624 + 30 && posZ > width * .624 - 30)) {
                perder();
              }
            }

            //2 linha do jogo
            if ((posX + eventX > height * .08 &&
                    posX + eventX < height * .323) &&
                (posZ + eventZ > width * .70 && posZ + eventZ < width * .825)) {
              posZ += eventZ / 1000;
              posX += eventX / 1000;
              setState(() {});
              if (posX > height * .323 - 30 && posZ > width * .825 - 30) {
                perder();
              }
            }

            //3 linha do jogo
            if ((posX + eventX > height * .260 &&
                    posX + eventX < height * .324) &&
                (posZ + eventZ > width * .1 && posZ + eventZ < width * .825)) {
              posX += eventX / 1000;
              posZ += eventZ / 1000;
              setState(() {});
              if (posX < height * .260 + 30 && posZ < width * .1 + 30) {
                perder();
              } else if ((posX > height * .323 - 30) &&
                  (posZ < width * .43 + 30 && posZ > width * .43 - 30)) {
                perder();
              }
            }

            //4 linha do jogo
            if ((posX + eventX > height * .260 &&
                    posX + eventX < height * .503) &&
                (posZ + eventZ > width * .1 && posZ + eventZ < width * .225)) {
              posZ += eventZ / 1000;
              posX += eventX / 1000;
              setState(() {});
              if (posZ < width * .1 - 30 && posX < height * .260 - 30) {
                perder();
              } else if (posZ < width * .1 - 30 && posX > height * .503 - 30) {
                perder();
              }
            }

            //5 linha do jogo
            if ((posX + eventX > height * .440 &&
                    posX + eventX < height * .503) &&
                (posZ + eventZ > width * .1 && posZ + eventZ < width * .825)) {
              posZ += eventZ / 1000;
              posX += eventX / 1000;

              setState(() {});

              if (posX > height * .503 - 30 && posZ < width * .1 + 30) {
                perder();
              }

              if (posX < height * .440 + 30 && posZ > width * .825 - 30) {
                perder();
              }
            }

            //6 linha do jogo
            if ((posX + eventX > height * .44 &&
                    posX + eventX < height * .683) &&
                (posZ + eventZ < width * .825 && posZ + eventZ > width * .7)) {
              posX += eventX / 1000;
              posZ += eventZ / 1000;

              setState(() {});

              if (posZ > width * .825 - 30 && posX < height * .440 - 30) {
                perder();
              } else if (posZ > width * .825 - 30 &&
                  posX > height * .683 - 30) {
                perder();
              }
            }

            //7 linha do jogo
            if ((posX + eventX > height * .620 &&
                    posX + eventX < height * .683) &&
                (posZ + eventZ > width * .1 && posZ + eventZ < width * .825)) {
              posX += eventX / 1000;
              posZ += eventZ / 1000;

              setState(() {});

              if (posZ > width * .825 - 30 && posX > height * .683 - 30) {
                perder();
              } else if (posZ < (width * .1) + 30) {
                vencer();
                return;
              }
            }
          }
        },
        onError: (error) {},
        cancelOnError: true,
      );

      setState(() {});
    });
  }

  void pause() {
    setState(() {
      startGiroscopio = false;
      timer!.cancel();
    });
  }

  void reset() {
    setState(() {
      started = false;
      startGiroscopio = false;
      timer?.cancel();

      milisec = 0;
      sec = 0;
      min = 0;

      milisecFormatada = '00';
      secFormatada = '00';
      minFormatada = '00';

      posX = 70;
      posZ = 45;

      eventX = 0;
      eventZ = 0;
    });
  }

  //Game
  void vencer() {
    //Formatação da data
    String dia = DateTime.now().day < 10
        ? '0${DateTime.now().day}'
        : DateTime.now().day.toString();
    String mes = DateTime.now().month < 10
        ? '0${DateTime.now().month}'
        : DateTime.now().month.toString();
    String ano = DateTime.now().year.toString();

    //Data e tempo
    String time = '$minFormatada:$secFormatada:$milisecFormatada';
    String data = '$dia/$mes/$ano';

    //Salvar em cache
    CacheController.saveScores(time, data);
    CacheController.saveUltimoScore(time, data);

    //Feedback
    MyToast.gerarToast('Parabéns, você venceu!');
    reset();

    //Navegar
    Navigator.pushNamed(
      context,
      Scores.routeName,
      arguments: ScoresArguments(time),
    );
  }

  void perder() {
    MyToast.gerarToast('Você perdeu, tente novamente');
    reset();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              width: width,
              height: height * .1,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        reset();
                        Navigator.pushNamed(context, '/home');
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Cores.preto),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'MazeGame',
                      style: TextStyle(
                        color: Cores.azulEscuro,
                        fontSize: 25,
                        fontFamily: Fontes.fonte,
                      ),
                    ),
                    Container()
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  width: width,
                  height: height * .8,
                  color: Colors.white,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width * 8,
                      height: height * .08,
                      color: Cores.azulClaro,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width * .1,
                          height: height * .1,
                          color: Cores.azulClaro,
                        ),
                        Container(
                          width: width * .1,
                          height: height * .1,
                          color: Cores.azulClaro,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width * .1,
                          height: height * .08,
                          color: Cores.azulClaro,
                        ),
                        Container(
                          width: width * .7,
                          height: height * .08,
                          color: Cores.azulClaro,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width * .1,
                          height: height * .1,
                          color: Cores.azulClaro,
                        ),
                        Container(
                          width: width * .1,
                          height: height * .1,
                          color: Cores.azulClaro,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width * .7,
                          height: height * .08,
                          color: Cores.azulClaro,
                        ),
                        Container(
                          width: width * .1,
                          height: height * .08,
                          color: Cores.azulClaro,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width * .1,
                          height: height * .1,
                          color: Cores.azulClaro,
                        ),
                        Container(
                          width: width * .1,
                          height: height * .1,
                          color: Cores.azulClaro,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width * .1,
                          height: height * .08,
                          color: Cores.azulClaro,
                        ),
                        Container(
                          width: width * .7,
                          height: height * .08,
                          color: Cores.azulClaro,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width * .1,
                          height: height * .1,
                          color: Cores.azulClaro,
                        ),
                        Container(
                          width: width * .1,
                          height: height * .1,
                          color: Cores.azulClaro,
                        ),
                      ],
                    ),
                    Container(
                      width: width * 8,
                      height: height * .08,
                      color: Cores.azulClaro,
                    ),
                  ],
                ),

                //Buracos
                Buraco.buraco(width * .825, height * .08),
                Buraco.buraco(width * .624, height * .143),
                Buraco.buraco(width * .825, height * .323),
                Buraco.buraco(width * .43, height * .323),
                Buraco.buraco(width * .1, height * .260),
                Buraco.buraco(width * .1, height * .503),
                Buraco.buraco(width * .825, height * .440),
                Buraco.buraco(width * .825, height * .683),

                //Chegada
                Positioned(
                  top: height * .62,
                  right: width * .1,
                  child: Container(
                    width: 30,
                    height: height * .1,
                    color: Cores.verde,
                  ),
                ),

                //Personagem
                Positioned(
                  top: posX,
                  right: posZ,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Cores.amarelo,
                      border: Border.all(color: Cores.preto),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: width,
              height: height * .1,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () => setState(() {
                      started ? pause() : start(height, width);
                      started = !started;
                    }),
                    icon: Icon(
                      started ? Icons.pause : Icons.play_arrow,
                      size: 40,
                    ),
                  ),
                  Text(
                    '$minFormatada:$secFormatada:$milisecFormatada',
                    style: TextStyle(
                      color: Cores.azulEscuro,
                      fontSize: 25,
                      fontFamily: Fontes.fonte,
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() {
                      pause();
                      reset();
                    }),
                    icon: const Icon(
                      Icons.close,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
