import 'package:flutter/material.dart';
import 'package:modulo10/controllers/app.dart';
import 'package:modulo10/styles/styles.dart';

class Sobre extends StatefulWidget {
  const Sobre({super.key});

  @override
  State<Sobre> createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
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

              double size = tamanho == 'P'
                  ? 14
                  : tamanho == 'M'
                      ? 16
                      : 20;

              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.arrow_back_ios),
                          Text(
                            palavras[17],
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: size,
                            ),
                          ),
                        ],
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
                            onTap: () => (),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                color: Colors.black,
                              ),
                              child: const Icon(
                                Icons.install_desktop,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => (),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                color: Colors.black,
                              ),
                              child: const Icon(
                                Icons.install_desktop,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => (),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                color: Colors.black,
                              ),
                              child: const Icon(
                                Icons.install_desktop,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => (),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                color: Colors.black,
                              ),
                              child: const Icon(
                                Icons.install_desktop,
                                color: Colors.white,
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
                                color: Colors.black,
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
                                color: Colors.black,
                                fontSize: size,
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
                                color: Colors.black,
                                fontSize: size,
                              ),
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
      ),
    );
  }
}
