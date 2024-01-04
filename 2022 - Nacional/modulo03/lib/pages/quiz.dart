import 'package:flutter/material.dart';
import 'package:modulo03/controllers/api.dart';
import 'package:modulo03/controllers/quiz.dart';
import 'package:modulo03/styles/styles.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int numQuestao = 1;
  String alternativaSelecionada = '';
  List<bool> respostas = [];

  voltarPergunta() {
    respostas.removeLast();
  }

  validarRespostas(String alternativaSelecionada, String respostaCorreta) {
    if (alternativaSelecionada == respostaCorreta) {
      respostas.add(true);
    } else {
      respostas.add(false);
    }
  }

  gerarModalErro(String titulo, String txt) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(titulo),
        content: Text(txt),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/home'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: GetUser.getUser(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3RlQGdtYWlsLmNvbSIsImlkX3VzdWFyaW8iOjEsIm5vbWUiOiJ0ZXN0ZSIsImlhdCI6MTcwNDM5MTk3NH0.yop5RbAMWFb9CfgjvX0GB5c87Bx66OrcaNKBSe3yq8Q',
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //Variaveis
          var dataUser = snapshot.data as Map;

          return Scaffold(
            body: SizedBox(
              width: width,
              height: height,
              child: Column(
                children: [
                  //Cabeçalho
                  Container(
                    height: height * .35,
                    decoration: BoxDecoration(
                      color: Cores.ciano,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(height: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/home'),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(width: 5),
                                Text(
                                  dataUser['usuario'],
                                  style: TextStyle(
                                    fontFamily: Fontes.fonte,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.monetization_on_outlined,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                Container(width: 5),
                                Text(
                                  '${dataUser['wscoins']}',
                                  style: TextStyle(
                                    fontFamily: Fontes.fonte,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(height: 10),
                        Text(
                          'Responda as questões corretamente para ganhar 10 WsCoins',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Container(height: 70),
                      ],
                    ),
                  ),

                  //Quiz
                  Padding(
                    padding: EdgeInsets.all(height * .025),
                    child: SizedBox(
                      height: height * .6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            QuizController.questoes[numQuestao]
                                ['Pergunta $numQuestao']['enunciado'],
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              fontSize: 15,
                              color: Cores.cinza,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Container(height: 20),
                          for (int i = 0;
                              i <
                                  QuizController
                                      .questoes[numQuestao]
                                          ['Pergunta $numQuestao']
                                          ['alternativas']
                                      .length;
                              i++)
                            Row(
                              children: [
                                Radio(
                                  value: QuizController.questoes[numQuestao]
                                          ['Pergunta $numQuestao']
                                      ['alternativas'][i],
                                  groupValue: alternativaSelecionada,
                                  onChanged: (value) => setState(() {
                                    alternativaSelecionada = value;
                                  }),
                                ),
                                Text(
                                  QuizController.questoes[numQuestao]
                                          ['Pergunta $numQuestao']
                                      ['alternativas'][i],
                                  style: TextStyle(
                                    fontFamily: Fontes.fonte,
                                    fontSize: 15,
                                    color: Cores.cinza,
                                  ),
                                ),
                              ],
                            ),
                          Container(height: 10),
                          if (numQuestao == 1)
                            ElevatedButton(
                              onPressed: () => setState(() {
                                validarRespostas(
                                    alternativaSelecionada,
                                    QuizController.questoes[numQuestao]
                                        ['Pergunta $numQuestao']['correto']);
                                numQuestao++;
                              }),
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(width * .4, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Proximo',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  fontSize: 15,
                                  color: Cores.cinza,
                                ),
                              ),
                            )
                          else if (numQuestao == 2)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () => setState(() {
                                    numQuestao--;
                                    voltarPergunta();
                                  }),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(width * .4, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Anterior',
                                    style: TextStyle(
                                      fontFamily: Fontes.fonte,
                                      fontSize: 15,
                                      color: Cores.cinza,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () => setState(() {
                                    validarRespostas(
                                        alternativaSelecionada,
                                        QuizController.questoes[numQuestao]
                                                ['Pergunta $numQuestao']
                                            ['correto']);

                                    numQuestao++;
                                  }),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(width * .4, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Proximo',
                                    style: TextStyle(
                                      fontFamily: Fontes.fonte,
                                      fontSize: 15,
                                      color: Cores.cinza,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () => setState(() {
                                    numQuestao--;
                                    voltarPergunta();
                                  }),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(width * .4, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Anterior',
                                    style: TextStyle(
                                      fontFamily: Fontes.fonte,
                                      fontSize: 15,
                                      color: Cores.cinza,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () => setState(() {
                                    validarRespostas(
                                        alternativaSelecionada,
                                        QuizController.questoes[numQuestao]
                                                ['Pergunta $numQuestao']
                                            ['correto']);
                                    if (respostas.contains(false)) {
                                      gerarModalErro(
                                        'Tente novamente',
                                        'Infelizmente você errou uma ou mais questões. Tente Novamente',
                                      );
                                    } else {
                                      Navigator.pushNamed(context, '/home');
                                      PutCoins.atualizarQuiz(
                                        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3RlQGdtYWlsLmNvbSIsImlkX3VzdWFyaW8iOjEsIm5vbWUiOiJ0ZXN0ZSIsImlhdCI6MTcwNDM5MTk3NH0.yop5RbAMWFb9CfgjvX0GB5c87Bx66OrcaNKBSe3yq8Q',
                                        10,
                                      );
                                    }
                                  }),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(width * .4, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Concluir',
                                    style: TextStyle(
                                      fontFamily: Fontes.fonte,
                                      fontSize: 15,
                                      color: Cores.cinza,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
