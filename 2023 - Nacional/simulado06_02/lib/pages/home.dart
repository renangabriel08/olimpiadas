import 'package:flutter/material.dart';
import 'package:simulado06_02/pages/config.dart';
import 'package:simulado06_02/pages/locais.dart';
import 'package:simulado06_02/pages/mapa.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pgSelecionada = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pgSelecionada,
        children: const [
          Mapa(),
          Locais(),
          Configs(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() {
          pgSelecionada = value;
        }),
        currentIndex: pgSelecionada,
        items: const [
          BottomNavigationBarItem(
            label: 'Mapa',
            icon: Icon(Icons.map),
          ),
          BottomNavigationBarItem(
            label: 'Locais',
            icon: Icon(Icons.list_alt_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Configurações',
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
