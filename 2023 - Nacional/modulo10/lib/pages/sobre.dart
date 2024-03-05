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
      body: Container(
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.arrow_back_ios),
                        Text(
                          palavras[0],
                          style: TextStyle(
                            fontFamily: Fonts.font,
                            fontSize: size,
                          ),
                        )
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
      ),
    );
  }
}
