import 'package:flutter/material.dart';
import 'package:modulo01/styles/styles.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) => Navigator.pushNamed(context, '/tutorial'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Cores.cinza1,
        child: Padding(
          padding: const EdgeInsets.all(60),
          child: Center(
            child: Image.asset('assets/logo1.png'),
          ),
        ),
      ),
    );
  }
}
