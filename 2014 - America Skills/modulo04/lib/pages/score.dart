import 'package:flutter/material.dart';
import 'package:modulo04/controllers/share.dart';
import 'package:modulo04/styles/styles.dart';

class Score extends StatefulWidget {
  const Score({super.key});
  static const routeName = '/score';

  @override
  State<Score> createState() => _ScoreState();
}

class ScoresArguments {
  final String palavrasExibidas;
  final String pontuacao;
  final String tipoDeJogo;
  final String porcentagemDeAcertos;
  final String mediaDeReacao;
  final bool personalizada;

  ScoresArguments(
    this.palavrasExibidas,
    this.pontuacao,
    this.tipoDeJogo,
    this.porcentagemDeAcertos,
    this.mediaDeReacao,
    this.personalizada,
  );
}

class _ScoreState extends State<Score> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final args = ModalRoute.of(context)!.settings.arguments as ScoresArguments;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.emoji_events_outlined,
                    size: 50,
                    color: Cores.amarelo,
                  ),
                  Text(
                    "Parabéns",
                    style: TextStyle(
                      fontFamily: Fontes.fonte,
                      fontSize: 25,
                      color: Cores.verde,
                    ),
                  ),
                ],
              ),
              Container(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 170,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Cores.cinza),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          args.palavrasExibidas,
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            fontSize: 15,
                            color: Cores.cinza,
                          ),
                        ),
                        Text(
                          "Palavras exibidas",
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            fontSize: 15,
                            color: Cores.cinza,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 170,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Cores.cinza),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          args.pontuacao,
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            fontSize: 15,
                            color: Cores.cinza,
                          ),
                        ),
                        Text(
                          "Acertos",
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            fontSize: 15,
                            color: Cores.cinza,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 170,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Cores.cinza),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${args.porcentagemDeAcertos}%',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            fontSize: 15,
                            color: Cores.cinza,
                          ),
                        ),
                        Text(
                          "Acertos",
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            fontSize: 15,
                            color: Cores.cinza,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 170,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Cores.cinza),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${args.mediaDeReacao} ms',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            fontSize: 15,
                            color: Cores.cinza,
                          ),
                        ),
                        Text(
                          "Média de reação",
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            fontSize: 15,
                            color: Cores.cinza,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(width, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, '/home'),
                child: Text(
                  'Home',
                  style: TextStyle(
                    fontFamily: Fontes.fonte,
                    fontSize: 20,
                    color: Cores.azul,
                  ),
                ),
              ),
              Container(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(width, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, '/jogo'),
                child: Text(
                  'Jogar novamente',
                  style: TextStyle(
                    fontFamily: Fontes.fonte,
                    fontSize: 20,
                    color: Cores.azul,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Share.compartilhar(
          args.porcentagemDeAcertos,
          args.personalizada,
          args.tipoDeJogo,
        ),
        child: const Icon(
          Icons.share,
        ),
      ),
    );
  }
}
