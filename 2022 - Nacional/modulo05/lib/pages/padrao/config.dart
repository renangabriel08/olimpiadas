import 'package:flutter/material.dart';
import 'package:modulo05/controllers/cache.dart';
import 'package:modulo05/styles/styles.dart';

class ConfigPadrao extends StatefulWidget {
  const ConfigPadrao({super.key});

  @override
  State<ConfigPadrao> createState() => _ConfigPadraoState();
}

class _ConfigPadraoState extends State<ConfigPadrao> {
  String tamanhoDeFonteSelecionada = '';
  String? idiomaSelecionado;
  String? corSelecionada;
  bool menuAcessibilidade = false;

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
                    onTap: () => Navigator.pop(context),
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

            double? fontePadrao;
            double? fonteSubtitulo;
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
                data[0] == 'Estándar') {
              corPrimaria = Cores.ciano;
              corSecundaria = Cores.cinza;
              corDeFundo = Colors.white;
            }

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

            //Setando Radios
            List temas = [
              palavras[1][2],
              palavras[1][3],
              palavras[1][4],
              palavras[1][5],
            ];

            List tamanhosFonte = [
              palavras[1][9],
              palavras[1][10],
              palavras[1][11],
            ];

            List listaDeIdiomas = [
              palavras[1][13],
              palavras[1][14],
              palavras[1][15],
            ];

            //Setando menu de acessibilidade
            if (data[1] == null) {
              menuAcessibilidade = false;
            } else {
              menuAcessibilidade = data[1];
            }

            return SingleChildScrollView(
              child: Container(
                width: width,
                color: corDeFundo,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(width: 20),
                    Container(
                      width: width - 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            palavras[1][0],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: corSecundaria,
                              fontFamily: Fontes.fonte,
                              fontSize: fonteTitulo,
                            ),
                          ),
                          Container(height: 20),
                          Text(
                            palavras[1][1],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: corPrimaria,
                              fontFamily: Fontes.fonte,
                              fontSize: fonteSubtitulo,
                            ),
                          ),
                          for (int i = 0; i < temas.length; i++)
                            Row(
                              children: [
                                Radio(
                                  value: temas[i],
                                  groupValue: corSelecionada,
                                  onChanged: (value) => setState(() {
                                    corSelecionada = value;
                                    CacheController.salvarContraste(
                                      corSelecionada!,
                                    );
                                  }),
                                ),
                                Text(
                                  temas[i],
                                  style: TextStyle(
                                    color: corSecundaria,
                                    fontFamily: Fontes.fonte,
                                    fontSize: fontePadrao,
                                  ),
                                ),
                              ],
                            ),
                          Container(height: 20),
                          Text(
                            palavras[1][6],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: corPrimaria,
                              fontFamily: Fontes.fonte,
                              fontSize: fonteSubtitulo,
                            ),
                          ),
                          Container(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                palavras[1][7],
                                style: TextStyle(
                                  color: corSecundaria,
                                  fontFamily: Fontes.fonte,
                                  fontSize: fontePadrao,
                                ),
                              ),
                              Transform.scale(
                                scale: .8,
                                child: Switch(
                                  value: menuAcessibilidade,
                                  onChanged: (value) => setState(() {
                                    menuAcessibilidade = value;
                                    CacheController.salvarAcessibilidade(
                                      menuAcessibilidade,
                                    );
                                  }),
                                ),
                              )
                            ],
                          ),
                          Container(height: 20),
                          Text(
                            palavras[1][8],
                            style: TextStyle(
                              color: corPrimaria,
                              fontFamily: Fontes.fonte,
                              fontSize: fonteSubtitulo,
                            ),
                          ),
                          for (int i = 0; i < tamanhosFonte.length; i++)
                            Row(
                              children: [
                                Radio(
                                  value: tamanhosFonte[i],
                                  groupValue: tamanhoDeFonteSelecionada,
                                  onChanged: (value) => setState(() {
                                    tamanhoDeFonteSelecionada = value;
                                    CacheController.salvarTamanhoFonte(
                                      tamanhoDeFonteSelecionada,
                                    );
                                  }),
                                ),
                                Text(
                                  tamanhosFonte[i],
                                  style: TextStyle(
                                    color: corSecundaria,
                                    fontFamily: Fontes.fonte,
                                    fontSize: fontePadrao,
                                  ),
                                ),
                              ],
                            ),
                          Text(
                            palavras[1][12],
                            style: TextStyle(
                              color: corPrimaria,
                              fontFamily: Fontes.fonte,
                              fontSize: fonteSubtitulo,
                            ),
                          ),
                          DropdownButton(
                            value: idiomaSelecionado,
                            dropdownColor: corDeFundo,
                            items: [
                              for (int i = 0; i < listaDeIdiomas.length; i++)
                                DropdownMenuItem(
                                  value: listaDeIdiomas[i],
                                  child: Text(
                                    listaDeIdiomas[i],
                                    style: TextStyle(
                                      color: corSecundaria,
                                      fontFamily: Fontes.fonte,
                                      fontSize: fonteSubtitulo,
                                    ),
                                  ),
                                ),
                            ],
                            onChanged: (value) => setState(() {
                              idiomaSelecionado = value!.toString();
                              CacheController.salvarIdioma(idiomaSelecionado!);
                            }),
                          ),
                          menuAcessibilidade
                              ? Column(
                                  children: [
                                    OutlinedButton(
                                      onPressed: () => Navigator.pushNamed(
                                        context,
                                        '/homePadrao',
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(width, 50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: const BorderSide(
                                              color: Colors.red),
                                        ),
                                      ),
                                      child: Text(
                                        palavras[1][16],
                                        style: TextStyle(
                                          color: corPrimaria,
                                          fontFamily: Fontes.fonte,
                                          fontSize: fontePadrao,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      color: corDeFundo,
                                    ),
                                  ],
                                )
                              : Container(
                                  height: 60,
                                  color: corDeFundo,
                                ),
                        ],
                      ),
                    ),
                    Container(width: 20),
                  ],
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
