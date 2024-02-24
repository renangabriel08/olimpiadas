import 'package:flutter/material.dart';
import 'package:modulo06/controllers/user.dart';
import 'package:modulo06/pages/detalhes.dart';
import 'package:modulo06/styles/styles.dart';

class Checkin extends StatefulWidget {
  const Checkin({super.key});

  @override
  State<Checkin> createState() => _CheckinState();
}

class _CheckinState extends State<Checkin> {
  @override
  void initState() {
    Future.wait([UserController.getCheckins()])
        .then((value) => setState(() => ()));
    super.initState();
  }

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

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
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
                    Textos.txt2('Check-ins', Cores.azul1),
                    Container(height: height * .03),
                    Column(
                      children: [
                        for (var i in UserController.checkins)
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              Detalhes.routeName,
                              arguments: ScreenArguments(
                                i['logradouro'].toString(),
                                i['dataHora'],
                                i['fotos'],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                              child: Container(
                                width: width,
                                height: height * .25,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2,
                                    color: Cores.azul1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: width,
                                      height: height * .19,
                                      child: i['fotos'].length == 0
                                          ? Icon(
                                              Icons.image,
                                              size: width * .3,
                                            )
                                          : Image.network(
                                              i['fotos'][0],
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    Container(
                                      width: width,
                                      height: 1,
                                      color: Cores.azul1,
                                    ),
                                    SizedBox(
                                      height: height * .045,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          5,
                                          0,
                                          0,
                                          0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Textos.txt1(
                                              i['logradouro'].toString(),
                                              Cores.azul1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
