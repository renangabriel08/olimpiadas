import 'package:flutter/material.dart';
import 'package:modulo05/styles/styles.dart';

class ConfigPadrao extends StatefulWidget {
  const ConfigPadrao({super.key});

  @override
  State<ConfigPadrao> createState() => _ConfigPadraoState();
}

class _ConfigPadraoState extends State<ConfigPadrao> {
  String corSelecionada = 'Padrão';
  String idiomaSelecionado = 'Português';
  String tamanhoDeFonteSelecionada = 'Normal';
  bool menuAcessibilidade = false;

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
    List temas = [
      portugues[1][2],
      portugues[1][3],
      portugues[1][4],
      portugues[1][5],
    ];

    List tamanhosFonte = [
      portugues[1][9],
      portugues[1][10],
      portugues[1][11],
    ];

    List listaDeIdiomas = [
      portugues[1][13],
      portugues[1][14],
      portugues[1][15],
    ];

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
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
              onTap: () => Navigator.pop(context),
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Text(
                portugues[1][0],
                style: TextStyle(
                  fontFamily: Fontes.fonte,
                  fontSize: fonteTitulo,
                ),
              ),
              Container(height: 20),
              Text(
                portugues[1][1],
                style: TextStyle(
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
                      }),
                    ),
                    Text(
                      temas[i],
                      style: TextStyle(
                        fontFamily: Fontes.fonte,
                        fontSize: fontePadrao,
                      ),
                    ),
                  ],
                ),
              Container(height: 20),
              Row(
                children: [
                  Text(
                    portugues[1][6],
                    style: TextStyle(
                      fontFamily: Fontes.fonte,
                      fontSize: fonteSubtitulo,
                    ),
                  ),
                ],
              ),
              Container(height: 10),
              Row(
                children: [
                  Text(
                    portugues[1][7],
                    style: TextStyle(
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
                      }),
                    ),
                  )
                ],
              ),
              Container(height: 20),
              Text(
                portugues[1][8],
                style: TextStyle(
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
                      }),
                    ),
                    Text(
                      tamanhosFonte[i],
                      style: TextStyle(
                        fontFamily: Fontes.fonte,
                        fontSize: fontePadrao,
                      ),
                    ),
                  ],
                ),
              Text(
                portugues[1][12],
                style: TextStyle(
                  fontFamily: Fontes.fonte,
                  fontSize: fonteSubtitulo,
                ),
              ),
              DropdownButton(
                value: idiomaSelecionado,
                items: [
                  for (int i = 0; i < listaDeIdiomas.length; i++)
                    DropdownMenuItem(
                      value: listaDeIdiomas[i],
                      child: Text(
                        listaDeIdiomas[i],
                        style: TextStyle(
                          fontFamily: Fontes.fonte,
                          fontSize: fonteSubtitulo,
                        ),
                      ),
                    ),
                ],
                onChanged: (value) => setState(() {
                  idiomaSelecionado = value!.toString();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
