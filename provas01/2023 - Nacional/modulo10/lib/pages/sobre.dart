import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modulo10/controllers/app.dart';
import 'package:modulo10/styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class Sobre extends StatefulWidget {
  const Sobre({super.key});

  @override
  State<Sobre> createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  void openURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
  }

  Color bg = Colors.white;
  Color t1 = const Color(0xFF283B87);
  Color t2 = const Color(0xFF3EB1B1);

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
              String daltonico = data[3];

              double size = tamanho == 'P'
                  ? 14
                  : tamanho == 'M'
                      ? 16
                      : 20;

              if (daltonico == 'D') {
                if (tema == 'E') {
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
                  child: SingleChildScrollView(
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
                                palavras[17],
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size,
                                  color: t1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(height: height * .02),
                        Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: Color(0xFF283b87),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset('assets/images/Logo.png'),
                          ),
                        ),
                        Container(height: height * .05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () => openURL('https://instagram.com'),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  color: t1,
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
                              onTap: () => openURL('https://twitter.com'),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  color: t1,
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
                              onTap: () => openURL('https://facebook.com'),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  color: t1,
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
                              onTap: () => openURL('https://youtube.com'),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  color: t1,
                                ),
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.youtube,
                                    color: bg,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(height: height * .05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * .55,
                              child: Text(
                                palavras[18],
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  color: t1,
                                  fontSize: size,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * .3,
                              child: Image.asset(
                                'assets/images/Icon.png',
                                height: width * .3,
                              ),
                            ),
                          ],
                        ),
                        Container(height: height * .05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width * .89,
                              child: Text(
                                palavras[19],
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size,
                                  color: t1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(height: height * .05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * .3,
                              child: Image.asset(
                                'assets/images/Icon.png',
                                height: width * .3,
                              ),
                            ),
                            SizedBox(
                              width: width * .55,
                              child: Text(
                                palavras[20],
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size,
                                  color: t1,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
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
