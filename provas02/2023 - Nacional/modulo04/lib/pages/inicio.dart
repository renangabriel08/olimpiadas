import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:modulo04/controllers/login.dart';
import 'package:modulo04/pages/outros.dart';
import 'package:modulo04/styles/styles.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int index = 0;
  Map<String, dynamic>? user;

  @override
  void initState() {
    if (LoginController.token != '') {
      user = JwtDecoder.decode(LoginController.token);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Textos.padrao(
          'EUVOUNATRIP',
          TextAlign.center,
          Cores.verdeClaro,
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(width: 2, color: Cores.azulEscuro),
                    ),
                    child: user != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: Image.network(user!['fotoPerfil']),
                          )
                        : const Icon(
                            Icons.person,
                            size: 60,
                          ),
                  ),
                  Container(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textos.padrao(
                        user != null ? user!['name'] : 'Local user',
                        TextAlign.start,
                        Cores.azulEscuro,
                      ),
                      Textos.padrao(
                        user != null ? user!['email'] : 'Local user',
                        TextAlign.start,
                        Cores.azulClaro,
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Cores.azulEscuro),
              title: Textos.padrao('Home', TextAlign.start, Cores.azulClaro),
              onTap: () {
                index = 0;
                Navigator.pop(context);
                setState(() {});
              },
            ),
            ListTile(
              leading: Icon(Icons.public, color: Cores.azulEscuro),
              title: Textos.padrao(
                'Roteiro Personalizado',
                TextAlign.start,
                Cores.azulClaro,
              ),
              onTap: () {
                index = 1;
                Navigator.pop(context);
                setState(() {});
              },
            ),
            ListTile(
              leading: Icon(Icons.work, color: Cores.azulEscuro),
              title: Textos.padrao(
                ' Viajante Gamificado',
                TextAlign.start,
                Cores.azulClaro,
              ),
              onTap: () {
                index = 2;
                Navigator.pop(context);
                setState(() {});
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Cores.azulEscuro),
              title: Textos.padrao(
                'Configurações',
                TextAlign.start,
                Cores.azulClaro,
              ),
              onTap: () {
                index = 3;
                Navigator.pop(context);
                setState(() {});
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Cores.azulEscuro),
              title: Textos.padrao('Sair', TextAlign.start, Cores.azulClaro),
              onTap: () {
                LoginController.token = '';
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: index,
        children: const [
          Outros(titulo: 'Home'),
          Outros(titulo: 'Tela Roteiro Personalizado'),
          Outros(titulo: 'Tela Viajante Gamificado'),
          Outros(titulo: 'Tela Configurações de Usuário'),
        ],
      ),
    );
  }
}
