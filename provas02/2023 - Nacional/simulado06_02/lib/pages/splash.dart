import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simulado06_02/styles/styles.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.pushNamed(context, '/login'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', height: 300),
            Container(height: height * .1),
            Textos(
              txt: 'GoGo Trip',
              textAlign: TextAlign.center,
              cor: Cores.ciano,
              size: 45,
              weight: FontWeight.bold,
            ),
            Container(height: 20),
            CircularProgressIndicator(color: Cores.ciano),
            Container(height: height * .07),
          ],
        ),
      ),
    );
  }
}
