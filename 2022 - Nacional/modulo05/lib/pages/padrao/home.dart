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
  Color? corPrimaria;
  Color? corSecundaria;
  Color? corDeFundo;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      drawer: FutureBuilder(
        future: CacheController.getConfigs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List data = snapshot.data as List;

            double? fontePadrao = 15;

            List palavras = [];

            if (data[0] == null) {
              corPrimaria = Cores.ciano;
              corSecundaria = Cores.cinza;
              corDeFundo = Colors.white;
            } else if (data[0] == 'Daltônico' ||
                data[0] == 'Color blind' ||
                data[0] == 'daltónico') {
              corPrimaria = const Color(0xFF3E80FB);
              corSecundaria = const Color(0xFF5B7DDF);
              corDeFundo = Colors.white;
            } else if (data[0] == 'Escuro' ||
                data[0] == 'Dark' ||
                data[0] == 'Oscuro') {
              corPrimaria = Colors.white;
              corDeFundo = Colors.black;
              corSecundaria = Colors.white;
            } else if (data[0] == 'Monocromático' ||
                data[0] == 'Monochrome' ||
                data[0] == 'Monocromo') {
              corPrimaria = Colors.black;
              corSecundaria = Cores.cinza;
              corDeFundo = Colors.white;
            } else if (data[0] == 'Padrão' ||
                data[0] == 'Standard' ||
                data[0] == 'Entrenamientos') {
              corPrimaria = Cores.ciano;
              corSecundaria = Cores.cinza;
              corDeFundo = Colors.white;
            }

            //Setando Variáveis
            if (data[2] == null) {
              fontePadrao = Fontes.getTamanhoFontePadrao('Normal');
            } else {
              fontePadrao = Fontes.getTamanhoFontePadrao(data[2]);
            }

            //Idioma
            if (data[3] == null) {
              palavras = Idiomas.getIdioma('Portugues');
            } else {
              palavras = Idiomas.getIdioma(data[3]);
            }

            return Drawer(
              backgroundColor: corDeFundo,
              child: Column(
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
                        color: corSecundaria,
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
                        color: corSecundaria,
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
                        color: corSecundaria,
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
                        color: corSecundaria,
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
                        color: corSecundaria,
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
                        color: corSecundaria,
                        fontFamily: Fontes.fonte,
                        fontSize: fontePadrao,
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
      body: FutureBuilder(
        future: CacheController.getConfigs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List data = snapshot.data as List;

            bool? menuAcessibilidade;
            double? fonteTitulo;

            if (data[0] == null) {
              corPrimaria = Cores.ciano;
              corSecundaria = Cores.cinza;
              corDeFundo = Colors.white;
            } else if (data[0] == 'Daltônico' ||
                data[0] == 'Color blind' ||
                data[0] == 'daltónico') {
              corPrimaria = const Color(0xFF3E80FB);
              corSecundaria = const Color(0xFF5B7DDF);
              corDeFundo = Colors.white;
            } else if (data[0] == 'Escuro' ||
                data[0] == 'Dark' ||
                data[0] == 'Oscuro') {
              corPrimaria = Colors.white;
              corDeFundo = Colors.black;
              corSecundaria = Colors.white;
            } else if (data[0] == 'Monocromático' ||
                data[0] == 'Monochrome' ||
                data[0] == 'Monocromo') {
              corPrimaria = Colors.black;
              corSecundaria = Cores.cinza;
              corDeFundo = Colors.white;
            } else if (data[0] == 'Padrão' ||
                data[0] == 'Standard' ||
                data[0] == 'Entrenamientos') {
              corPrimaria = Cores.ciano;
              corSecundaria = Cores.cinza;
              corDeFundo = Colors.white;
            }

            List palavras = [];

            //Setando Tamanho de Fonte
            if (data[2] == null) {
              fonteTitulo = Fontes.getTamanhoFonteTitulo('Normal');
            } else {
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
                ? Container(
                    width: width,
                    height: height,
                    color: corDeFundo,
                    child: Column(
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
                              corSecundaria,
                              corDeFundo,
                            ),
                            ContainerHome.gerar(
                              width,
                              palavras,
                              fonteTitulo,
                              Icons.accessibility,
                              1,
                              corSecundaria,
                              corDeFundo,
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
                              corSecundaria,
                              corDeFundo,
                            ),
                            ContainerHome.gerar(
                              width,
                              palavras,
                              fonteTitulo,
                              Icons.shopping_cart,
                              3,
                              corSecundaria,
                              corDeFundo,
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
                                corSecundaria,
                                corDeFundo,
                              ),
                            ),
                            ContainerHome.gerar(
                              width,
                              palavras,
                              fonteTitulo,
                              Icons.logout,
                              5,
                              corSecundaria,
                              corDeFundo,
                            ),
                          ],
                        ),
                      ],
                    ),
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
