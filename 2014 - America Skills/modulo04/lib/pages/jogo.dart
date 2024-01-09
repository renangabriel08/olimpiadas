import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:modulo04/controllers/cache.dart';
import 'package:modulo04/pages/score.dart';
import 'package:modulo04/styles/styles.dart';
import 'package:modulo04/widgets/toast.dart';

class Jogo extends StatefulWidget {
  const Jogo({super.key});

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  //Configs do jogo
  String? tempoPartida;
  String? tempoPalavra;
  int? tempoPartidaFormatada;
  int? tempoPalavraFormatada;
  int? sec;
  String? tipoPartida;
  bool? personalizado;
  List<Map>? todasCores;
  List coresDoJogo = [];
  int acertos = 0;
  int palavrasExibidas = 0;
  int erros = 0;
  double porcentagem = 0;
  int porcentagemFormatada = 0;

  int tempoReacao = 0;
  List<int> temposDeReacao = [];
  int mediaDeReacaoFormatada = 0;
  double mediaDeReacao = 0;

  String? palavra;
  Color? corPalavra;

  Timer? timerJogo;
  Timer? timerPalavra;
  Timer? timerReacao;
  bool startedJogo = false;

  void setarVariaveis(Map<String, dynamic> result) {
    tempoPartida = result['tempoPartida'];
    tempoPalavra = result['tempoPalavra'];
    tipoPartida = result['tipoPartida'];
    todasCores = result['cores'];
    tempoPartidaFormatada = int.parse(tempoPartida!);
    tempoPalavraFormatada = int.parse(tempoPalavra!);
    sec = tempoPartidaFormatada;

    result == Cache.configPadrao ? personalizado = false : personalizado = true;

    adicionarCores();
    trocarPalavra();
  }

  void startJogoPorTempo() {
    if (!startedJogo) {
      startedJogo = true;
      timerJogo = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => setState(() {
          if (sec != 0) {
            sec = sec! - 1;
          } else {
            fimDeJogo();
          }
        }),
      );
    }
  }

  void trocarPalavra() {
    Random random = Random();
    int iPalavra = random.nextInt(coresDoJogo.length);
    int iCor = random.nextInt(coresDoJogo.length);
    corPalavra = coresDoJogo[iCor]['cor'];
    palavra = coresDoJogo[iPalavra]['nome'];

    temposDeReacao.add(tempoReacao);
    tempoReacao = 0;
    calcularTempoDeReacao();

    tipoPartida == 'Por palavra' ? startJogoPorPalavra() : null;
  }

  void duracaoPalavra() {
    timerPalavra = Timer.periodic(
      Duration(milliseconds: tempoPalavraFormatada!),
      (timer) => setState(() {
        if (startedJogo) {
          trocarPalavra();
          erros++;
          palavrasExibidas++;
        } else {
          timerPalavra!.cancel();
        }
      }),
    );
  }

  void verificarResposta(Color respostaCerta, String respostaSelecionada) {
    String respostaCertaFormatada = formatarRespostaCerta(respostaCerta);

    if (respostaCertaFormatada == respostaSelecionada) {
      acertos++;
    } else {
      erros++;
    }
    palavrasExibidas++;
    calcularPorcentagem();
  }

  void calcularPorcentagem() {
    porcentagem = (acertos * 100) / palavrasExibidas;
    porcentagemFormatada = porcentagem.toInt();
  }

  void adicionarCores() {
    for (int i = 0; i < todasCores!.length; i++) {
      if (todasCores![i]['check']) {
        if (todasCores![i]['cor'] == 'Amarelo') {
          coresDoJogo.add({'nome': 'Amarelo', 'cor': Colors.yellow});
        }
        if (todasCores![i]['cor'] == 'Azul') {
          coresDoJogo.add({'nome': 'Azul', 'cor': Colors.blue});
        }
        if (todasCores![i]['cor'] == 'Laranja') {
          coresDoJogo.add({'nome': 'Laranja', 'cor': Colors.orange});
        }
        if (todasCores![i]['cor'] == 'Preto') {
          coresDoJogo.add({'nome': 'Preto', 'cor': Colors.black});
        }
        if (todasCores![i]['cor'] == 'Vermelho') {
          coresDoJogo.add({'nome': 'Vermelho', 'cor': Colors.red});
        }
        if (todasCores![i]['cor'] == 'Verde') {
          coresDoJogo.add({'nome': 'Verde', 'cor': Colors.green});
        }
        if (todasCores![i]['cor'] == 'Roxo') {
          coresDoJogo.add({'nome': 'Roxo', 'cor': Colors.purple});
        }
      }
    }
  }

  void startJogoPorPalavra() {
    startedJogo = true;
    sec = 0;
    if (palavrasExibidas == int.parse(tempoPartida!)) {
      fimDeJogo();
    }
  }

  void fimDeJogo() {
    tipoPartida == 'Por tempo' ? timerJogo!.cancel() : null;
    startedJogo = false;
    calcularMediaDeReacao();
    MyToast.gerarToast('Fim de jogo!');

    Navigator.pushNamed(
      context,
      Score.routeName,
      arguments: ScoresArguments(
        palavrasExibidas.toString(),
        acertos.toString(),
        tipoPartida!,
        porcentagemFormatada.toString(),
        mediaDeReacaoFormatada.toString(),
        personalizado!,
      ),
    );
  }

  String formatarRespostaCerta(Color respostaCerta) {
    for (int i = 0; i < todasCores!.length; i++) {
      if (respostaCerta == Colors.red) {
        return 'Vermelho';
      }
      if (respostaCerta == Colors.yellow) {
        return 'Amarelo';
      }
      if (respostaCerta == Colors.blue) {
        return 'Azul';
      }
      if (respostaCerta == Colors.orange) {
        return 'Laranja';
      }
      if (respostaCerta == Colors.black) {
        return 'Preto';
      }
      if (respostaCerta == Colors.green) {
        return 'Verde';
      }
      if (respostaCerta == Colors.purple) {
        return 'Roxo';
      }
    }

    return 'erro';
  }

  void calcularTempoDeReacao() {
    timerReacao = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      if (startedJogo) {
        tempoReacao++;
      }
    });
  }

  void calcularMediaDeReacao() {
    temposDeReacao.removeAt(0);
    int somaDosTempos = 0;
    for (int i = 0; i < temposDeReacao.length; i++) {
      somaDosTempos += temposDeReacao[i];
    }
    mediaDeReacao = somaDosTempos / temposDeReacao.length;
    mediaDeReacaoFormatada = mediaDeReacao.toInt();
  }

  @override
  void initState() {
    Future.wait([Cache.getConfigs()]).then((value) {
      setarVariaveis(value[0]);
      if (tipoPartida == 'Por tempo') {
        startJogoPorTempo();
      } else {
        startJogoPorPalavra();
      }
      calcularTempoDeReacao();
      duracaoPalavra();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder(
        future: Cache.getConfigs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: width,
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Partida $tipoPartida",
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            fontSize: 13,
                            color: Cores.cinza,
                          ),
                        ),
                        Text(
                          "|",
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            fontSize: 15,
                            color: Cores.cinza,
                          ),
                        ),
                        Text(
                          "Tipo de jogo: ${personalizado! ? 'Personalizado' : 'Padrão'}",
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            fontSize: 13,
                            color: Cores.cinza,
                          ),
                        ),
                      ],
                    ),
                    Container(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Cores.cinza),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.timer, color: Cores.cinza, size: 20),
                              Text(
                                "00:$sec",
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  fontSize: 13,
                                  color: Cores.cinza,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Cores.cinza),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check, color: Cores.cinza, size: 20),
                              Text(
                                acertos.toString(),
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  fontSize: 13,
                                  color: Cores.cinza,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Cores.cinza),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.paste, color: Cores.cinza, size: 20),
                              Text(
                                palavrasExibidas.toString(),
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  fontSize: 13,
                                  color: Cores.cinza,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(color: Cores.cinza),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.percent, color: Cores.cinza, size: 20),
                              Text(
                                porcentagemFormatada.toString(),
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  fontSize: 13,
                                  color: Cores.cinza,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(height: 20),
                    Text(
                      palavra!,
                      style: TextStyle(
                        fontFamily: Fontes.fonte,
                        fontSize: 30,
                        color: corPalavra,
                      ),
                    ),
                    Container(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0;
                                    i < coresDoJogo.length ~/ 2;
                                    i++)
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => setState(() {
                                          if (startedJogo) {
                                            verificarResposta(
                                              corPalavra!,
                                              coresDoJogo[i]['nome'],
                                            );
                                            trocarPalavra();
                                            timerPalavra!.cancel();
                                            duracaoPalavra();
                                            tipoPartida == 'Por palavra'
                                                ? startJogoPorPalavra()
                                                : null;
                                          }
                                        }),
                                        child: Container(
                                          width: width * .2,
                                          height: width * .2,
                                          color: coresDoJogo[i]['cor'],
                                        ),
                                      ),
                                      Container(height: 10),
                                    ],
                                  ),
                              ],
                            ),
                            Container(width: width * .2),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = coresDoJogo.length ~/ 2;
                                    i < coresDoJogo.length;
                                    i++)
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => setState(() {
                                          if (startedJogo) {
                                            verificarResposta(
                                              corPalavra!,
                                              coresDoJogo[i]['nome'],
                                            );
                                            trocarPalavra();
                                            timerPalavra!.cancel();
                                            duracaoPalavra();
                                            tipoPartida == 'Por palavra'
                                                ? startJogoPorPalavra()
                                                : null;
                                          }
                                        }),
                                        child: Container(
                                          width: width * .2,
                                          height: width * .2,
                                          color: coresDoJogo[i]['cor'],
                                        ),
                                      ),
                                      Container(height: 10),
                                    ],
                                  ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Ocorreu um erro",
                style: TextStyle(
                  fontFamily: Fontes.fonte,
                  fontSize: 25,
                  color: Cores.vermelho,
                ),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
