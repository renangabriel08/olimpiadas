import 'package:flutter/material.dart';
import 'package:modulo03/controllers/cache.dart';
import 'package:modulo03/controllers/share.dart';
import 'package:modulo03/styles/styles.dart';

class Scores extends StatefulWidget {
  const Scores({super.key});
  static const routeName = '/scores';

  @override
  State<Scores> createState() => _ScoresState();
}

class ScoresArguments {
  final String tempo;

  ScoresArguments(this.tempo);
}

class _ScoresState extends State<Scores> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final args = ModalRoute.of(context)!.settings.arguments as ScoresArguments;

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: FutureBuilder(
          future: CacheController.ordenarScores(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data as List;

              if (data.isNotEmpty) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(height: height * .05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(
                                context,
                              ),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Cores.preto,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 27,
                                    color: Cores.azulEscuro,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Scores',
                              style: TextStyle(
                                color: Cores.azulEscuro,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                fontFamily: Fontes.fonte,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                '/home',
                              ),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Cores.preto,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.home,
                                    size: 27,
                                    color: Cores.azulEscuro,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(height: height * .03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Textos.titulo(
                                  'Tempo atual: ',
                                  Cores.azulEscuro,
                                ),
                                Textos.titulo(
                                  args.tempo,
                                  Cores.azulClaro,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(height: height * .03),
                        for (int i = 0; i < data.length; i++)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Container(
                              width: width,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Cores.preto,
                                ),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 1,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Row(
                                  children: [
                                    Textos.subTitulo(
                                      '${i + 1}',
                                      Cores.azulEscuro,
                                    ),
                                    Textos.subTitulo(
                                      ' - ${data[i][2]} - ',
                                      Cores.azulEscuro,
                                    ),
                                    Textos.subTitulo(
                                      '${data[i][1]}',
                                      Cores.azulEscuro,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }

              if (data.isEmpty) {
                return Center(
                  child: Textos.titulo(
                    'Nenhum score registrado',
                    Cores.vermelho,
                  ),
                );
              }
            }
            if (snapshot.hasError) {
              return Center(
                child: Textos.titulo('Erro ao buscar scores', Cores.vermelho),
              );
            }
            return Center(
              child: CircularProgressIndicator(color: Cores.azulEscuro),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ShareController.compartilhar(
          'Completei o MazeGame em ${args.tempo}! Vem jogar também.',
        ),
        child: Icon(
          Icons.share,
          size: 27,
          color: Cores.azulEscuro,
        ),
      ),
    );
  }
}
