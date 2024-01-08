import 'package:flutter/material.dart';
import 'package:modulo04/styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 150),
                Container(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/jogo'),
                  child: Text(
                    'Jogar',
                    style: TextStyle(
                      fontFamily: Fontes.fonte,
                      fontSize: 25,
                      color: Cores.verde,
                    ),
                  ),
                ),
                Container(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/config'),
                  child: Text(
                    'Configurações',
                    style: TextStyle(
                      fontFamily: Fontes.fonte,
                      fontSize: 25,
                      color: Cores.azul,
                    ),
                  ),
                ),
                Container(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/sair'),
                  child: Text(
                    'Sair',
                    style: TextStyle(
                      fontFamily: Fontes.fonte,
                      fontSize: 25,
                      color: Cores.vermelho,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
