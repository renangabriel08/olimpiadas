import 'package:flutter/material.dart';
import 'package:modulo02/styles/styles.dart';
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
        shadowColor: Cores.azul,
        leading: IconButton(
          onPressed: () => (),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Image.asset('assets/images/logo_rgb.png', height: 50),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/exercicio'),
                child: const MyCard(
                  label: 'Corrida',
                  icone: Icons.directions_run_outlined,
                ),
              ),
              Container(width: width * .1),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/exercicio'),
                child: const MyCard(
                  label: 'Caminhada',
                  icone: Icons.directions_walk_outlined,
                ),
              ),
            ],
          ),
          Container(height: height * .05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => (),
                child: const MyCard(
                  label: 'Pular corda',
                  icone: Icons.accessibility,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
