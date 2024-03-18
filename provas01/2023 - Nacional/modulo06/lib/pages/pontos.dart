import 'package:flutter/material.dart';
import 'package:modulo06/controllers/user.dart';
import 'package:modulo06/styles/styles.dart';

class Pontos extends StatefulWidget {
  const Pontos({super.key});

  @override
  State<Pontos> createState() => _PontosState();
}

class _PontosState extends State<Pontos> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder(
        future: UserController.getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Map user = snapshot.data as Map;

            return Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                width: width,
                height: height,
                child: Column(
                  children: [
                    Row(
                      children: [
                        user['foto'] == null
                            ? const CircleAvatar(
                                child: Center(
                                  child: Icon(
                                    Icons.person,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                child: Image.network(
                                  user['foto'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                        Container(width: 10),
                        Textos.txt1(user['nome'], Cores.azul1),
                      ],
                    ),
                    Container(height: height * .07),
                    Textos.txt2('Lugares Visitados', Cores.azul1),
                    Container(height: height * .03),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(width, 50),
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/check'),
                      child: Textos.txt1('Check-ins', Cores.azul1),
                    ),
                    Container(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(width, 50),
                      ),
                      onPressed: () => (),
                      child: Textos.txt1('Salvos', Cores.azul1),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
