import 'package:flutter/material.dart';
import 'package:modulo02/pages/iniciar.dart';
import 'package:modulo02/widgets/card.dart';

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
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png', height: 50),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: const Icon(Icons.arrow_back),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardHome(
                width: width,
                height: height,
                onTap: () => Navigator.pushNamed(
                  context,
                  Iniciar.routeName,
                  arguments: IniciarArguments('Corrida'),
                ),
                icone: Icons.directions_run,
                txt: 'Corrida',
              ),
              Container(width: width * .1),
              CardHome(
                width: width,
                height: height,
                onTap: () => Navigator.pushNamed(
                  context,
                  Iniciar.routeName,
                  arguments: IniciarArguments('Caminhada'),
                ),
                icone: Icons.directions_run,
                txt: 'Caminhada',
              ),
            ],
          ),
          Container(height: height * .05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardHome(
                width: width,
                height: height,
                onTap: () => (),
                icone: Icons.directions_run,
                txt: 'Pular Corda',
              ),
            ],
          )
        ],
      ),
    );
  }
}
