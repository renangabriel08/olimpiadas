// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modulo03/controllers/cache.dart';
import 'package:modulo03/pages/scores.dart';
import 'package:modulo03/styles/styles.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/MazeLogo_B.svg',
                semanticsLabel: 'logo',
              ),
              SizedBox(height: height * .1),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/jogo'),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(width, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Textos.subTitulo('Jogar', Cores.azulClaro),
              ),
              SizedBox(height: height * .02),
              ElevatedButton(
                onPressed: () async {
                  final ultimoScore = await CacheController.getUltimoScore();

                  Navigator.pushNamed(
                    context,
                    Scores.routeName,
                    arguments: ScoresArguments(
                      ultimoScore == null ? '00:00:00' : ultimoScore[1],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(width, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Textos.subTitulo('Scores', Cores.azulClaro),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
