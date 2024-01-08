import 'package:flutter/material.dart';
import 'package:modulo04/controllers/api.dart';
import 'package:modulo04/pages/configuracoes.dart';
import 'package:modulo04/pages/home.dart';
import 'package:modulo04/pages/roteiro.dart';
import 'package:modulo04/pages/viajante.dart';
import 'package:modulo04/styles/styles.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});
  static const routeName = '/inicio';

  @override
  State<Inicio> createState() => _InicioState();
}

class ScreenArguments {
  final String token;

  ScreenArguments(this.token);
}

class _InicioState extends State<Inicio> {
  int pg = 0;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return FutureBuilder(
      future: ApiController.getUser(args.token),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map user = snapshot.data as Map;
          print(user['fotoPerfil']);

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
                        // Image.network(
                        //   'https://randomuser.me/api/portraits/men/75.jpg',
                        //   width: 100,
                        //   height: 100,
                        // ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user['name'],
                              style: TextStyle(
                                fontFamily: Fontes.fonte,
                                color: Cores.azulClaro,
                              ),
                            ),
                            Text(
                              user['email'],
                              style: TextStyle(
                                fontFamily: Fontes.fonte,
                                color: Cores.azulEscuro,
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
                        leading: Icon(
                          Icons.home,
                          color: Cores.verdeEscuro,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          pg = 0;
                          setState(() {});
                        },
                        title: Text(
                          'Home',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            color: Cores.verdeMedio,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.public,
                          color: Cores.verdeEscuro,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          pg = 1;
                          setState(() {});
                        },
                        title: Text(
                          'Roteiro Personalizado',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            color: Cores.verdeMedio,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.work_rounded,
                          color: Cores.verdeEscuro,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          pg = 2;
                          setState(() {});
                        },
                        title: Text(
                          'Viajante Gamificado',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            color: Cores.verdeMedio,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Cores.verdeEscuro,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          pg = 3;
                          setState(() {});
                        },
                        title: Text(
                          'Configurações',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            color: Cores.verdeMedio,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Cores.verdeEscuro,
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        title: Text(
                          'Sair',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                            color: Cores.verdeMedio,
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
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
