import 'package:flutter/material.dart';
import 'package:modulo05/controllers/cache.dart';
import 'package:modulo05/styles/styles.dart';

class HomePadrao extends StatefulWidget {
  const HomePadrao({super.key});

  @override
  State<HomePadrao> createState() => _HomePadraoState();
}

class _HomePadraoState extends State<HomePadrao> {
  double? fontePadrao;
  double? fonteSubtitulo;
  double? fonteTitulo;

  List palavras = [];

  List portugues = [
    ['Home', 'Exercícios', 'WsCoin', 'Loja', 'Configurações', 'Sair'],
    [
      'Configurações de Acessibilidade',
      'Ajuste de contraste',
      'Padrão',
      'Daltônico',
      'Monocromático',
      'Escuro',
      'Menu de Acessibilidade',
      'Ativar menu de acessibilidade',
      'Tamanho da fonte',
      'Normal',
      'Médio',
      'Grande',
      'Idioma',
      'Português',
      'Inglês',
      'Espanhol',
      'Voltar'
    ],
  ];

  void setarVariaveis(value) {
    //Tamanho da fonte
    if (value[2] == null) {
      fontePadrao = Fontes.getTamanhoFontePadrao('Normal');
      fonteSubtitulo = Fontes.getTamanhoFonteSubtitulo('Normal');
      fonteTitulo = Fontes.getTamanhoFonteTitulo('Normal');
    } else {
      fontePadrao = Fontes.getTamanhoFontePadrao(value[2]);
      fonteSubtitulo = Fontes.getTamanhoFonteSubtitulo(value[2]);
      fonteTitulo = Fontes.getTamanhoFonteTitulo(value[2]);
    }

    //Idioma
    if (value[3] == null) {
      palavras = Idiomas.getIdioma('Portugês');
    } else {
      palavras = Idiomas.getIdioma(value[3]);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          children: [
            Container(height: height * .05),
            ListTile(
              onTap: () => Navigator.pop(context),
              leading: const Icon(Icons.home),
              title: Text(
                portugues[0][0],
                style: TextStyle(fontFamily: Fontes.fonte),
              ),
            ),
            ListTile(
              onTap: () => Navigator.pop(context),
              leading: const Icon(Icons.accessibility),
              title: Text(
                portugues[0][1],
                style: TextStyle(fontFamily: Fontes.fonte),
              ),
            ),
            ListTile(
              onTap: () => Navigator.pop(context),
              leading: const Icon(Icons.monetization_on_outlined),
              title: Text(
                portugues[0][2],
                style: TextStyle(fontFamily: Fontes.fonte),
              ),
            ),
            ListTile(
              onTap: () => Navigator.pop(context),
              leading: const Icon(Icons.shopping_cart),
              title: Text(
                portugues[0][3],
                style: TextStyle(fontFamily: Fontes.fonte),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/configPadrao');
              },
              leading: const Icon(Icons.settings),
              title: Text(
                portugues[0][4],
                style: TextStyle(fontFamily: Fontes.fonte),
              ),
            ),
            ListTile(
              onTap: () => Navigator.pop(context),
              leading: const Icon(Icons.logout),
              title: Text(
                portugues[0][5],
                style: TextStyle(fontFamily: Fontes.fonte),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: Text('Home'),
        ),
      ),
    );
  }
}
