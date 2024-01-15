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
                return SingleChildScrollView();
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
