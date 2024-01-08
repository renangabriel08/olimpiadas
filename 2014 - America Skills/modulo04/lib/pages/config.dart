import 'package:flutter/material.dart';
import 'package:modulo04/styles/styles.dart';

class Config extends StatefulWidget {
  const Config({super.key});

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
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
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Configurações de Partida',
                    style: TextStyle(
                      fontFamily: Fontes.fonte,
                      fontSize: 25,
                      color: Cores.vermelho,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.timer,
                      ),
                      label: Text(
                        'Tempo',
                        style: TextStyle(
                          fontFamily: Fontes.fonte,
                        ),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
