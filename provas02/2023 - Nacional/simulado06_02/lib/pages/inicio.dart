import 'package:flutter/material.dart';
import 'package:simulado06_02/pages/home.dart';
import 'package:simulado06_02/pages/outros.dart';
import 'package:simulado06_02/styles/styles.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int pg = 0;
  List<Widget> pages = [
    const Home(),
    const Outros(txt: 'Tela da Lista de Locais'),
    const Outros(txt: 'Tela do Mapa'),
    const Outros(txt: 'Tela de Configurações'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pg,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Cores.ciano,
        unselectedItemColor: Cores.cinza,
        currentIndex: pg,
        onTap: (value) => setState(() {
          pg = value;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Locais',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}
