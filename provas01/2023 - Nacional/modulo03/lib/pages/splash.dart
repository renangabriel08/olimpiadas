import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modulo03/styles/styles.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    Future.wait([Future.delayed(const Duration(seconds: 3))]).then(
      (value) => Navigator.pushNamed(context, '/login'),
    );

    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/imgs/Logo.png',
              width: width * .7,
            ),
            Container(height: height * .2),
            Textos.txt1('Carregando...', TextAlign.center, Cores.verde3),
            Container(height: height * .02),
            SizedBox(
              width: width * .5,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _controller.value,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
