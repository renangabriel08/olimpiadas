import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modulo03/models/user.dart';
import 'package:modulo03/styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Timer? timer;

  int s = 0;
  int m = 1;
  int h = 1;

  start() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (s == 0 && m == 0 && h == 0) {
        modal();
      } else if (s == 0 && m == 0) {
        h--;
        s = 59;
        m = 59;
      } else if (s == 0) {
        s = 59;
        if (m != 0) {
          m--;
        }
      } else {
        s--;
      }
      setState(() {});
    });
  }

  Future<void> modal() async {
    timer!.cancel();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Textos.txt2(
            'Atenção!',
            TextAlign.start,
            Cores.azul2,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Textos.txt1(
                  'Seu tempo de expiração chegou ao fim! Escolha uma opção!',
                  TextAlign.start,
                  Cores.azul1,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Textos.txt1(
                'Fechar app',
                TextAlign.center,
                Cores.azul1,
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
            TextButton(
              child: Textos.txt1(
                'Voltar ao login',
                TextAlign.center,
                Cores.azul1,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print(User.user);

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Textos.txt1('Inicio', TextAlign.start, Cores.verde3),
                  Textos.txt1('$h:$m:$s', TextAlign.start, Cores.verde3),
                  IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    icon: Icon(
                      Icons.logout,
                      color: Cores.verde3,
                    ),
                  ),
                ],
              ),
              Container(height: height * .02),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(width: 3, color: Cores.verde3),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: Image.network(User.user!['fotoPerfil']),
                    ),
                  ),
                  Container(width: width * .03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      User.user!['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'] !=
                              'Comum'
                          ? FaIcon(
                              FontAwesomeIcons.crown,
                              color: Cores.azul1,
                            )
                          : Container(),
                      Textos.txt1(
                        User.user!['name'],
                        TextAlign.start,
                        Cores.verde3,
                      ),
                      Textos.txt1(
                        User.user!['email'],
                        TextAlign.start,
                        Cores.verde3,
                      ),
                      Textos.txt1(
                        User.user!['dr'],
                        TextAlign.start,
                        Cores.verde3,
                      ),
                    ],
                  ),
                ],
              ),
              Container(height: height * .06),
              if (TimeOfDay.now().hour >= 0 && TimeOfDay.now().hour < 12)
                Textos.txt1(
                  'Bom dia, ${User.user!['name']}',
                  TextAlign.start,
                  Cores.verde3,
                ),
              if (TimeOfDay.now().hour >= 12 && TimeOfDay.now().hour < 18)
                Textos.txt1(
                  'Boa tarde, ${User.user!['name']}',
                  TextAlign.start,
                  Cores.verde3,
                ),
              if (TimeOfDay.now().hour >= 18 && TimeOfDay.now().hour < 24)
                Textos.txt1(
                  'Boa noite, ${User.user!['name']}',
                  TextAlign.start,
                  Cores.verde3,
                ),
            ],
          ),
        ),
      ),
    );
  }
}