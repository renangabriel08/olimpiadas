import 'package:flutter/material.dart';
import 'package:modulo10/controllers/app.dart';
import 'package:modulo10/controllers/idioma.dart';
import 'package:modulo10/controllers/tamanho.dart';
import 'package:modulo10/controllers/tema.dart';
import 'package:modulo10/styles/styles.dart';

class Configs extends StatefulWidget {
  const Configs({super.key});

  @override
  State<Configs> createState() => _ConfigsState();
}

class _ConfigsState extends State<Configs> {
  String vTf = 'P';
  String vTema = 'C';
  String vDaltonico = 'D';
  double sValue = 0;

  Color bg = Colors.white;
  Color t1 = const Color(0xFF283B87);
  Color t2 = const Color(0xFF3EB1B1);

  setar(value) {
    vTf = value[0];
    vTema = value[1];
    vDaltonico = value[2];
    sValue = value[3] == 'P'
        ? 0
        : value[3] == 'M'
            ? 1.5
            : 3;

    if (vDaltonico == 'D') {
      if (vTema == 'E') {
        bg = Colors.black;
        t1 = Colors.white;
        t2 = Colors.white;
      } else {
        bg = Colors.white;
        t1 = const Color(0xFF283B87);
        t2 = const Color(0xFF3EB1B1);
      }
    } else {
      bg = Colors.white;
      t1 = const Color(0xFF004576);
      t2 = const Color(0xFFA49CB7);
    }
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([
      IdiomaController.getIdioma(),
      TemaController.getTema(),
      TemaController.getDaltonico(),
      TamanhoController.getTamanho(),
    ]).then((value) => setar(value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: FutureBuilder(
          future: AppController.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data as List;
              List palavras = data[0];
              String tamanho = data[1];
              String tema = data[2];

              double size = tamanho == 'P'
                  ? 14
                  : tamanho == 'M'
                      ? 16
                      : 20;

              if (vDaltonico == 'D') {
                if (vTema == 'E') {
                  bg = Colors.black;
                  t1 = Colors.white;
                  t2 = Colors.white;
                } else {
                  bg = Colors.white;
                  t1 = const Color(0xFF283B87);
                  t2 = const Color(0xFF3EB1B1);
                }
              } else {
                bg = Colors.white;
                t1 = const Color(0xFF004576);
                t2 = const Color(0xFFA49CB7);
              }

              return Container(
                width: width,
                height: height,
                color: bg,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/home'),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: t1,
                            ),
                            Text(
                              palavras[0],
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                fontSize: size * 1.5,
                                color: t1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(height: height * .07),
                      Row(
                        children: [
                          Text(
                            palavras[1],
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: size * 1.5,
                              color: t1,
                            ),
                          )
                        ],
                      ),
                      Container(height: height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            palavras[2],
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: size,
                              color: t2,
                            ),
                          ),
                          SizedBox(
                            width: width * .5,
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              value: vTf,
                              items: [
                                DropdownMenuItem(
                                  value: 'P',
                                  child: Text(
                                    palavras[3],
                                    style: TextStyle(
                                      fontFamily: Fonts.font,
                                      fontSize: size,
                                      color: t2,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'I',
                                  child: Text(
                                    palavras[4],
                                    style: TextStyle(
                                      fontFamily: Fonts.font,
                                      fontSize: size,
                                      color: t2,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'E',
                                  child: Text(
                                    palavras[5],
                                    style: TextStyle(
                                      fontFamily: Fonts.font,
                                      fontSize: size,
                                      color: t2,
                                    ),
                                  ),
                                )
                              ],
                              onChanged: (value) async {
                                vTf = value!;
                                await IdiomaController.setIdioma(vTf);
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(height: height * .07),
                      Row(
                        children: [
                          Text(
                            palavras[6],
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: size * 1.5,
                              color: t1,
                            ),
                          )
                        ],
                      ),
                      Container(height: height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            palavras[7],
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: size,
                              color: t2,
                            ),
                          ),
                          SizedBox(
                            width: width * .5,
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              value: vTema,
                              items: [
                                DropdownMenuItem(
                                  value: 'C',
                                  child: Text(
                                    palavras[8],
                                    style: TextStyle(
                                      fontFamily: Fonts.font,
                                      fontSize: size,
                                      color: t2,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'E',
                                  child: Text(
                                    palavras[9],
                                    style: TextStyle(
                                      fontFamily: Fonts.font,
                                      fontSize: size,
                                      color: t2,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (value) async {
                                vTema = value!;
                                await TemaController.setTema(vTema);
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(height: height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            palavras[10],
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: size,
                              color: t2,
                            ),
                          ),
                          SizedBox(
                            width: width * .5,
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              value: vDaltonico,
                              items: [
                                DropdownMenuItem(
                                  value: 'D',
                                  child: Text(
                                    palavras[11],
                                    style: TextStyle(
                                      fontFamily: Fonts.font,
                                      fontSize: size,
                                      color: t2,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'A',
                                  child: Text(
                                    palavras[12],
                                    style: TextStyle(
                                      fontFamily: Fonts.font,
                                      fontSize: size,
                                      color: t2,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (value) async {
                                vDaltonico = value!;
                                await TemaController.setDaltonico(vDaltonico);
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(height: height * .07),
                      Row(
                        children: [
                          Text(
                            palavras[13],
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: size * 1.5,
                              color: t1,
                            ),
                          )
                        ],
                      ),
                      Container(height: height * .02),
                      Slider(
                        value: sValue,
                        max: 3,
                        divisions: 2,
                        onChanged: (value) async {
                          sValue = value;
                          sValue == 0
                              ? await TamanhoController.setTamanho('P')
                              : sValue == 1.5
                                  ? await TamanhoController.setTamanho('M')
                                  : await TamanhoController.setTamanho('G');

                          setState(() {});
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            palavras[14],
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: size,
                              color: t2,
                            ),
                          ),
                          Text(
                            palavras[15],
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: size,
                              color: t2,
                            ),
                          ),
                          Text(
                            palavras[16],
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: size,
                              color: t2,
                            ),
                          )
                        ],
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
