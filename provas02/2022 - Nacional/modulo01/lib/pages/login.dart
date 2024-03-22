import 'package:flutter/material.dart';
import 'package:modulo01/styles/styles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Center(
            child: MyText(
              txt: 'Login',
              size: 32,
              textAlign: TextAlign.center,
              cor: Cores.ciano,
            ),
          ),
        ),
      ),
    );
  }
}
