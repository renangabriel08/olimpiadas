import 'package:flutter/material.dart';
import 'package:modulo05/styles/styles.dart';

class ErroRelogio extends StatefulWidget {
  const ErroRelogio({super.key});

  @override
  State<ErroRelogio> createState() => _ErroRelogioState();
}

class _ErroRelogioState extends State<ErroRelogio> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Cores.cinza,
      body: Container(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/images/logoP.png'),
              Textos.txt(
                'Falha no Login',
                12,
                TextAlign.center,
                Cores.vermelho,
                FontWeight.w400,
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/loginRelogio'),
                child: Container(
                  width: width,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Cores.ciano,
                  ),
                  child: Center(
                    child: Textos.txt(
                      'Tente novamente',
                      12,
                      TextAlign.center,
                      Cores.cinza,
                      FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
