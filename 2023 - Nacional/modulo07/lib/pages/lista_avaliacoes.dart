import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modulo07/controllers/firebase.dart';
import 'package:modulo07/pages/admin.dart';
import 'package:modulo07/styles/styles.dart';

class ListaAvaliacoes extends StatefulWidget {
  const ListaAvaliacoes({super.key});

  @override
  State<ListaAvaliacoes> createState() => _ListaAvaliacoesState();
}

class _ListaAvaliacoesState extends State<ListaAvaliacoes> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseController.getAvaliacoes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map data = snapshot.data as Map;

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: width,
                height: height,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: width * .43,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Cores.azulEscuro),
                          ),
                          child: Center(
                            child: Textos.padrao('Admin', Cores.verdeEscuro),
                          ),
                        ),
                        Container(
                          width: width * .43,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Cores.azulEscuro),
                            color: Cores.azulEscuro,
                          ),
                          child: Center(
                            child: Textos.padrao(
                              'Lista de avaliações',
                              Cores.verdeEscuro,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(height: height * .02),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        '/criarAvaliacao',
                      ),
                      child: Textos.padrao(
                        'Crie uma avaliação de Teste',
                        Cores.azulEscuro,
                      ),
                    ),
                    Container(height: height * .02),
                    for (int i = 1; i <= data.length; i++)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            Admin.routeName,
                            arguments: ScreenArguments(
                              data["Avaliação $i"]['id'],
                              data["Avaliação $i"]['user'],
                              data["Avaliação $i"]['local'],
                              data["Avaliação $i"]['cidade'],
                              data["Avaliação $i"]['comentario'],
                              data["Avaliação $i"]['estrelas'],
                              data["Avaliação $i"]['image'],
                              data["Avaliação $i"]['status'],
                            ),
                          ),
                          child: Container(
                            width: width,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Cores.azulEscuro),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Textos.subtitulo(data["Avaliação $i"]['id'],
                                      Cores.azulClaro),
                                  Textos.subtitulo(
                                    data["Avaliação $i"]['status'],
                                    Cores.azulClaro,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            );
          }
          return Center(
            child: SingleChildScrollView(),
          );
        },
      ),
    );
  }
}
