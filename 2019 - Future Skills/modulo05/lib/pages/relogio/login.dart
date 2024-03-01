import 'package:flutter/material.dart';
import 'package:modulo05/styles/styles.dart';

class LoginRelogio extends StatefulWidget {
  const LoginRelogio({super.key});

  @override
  State<LoginRelogio> createState() => _LoginRelogioState();
}

class _LoginRelogioState extends State<LoginRelogio> {
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
          padding: const EdgeInsets.all(21),
          child: Form(
            child: Column(
              children: [
                Image.asset('assets/images/logoP.png'),
                TextFormField(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Cores.ciano,
                    fixedSize: Size(width, 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: Textos.txt(
                    'Entrar',
                    12,
                    TextAlign.center,
                    Cores.cinza,
                    FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
