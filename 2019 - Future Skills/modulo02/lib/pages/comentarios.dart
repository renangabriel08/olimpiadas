import 'package:flutter/material.dart';
import 'package:modulo02/controllers/comentarios.dart';
import 'package:modulo02/styles/styles.dart';

class Comentarios extends StatefulWidget {
  const Comentarios({super.key});
  static const routeName = '/comentarios';

  @override
  State<Comentarios> createState() => _ComentariosState();
}

class ScreenArguments {
  final int userId;

  ScreenArguments(this.userId);
}

class _ComentariosState extends State<Comentarios> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Cores.verde,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Comentários Gerais',
          style: TextStyle(
            color: Cores.cinza1,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: Fontes.fonte,
          ),
        ),
      ),
      body: Container(
        width: width,
        height: height,
        color: Cores.cinza1,
        child: FutureBuilder(
          future: ComentariosController.getComentarios(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data as List;

              return RefreshIndicator(
                onRefresh: () {
                  print('object');
                  setState(() {});
                  return Future(() => ());
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(height: height * .1),
                      for (var comentario in data)
                        comentario['userId'] == args.userId
                            ? Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Container(
                                  width: width,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2, color: Cores.verde),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: width * .8,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              comentario['comentario'],
                                              style: TextStyle(
                                                color: Cores.cinza2,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: Fontes.fonte,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  comentario['desafio'],
                                                  style: TextStyle(
                                                    color: Cores.azul,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: Fontes.fonte,
                                                  ),
                                                ),
                                                Text(
                                                  comentario['user'],
                                                  style: TextStyle(
                                                    color: Cores.verde,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: Fontes.fonte,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(999),
                                          border: Border.all(
                                              width: 2, color: Cores.verde),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(999),
                                          child: Image.network(
                                            comentario['avatar'],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Container(
                                  width: width,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 2, color: Cores.verde),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(999),
                                          border: Border.all(
                                              width: 2, color: Cores.verde),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(999),
                                          child: Image.network(
                                            comentario['avatar'],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * .8,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              comentario['comentario'],
                                              style: TextStyle(
                                                color: Cores.cinza2,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: Fontes.fonte,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  comentario['user'],
                                                  style: TextStyle(
                                                    color: Cores.verde,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: Fontes.fonte,
                                                  ),
                                                ),
                                                Text(
                                                  comentario['desafio'],
                                                  style: TextStyle(
                                                    color: Cores.azul,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: Fontes.fonte,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
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
      ),
    );
  }
}
