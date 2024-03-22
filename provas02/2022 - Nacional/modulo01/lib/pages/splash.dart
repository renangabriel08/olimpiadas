import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modulo01/controllers/cache.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  int i = 6;

  set(value) {
    if (value == null) {
      i = 6;
    } else {
      i = 3;
    }

    Future.delayed(Duration(seconds: i)).then(
      (value) => Navigator.pushNamed(context, '/login'),
    );
  }

  @override
  void initState() {
    Future.wait([CacheController.getLog()]).then((value) => set(value[0]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Center(
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
