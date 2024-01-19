import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modulo07/controllers/firebase.dart';
import 'package:modulo07/pages/admin.dart';
import 'package:modulo07/styles/styles.dart';

class Feedbacks extends StatefulWidget {
  const Feedbacks({super.key});

  @override
  State<Feedbacks> createState() => _FeedbacksState();
}

class _FeedbacksState extends State<Feedbacks> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Container(height: height * .03),
              Row(
                children: [
                  Container(
                    width: width * .43,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Cores.azulClaro),
                    ),
                    child: Center(
                      child: Textos.padrao('Admin', Cores.azulClaro),
                    ),
                  ),
                  Container(
                    width: width * .43,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Cores.azulEscuro,
                      border: Border.all(color: Cores.azulClaro),
                    ),
                    child: Center(
                      child: Textos.padrao(
                        'Lista de feedbacks',
                        Cores.azulClaro,
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: height * .03),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(width, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, '/criar'),
                child: Textos.padrao(
                  'Crie uma avaliação teste',
                  Cores.azulEscuro,
                ),
              ),
              Container(height: height * .03),
              FutureBuilder(
                future: FirebaseController.formatarData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List data = snapshot.data as List;

                    if (data.isEmpty) {
                      return Center(
                        child: Textos.subtitulo(
                          'Cadastre a primeira avalição para pode administrar',
                          Cores.azulEscuro,
                        ),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < data.length; i++)
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  Admin.routeName,
                                  arguments: ScreenArguments(i, data[i]['id']),
                                ),
                                child: Slidable(
                                  key: ValueKey(i),
                                  startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    dismissible:
                                        DismissiblePane(onDismissed: () async {
                                      await FirebaseController.deletarAvaliacao(
                                        data[i]['id'],
                                      );
                                      setState(() {});
                                    }),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) async {
                                          await FirebaseController
                                              .deletarAvaliacao(
                                            data[i]['id'],
                                          );
                                          setState(() {});
                                        },
                                        backgroundColor: Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                      SlidableAction(
                                        onPressed: (context) => (),
                                        backgroundColor:
                                            const Color(0xFF21B7CA),
                                        foregroundColor: Colors.white,
                                        icon: Icons.share,
                                        label: 'Share',
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      7,
                                      0,
                                      7,
                                    ),
                                    child: Container(
                                      width: width,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Cores.azulClaro),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 1,
                                            offset: const Offset(1, 1),
                                            color: Cores.azulClaro,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          10,
                                          0,
                                          10,
                                          0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Textos.padrao(
                                              'Avaliação ${i + 1}',
                                              Cores.azulEscuro,
                                            ),
                                            Textos.padrao(
                                              '${data[i]['status']}',
                                              Cores.azulEscuro,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Textos.subtitulo('Erro', Cores.azulEscuro),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: Cores.azulEscuro,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
