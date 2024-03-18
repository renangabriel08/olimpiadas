import 'package:flutter/material.dart';
import 'package:modulo10/controllers/app.dart';
import 'package:modulo10/styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: t1,
                        ),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          '/config',
                        ),
                        child: Text(
                          palavras[0],
                          style: TextStyle(
                            fontFamily: Fonts.font,
                            fontSize: size,
                            color: bg,
                          ),
                        ),
                      ),
                      Container(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: t1,
                        ),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          '/sobre',
                        ),
                        child: Text(
                          palavras[21],
                          style: TextStyle(
                            fontFamily: Fonts.font,
                            fontSize: size,
                            color: bg,
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
