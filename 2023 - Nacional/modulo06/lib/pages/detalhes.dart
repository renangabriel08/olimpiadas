import 'package:flutter/material.dart';
import 'package:modulo06/controllers/user.dart';
import 'package:modulo06/styles/styles.dart';

class Detalhes extends StatefulWidget {
  const Detalhes({super.key});
  static const routeName = '/detalhes';

  @override
  State<Detalhes> createState() => _DetalhesState();
}

class ScreenArguments {
  final String end;
  final String dt;
  final List fts;

  ScreenArguments(this.end, this.dt, this.fts);
}

class _DetalhesState extends State<Detalhes> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      body: FutureBuilder(
        future: UserController.getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Map user = snapshot.data as Map;

            return Container(
              width: width,
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        user['foto'] == null
                            ? const CircleAvatar(
                                child: Center(
                                  child: Icon(
                                    Icons.person,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                child: Image.network(
                                  user['foto'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                        Container(width: 10),
                        Textos.txt1(user['nome'], Cores.azul1),
                      ],
                    ),
                    Container(height: height * .02),
                    Textos.txt2('Check-ins', Cores.azul1),
                    Container(height: height * .01),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                      child: Container(
                        width: width,
                        height: height * .25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: Cores.azul1,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: width,
                              height: height * .17,
                              child: args.fts.isEmpty
                                  ? Icon(
                                      Icons.image,
                                      size: width * .3,
                                    )
                                  : Image.network(
                                      args.fts[0],
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Container(
                              width: width,
                              height: 1,
                              color: Cores.azul1,
                            ),
                            SizedBox(
                              height: height * .065,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  5,
                                  0,
                                  0,
                                  0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Textos.txt1(
                                          args.end.toString(),
                                          Cores.azul1,
                                        ),
                                        Textos.txt1(
                                          'Visitado em: ${args.dt.replaceFirst('T', ' - ').substring(0, args.dt.length - 2)}',
                                          Cores.azul1,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(height: height * .03),
                    ElevatedButton(
                      onPressed: () => (),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Textos.txt1('Adicionar imagem', Cores.azul1),
                    ),
                    Container(height: height * .03),
                    args.fts.isEmpty
                        ? Textos.txt1(
                            'Nenhuma imagem adicionada',
                            Cores.azul1,
                          )
                        : Row(
                            children: [
                              for (var img in args.fts)
                                Container(
                                  width: width * .25,
                                  height: height * .2,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: Cores.azul1,
                                    ),
                                  ),
                                  child: Image.network(
                                    img,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            ],
                          )
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
