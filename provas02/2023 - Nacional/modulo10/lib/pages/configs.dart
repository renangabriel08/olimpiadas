import 'package:flutter/material.dart';
import 'package:modulo10/controllers/cache.dart';
import 'package:modulo10/controllers/configs.dart';
import 'package:modulo10/styles/styles.dart';

class Configs extends StatefulWidget {
  const Configs({super.key});

  @override
  State<Configs> createState() => _ConfigsState();
}

class _ConfigsState extends State<Configs> {
  bool loading = true;

  double vSlider = 0;
  List palavras = [];
  double size = 16;
  Color t1 = const Color(0xFF000000);
  Color t2 = const Color(0xFF000000);
  Color bg = const Color(0xFFFFFFFF);

  String idiomaS = 'pt';
  List<Map> idiomas = [];

  String temaS = 'c';
  List<Map> temas = [];

  String dautonismoS = 'a';
  List<Map> dautonismos = [];

  setar(value) {
    palavras = value[0];

    idiomas = [
      {
        'id': 'pt',
        'value': palavras[4],
      },
      {
        'id': 'en',
        'value': palavras[5],
      },
      {
        'id': 'es',
        'value': palavras[6],
      }
    ];

    temas = [
      {
        'id': 'c',
        'value': palavras[9],
      },
      {
        'id': 'e',
        'value': palavras[10],
      },
    ];

    dautonismos = [
      {
        'id': 'a',
        'value': palavras[12],
      },
      {
        'id': 'd',
        'value': palavras[13],
      },
    ];

    if (value[1] == 'p') {
      size = 12;
      vSlider = 0;
    }
    if (value[1] == 'm') {
      size = 16;
      vSlider = 0.5;
    }
    if (value[1] == 'g') {
      size = 18;
      vSlider = 1;
    }

    if (value[3] == 'd') {
      t1 = const Color(0xFF283B87);
      t2 = const Color(0xFF86D35A);
      bg = Colors.white;
    } else {
      if (value[2] == 'c') {
        t1 = const Color(0xFF004576);
        t2 = const Color(0xFFEBB565);
        bg = Colors.white;
      }
      if (value[2] == 'e') {
        t1 = Colors.white;
        t2 = Colors.white;
        bg = Colors.black;
      }
    }

    loading = false;
    setState(() {});
  }

  setTema(value) async {
    CacheController.setTema(value);

    setState(() {});
  }

  setTamanho(value) async {
    vSlider = value;

    if (vSlider == 0) {
      CacheController.setTamanho('p');
    }
    if (vSlider == 0.5) {
      CacheController.setTamanho('m');
    }
    if (vSlider == 1) {
      CacheController.setTamanho('g');
    }

    setState(() {});
  }

  setIdioma(value) async {
    idiomaS = value;
    await CacheController.setIdioma(idiomaS);

    setState(() {});
  }

  setDautonismo(value) async {
    CacheController.setDaltonismo(value);
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([ConfigsController.getConfigs()])
        .then((value) => setar(value[0]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: !loading
          ? Container(
              width: width,
              height: height,
              color: bg,
              child: FutureBuilder(
                future: ConfigsController.getConfigs(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    palavras = snapshot.data![0];

                    idiomas = [
                      {
                        'id': 'pt',
                        'value': palavras[4],
                      },
                      {
                        'id': 'en',
                        'value': palavras[5],
                      },
                      {
                        'id': 'es',
                        'value': palavras[6],
                      }
                    ];

                    temas = [
                      {
                        'id': 'c',
                        'value': palavras[9],
                      },
                      {
                        'id': 'e',
                        'value': palavras[10],
                      },
                    ];

                    dautonismos = [
                      {
                        'id': 'a',
                        'value': palavras[12],
                      },
                      {
                        'id': 'd',
                        'value': palavras[13],
                      },
                    ];

                    if (snapshot.data![1] == 'p') {
                      size = 12;
                      vSlider = 0;
                    }
                    if (snapshot.data![1] == 'm') {
                      size = 16;
                      vSlider = 0.5;
                    }
                    if (snapshot.data![1] == 'g') {
                      size = 18;
                      vSlider = 1;
                    }

                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => (),
                                icon: const Icon(Icons.arrow_back),
                              ),
                              Text(
                                palavras[1],
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size * 1.7,
                                  color: t1,
                                ),
                              ),
                            ],
                          ),
                          Container(height: 30),
                          Row(
                            children: [
                              Text(
                                palavras[2],
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size * 1.3,
                                  color: t1,
                                ),
                              ),
                            ],
                          ),
                          Container(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                palavras[3],
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size,
                                  color: t1,
                                ),
                              ),
                              SizedBox(
                                width: width * .5,
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  value: idiomaS,
                                  items: [
                                    for (var i in idiomas)
                                      DropdownMenuItem(
                                        value: i['id'],
                                        child: Text(
                                          i['value'],
                                          style: TextStyle(
                                            fontFamily: Fonts.font,
                                            fontSize: size,
                                            color: t1,
                                          ),
                                        ),
                                      ),
                                  ],
                                  onChanged: (value) => setIdioma(value),
                                ),
                              ),
                            ],
                          ),
                          Container(height: 15),
                          Row(
                            children: [
                              Text(
                                palavras[7],
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size * 1.3,
                                  color: t1,
                                ),
                              ),
                            ],
                          ),
                          Container(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                palavras[8],
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size,
                                  color: t1,
                                ),
                              ),
                              SizedBox(
                                width: width * .5,
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  value: temaS,
                                  items: [
                                    for (var i in temas)
                                      DropdownMenuItem(
                                        value: i['id'],
                                        child: Text(
                                          i['value'],
                                          style: TextStyle(
                                            fontFamily: Fonts.font,
                                            fontSize: size,
                                            color: t1,
                                          ),
                                        ),
                                      ),
                                  ],
                                  onChanged: (value) => setTema(value),
                                ),
                              ),
                            ],
                          ),
                          Container(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                palavras[11],
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size,
                                  color: t1,
                                ),
                              ),
                              SizedBox(
                                width: width * .5,
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  value: dautonismoS,
                                  items: [
                                    for (var i in dautonismos)
                                      DropdownMenuItem(
                                        value: i['id'],
                                        child: Text(
                                          i['value'],
                                          style: TextStyle(
                                            fontFamily: Fonts.font,
                                            fontSize: size,
                                            color: t1,
                                          ),
                                        ),
                                      ),
                                  ],
                                  onChanged: (value) => setDautonismo(value),
                                ),
                              ),
                            ],
                          ),
                          Container(height: 15),
                          Row(
                            children: [
                              Text(
                                palavras[14],
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size * 1.3,
                                  color: t1,
                                ),
                              ),
                            ],
                          ),
                          Container(height: 15),
                          Slider(
                            divisions: 2,
                            value: vSlider,
                            onChanged: (value) => setTamanho(value),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                palavras[15],
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size,
                                  color: t1,
                                ),
                              ),
                              Text(
                                palavras[16],
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size,
                                  color: t1,
                                ),
                              ),
                              Text(
                                palavras[17],
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size,
                                  color: t1,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
