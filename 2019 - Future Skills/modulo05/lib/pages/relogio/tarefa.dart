import 'package:flutter/material.dart';
import 'package:modulo05/controllers/api.dart';
import 'package:modulo05/styles/styles.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TarefaRelogio extends StatefulWidget {
  const TarefaRelogio({super.key});

  @override
  State<TarefaRelogio> createState() => _TarefaRelogioState();
}

class _TarefaRelogioState extends State<TarefaRelogio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.cinza,
      body: FutureBuilder(
        future: ApiController.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map data = snapshot.data as Map;

            List tarefas = data['relogio']['tarefas'];

            if (tarefas.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircularPercentIndicator(
                      radius: 71.0,
                      lineWidth: 10.0,
                      percent:
                          data['relogio']['tarefas'][0]['porcentagem'] / 100,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Textos.txt(
                            data['relogio']['tarefas'][0]['desafio'],
                            14,
                            TextAlign.center,
                            const Color(0xFFD6E1E0),
                            FontWeight.w400,
                          ),
                          Textos.txt(
                            '${data['relogio']['tarefas'][0]['porcentagem']}%',
                            40,
                            TextAlign.center,
                            const Color(0xFFD6E1E0),
                            FontWeight.w700,
                          ),
                        ],
                      ),
                      progressColor: Cores.azul,
                      backgroundColor: Cores.vermelho,
                    ),
                    Container(
                      width: 50,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Cores.vermelho,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/loginRelogio',
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              size: 10,
                              color: Cores.branco,
                            ),
                            Textos.txt(
                              'Sair',
                              10,
                              TextAlign.center,
                              Cores.branco,
                              FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Textos.txt(
                    'Sem tarefas atuais',
                    14,
                    TextAlign.center,
                    Cores.vermelho,
                    FontWeight.w700,
                  ),
                  Container(
                    width: 50,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Cores.vermelho,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/loginRelogio',
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            size: 10,
                            color: Cores.branco,
                          ),
                          Textos.txt(
                            'Sair',
                            10,
                            TextAlign.center,
                            Cores.branco,
                            FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
