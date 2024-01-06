import 'package:flutter/material.dart';
import 'package:modulo04/pages/configuracoes.dart';
import 'package:modulo04/pages/home.dart';
import 'package:modulo04/pages/roteiro.dart';
import 'package:modulo04/pages/viajante.dart';
import 'package:modulo04/styles/styles.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int pg = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'EUVOUNATRIP',
            style: TextStyle(
              fontFamily: 'Way',
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.amber,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nome',
                        style: TextStyle(
                          fontFamily: Fontes.fonte,
                        ),
                      ),
                      Text(
                        'email@gmail.com',
                        style: TextStyle(
                          fontFamily: Fontes.fonte,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                    pg = 0;
                    setState(() {});
                  },
                  title: Text(
                    'Home',
                    style: TextStyle(
                      fontFamily: Fontes.fonte,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                    pg = 1;
                    setState(() {});
                  },
                  title: Text(
                    'Roteiro Personalizado',
                    style: TextStyle(
                      fontFamily: Fontes.fonte,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                    pg = 2;
                    setState(() {});
                  },
                  title: Text(
                    'Viajante Gamificado',
                    style: TextStyle(
                      fontFamily: Fontes.fonte,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context);
                    pg = 3;
                    setState(() {});
                  },
                  title: Text(
                    'Configurações',
                    style: TextStyle(
                      fontFamily: Fontes.fonte,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  title: Text(
                    'Sair',
                    style: TextStyle(
                      fontFamily: Fontes.fonte,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: IndexedStack(
        index: pg,
        children: const [
          Home(),
          Roteiro(),
          Viajante(),
          Configuracoes(),
        ],
      ),
    );
  }
}
