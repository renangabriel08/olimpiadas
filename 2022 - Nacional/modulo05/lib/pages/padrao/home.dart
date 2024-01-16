import 'package:flutter/material.dart';
import 'package:modulo05/controllers/cache.dart';
import 'package:modulo05/styles/styles.dart';
import 'package:modulo05/widgets/contaniner_home.dart';

class HomePadrao extends StatefulWidget {
  const HomePadrao({super.key});

  @override
  State<HomePadrao> createState() => _HomePadraoState();
}

class _HomePadraoState extends State<HomePadrao> {
  double? fontePadrao = 15;
  double? fonteSubtitulo = 18;
  double? fonteTitulo = 20;

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
        child: FutureBuilder(
          future: CacheController.getConfigs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data as List;

              String? corSelecionada;
              String? idiomaSelecionado;
              String? tamanhoDeFonteSelecionada;
              bool? menuAcessibilidade;

              double? fontePadrao = 15;
              double? fonteSubtitulo = 18;
              double? fonteTitulo = 20;

              List palavras = [];

              //Setando Variáveis
              if (data[2] == null) {
                fontePadrao = Fontes.getTamanhoFontePadrao('Normal');
                fonteSubtitulo = Fontes.getTamanhoFonteSubtitulo('Normal');
                fonteTitulo = Fontes.getTamanhoFonteTitulo('Normal');
              } else {
                fontePadrao = Fontes.getTamanhoFontePadrao(data[2]);
                fonteSubtitulo = Fontes.getTamanhoFonteSubtitulo(data[2]);
                fonteTitulo = Fontes.getTamanhoFonteTitulo(data[2]);
              }

              //Idioma
              if (data[3] == null) {
                palavras = Idiomas.getIdioma('Portugues');
              } else {
                palavras = Idiomas.getIdioma(data[3]);
              }

              return Column(
                children: [
                  Container(height: height * .05),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/homePadrao');
                    },
                    leading: const Icon(Icons.home),
                    title: Text(
                      palavras[0][0],
                      style: TextStyle(
                        color: Cores.cinza,
                        fontFamily: Fontes.fonte,
                        fontSize: fontePadrao,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () => Navigator.pop(context),
                    leading: const Icon(Icons.accessibility),
                    title: Text(
                      palavras[0][1],
                      style: TextStyle(
                        color: Cores.cinza,
                        fontFamily: Fontes.fonte,
                        fontSize: fontePadrao,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () => Navigator.pop(context),
                    leading: const Icon(Icons.monetization_on_outlined),
                    title: Text(
                      palavras[0][2],
                      style: TextStyle(
                        color: Cores.cinza,
                        fontFamily: Fontes.fonte,
                        fontSize: fontePadrao,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () => Navigator.pop(context),
                    leading: const Icon(Icons.shopping_cart),
                    title: Text(
                      palavras[0][3],
                      style: TextStyle(
                        color: Cores.cinza,
                        fontFamily: Fontes.fonte,
                        fontSize: fontePadrao,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/configPadrao');
                    },
                    leading: const Icon(Icons.settings),
                    title: Text(
                      palavras[0][4],
                      style: TextStyle(
                        color: Cores.cinza,
                        fontFamily: Fontes.fonte,
                        fontSize: fontePadrao,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () => Navigator.pop(context),
                    leading: const Icon(Icons.logout),
                    title: Text(
                      palavras[0][5],
                      style: TextStyle(
                        color: Cores.cinza,
                        fontFamily: Fontes.fonte,
                        fontSize: fontePadrao,
                      ),
                    ),
                  ),
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      body: FutureBuilder(
        future: CacheController.getConfigs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List data = snapshot.data as List;

            String? corSelecionada;
            String? idiomaSelecionado;
            bool? menuAcessibilidade;

            double? fontePadrao;
            double? fonteSubtitulo;
            double? fonteTitulo;

            List palavras = [];

            //Setando Tamanho de Fonte
            if (data[2] == null) {
              fontePadrao = Fontes.getTamanhoFontePadrao('Normal');
              fonteSubtitulo = Fontes.getTamanhoFonteSubtitulo('Normal');
              fonteTitulo = Fontes.getTamanhoFonteTitulo('Normal');
            } else {
              fontePadrao = Fontes.getTamanhoFontePadrao(data[2]);
              fonteSubtitulo = Fontes.getTamanhoFonteSubtitulo(data[2]);
              fonteTitulo = Fontes.getTamanhoFonteTitulo(data[2]);
            }

            //Setando Palavras pelo idioma
            if (data[3] == null) {
              palavras = Idiomas.getIdioma('Portugues');
            } else {
              palavras = Idiomas.getIdioma(data[3]);
            }

            //Setando menu de acessibilidade
            if (data[1] == null) {
              menuAcessibilidade = false;
            } else {
              menuAcessibilidade = data[1];
            }

            return menuAcessibilidade!
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ContainerHome.gerar(
                            width,
                            palavras,
                            fonteTitulo,
                            Icons.home,
                            0,
                          ),
                          ContainerHome.gerar(
                            width,
                            palavras,
                            fonteTitulo,
                            Icons.accessibility,
                            1,
                          ),
                        ],
                      ),
                      Container(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ContainerHome.gerar(
                            width,
                            palavras,
                            fonteTitulo,
                            Icons.monetization_on_outlined,
                            2,
                          ),
                          ContainerHome.gerar(
                            width,
                            palavras,
                            fonteTitulo,
                            Icons.shopping_cart,
                            3,
                          ),
                        ],
                      ),
                      Container(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              '/configPadrao',
                            ),
                            child: ContainerHome.gerar(
                              width,
                              palavras,
                              fonteTitulo,
                              Icons.settings,
                              4,
                            ),
                          ),
                          ContainerHome.gerar(
                            width,
                            palavras,
                            fonteTitulo,
                            Icons.logout,
                            5,
                          ),
                        ],
                      ),
                    ],
                  )
                : Container();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
