import 'dart:math';

import 'package:flutter/material.dart';
import 'package:modulo02/styles/styles.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Bussola extends StatefulWidget {
  const Bussola({super.key});

  @override
  State<Bussola> createState() => _BussolaState();
}

class _BussolaState extends State<Bussola> {
  double angulo = 0;

  @override
  void initState() {
    magnetometerEvents.listen(
      (MagnetometerEvent event) {
        setState(() {
          angulo = atualizarAngulo(event.x, event.y);
        });
      },
      onError: (error) {},
      cancelOnError: true,
    );

    super.initState();
  }

  atualizarAngulo(x, y) {
    double a = -1 * (180 / 3.14) * atan2(y, x);

    if (a < 0) {
      a += 360;
    }

    return a;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Cores.verde,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Bússola',
          style: TextStyle(
            color: Cores.cinza1,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: Fontes.fonte,
          ),
        ),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset('assets/images/img2.png'),
                Positioned(
                  top: height * .035,
                  left: width * .38,
                  child: Transform.rotate(
                    angle: angulo * (3.14 / 180),
                    child: Image.asset('assets/images/img1.png'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
