import 'package:flutter/material.dart';
import 'package:modulo03/controllers/api.dart';
import 'package:modulo03/styles/styles.dart';

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

    return FutureBuilder(
      future: GetUser.getUser(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3RlQGdtYWlsLmNvbSIsImlkX3VzdWFyaW8iOjEsIm5vbWUiOiJ0ZXN0ZSIsImlhdCI6MTcwNDM5MTk3NH0.yop5RbAMWFb9CfgjvX0GB5c87Bx66OrcaNKBSe3yq8Q',
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var dataUser = snapshot.data as Map;

          return Scaffold(
            body: SizedBox(
              width: width,
              height: height,
              child: Column(
                children: [
                  //Cabeçalho
                  Container(
                    height: height * .2,
                    decoration: BoxDecoration(
                      color: Cores.ciano,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(color: Colors.white),
                              ),
                              child: const CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(width: 5),
                            Text(
                              dataUser['usuario'],
                              style: TextStyle(
                                fontFamily: Fontes.fonte,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.monetization_on_outlined,
                              color: Colors.white,
                              size: 35,
                            ),
                            Container(width: 5),
                            Text(
                              '${dataUser['wscoins']}',
                              style: TextStyle(
                                fontFamily: Fontes.fonte,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: height * .8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(255, 255, 255, 255),
                                border: Border.all(color: Cores.cinza),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 1,
                                    offset: const Offset(1, 1),
                                    color: Cores.cinza,
                                  )
                                ],
                              ),
                              child: Icon(
                                Icons.person,
                                color: Cores.cinza,
                                size: 40,
                              ),
                            ),
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(255, 255, 255, 255),
                                border: Border.all(color: Cores.cinza),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 1,
                                    offset: const Offset(1, 1),
                                    color: Cores.cinza,
                                  )
                                ],
                              ),
                              child: Icon(
                                Icons.monetization_on_outlined,
                                color: Cores.cinza,
                                size: 40,
                              ),
                            ),
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(255, 255, 255, 255),
                                border: Border.all(color: Cores.cinza),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 1,
                                    offset: const Offset(1, 1),
                                    color: Cores.cinza,
                                  )
                                ],
                              ),
                              child: Icon(
                                Icons.settings,
                                color: Cores.cinza,
                                size: 40,
                              ),
                            ),
                          ],
                        ),

                        Container(height: 40),

                        //BTN 1
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/troca'),
                          child: Container(
                            width: width * .9,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  offset: const Offset(1, 1),
                                  color: Cores.cinza,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.published_with_changes_outlined,
                                ),
                                Container(width: 10),
                                Text(
                                  'Trocar minutos por WsCoins',
                                  style: TextStyle(
                                    fontFamily: Fontes.fonte,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(height: 40),

                        //BTN 2
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/quiz'),
                          child: Container(
                            width: width * .9,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  offset: const Offset(1, 1),
                                  color: Cores.cinza,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.quiz_outlined),
                                Container(width: 10),
                                Text(
                                  'Responder quiz por WsCoins',
                                  style: TextStyle(
                                    fontFamily: Fontes.fonte,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
