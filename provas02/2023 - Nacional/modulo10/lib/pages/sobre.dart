import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modulo10/controllers/configs.dart';
import 'package:modulo10/styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class Sobre extends StatefulWidget {
  const Sobre({super.key});

  @override
  State<Sobre> createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  bool loading = true;
  bool animado = false;

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

    if (value[3] == 'a') {
      t1 = const Color(0xFF004576);
      t2 = const Color(0xFFEBB565);
      bg = Colors.white;
    } else {
      if (value[2] == 'c') {
        t1 = const Color(0xFF283B87);
        t2 = const Color(0xFF86D35A);
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

  animar() async {
    animado = !animado;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 1000));
    animado = false;
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
              color: bg,
              width: width,
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/configs',
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              '/configs',
                            ),
                            icon: const Icon(Icons.arrow_back),
                          ),
                          Text(
                            palavras[18],
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: size * 1.7,
                              color: t1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 230,
                      height: 230,
                      decoration: BoxDecoration(
                        color: const Color(0xFF283b87),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () => animar(),
                          child: animado
                              ? Image.asset(
                                  'assets/images/logo.png',
                                  width: 110,
                                ).animate().slideX(duration: 1000.ms)
                              : Image.asset(
                                  'assets/images/logo.png',
                                  width: 170,
                                ),
                        ),
                      ),
                    ),
                    Container(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await launchUrl(Uri.parse('https://instagram.com'));
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: t1,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.instagram,
                                color: bg,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await launchUrl(Uri.parse('https://twitter.com'));
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: t1,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.twitter,
                                color: bg,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await launchUrl(Uri.parse('https://facebook.com'));
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: t1,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.facebook,
                                color: bg,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await launchUrl(Uri.parse('https://youtube.com'));
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: t1,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.youtube,
                                color: bg,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * .67,
                          child: Text(
                            palavras[19],
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: size * 1,
                              color: t1,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * .2,
                          child: Icon(
                            Icons.map,
                            color: t1,
                            size: width * .2,
                          ),
                        )
                      ],
                    ),
                    Container(height: 30),
                    SizedBox(
                      width: width,
                      child: Text(
                        palavras[19],
                        style: TextStyle(
                          fontFamily: Fonts.font,
                          fontSize: size * 1,
                          color: t1,
                        ),
                      ),
                    ),
                    Container(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * .2,
                          child: Icon(
                            Icons.map,
                            color: t1,
                            size: width * .2,
                          ),
                        ),
                        SizedBox(
                          width: width * .67,
                          child: Text(
                            palavras[19],
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: size * 1,
                              color: t1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          '/configs',
        ),
        child: const Icon(Icons.settings),
      ),
    );
  }
}