import 'package:flutter/material.dart';
import 'package:modulo02/controllers/classificacao.dart';
import 'package:modulo02/controllers/home.dart';
import 'package:modulo02/controllers/lista.dart';
import 'package:modulo02/styles/styles.dart';

class Classificacao extends StatefulWidget {
  const Classificacao({super.key});

  @override
  State<Classificacao> createState() => _ClassificacaoState();
}

class _ClassificacaoState extends State<Classificacao> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Cores.verde,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Classificação Geral',
          style: TextStyle(
            color: Cores.cinza1,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: Fontes.fonte,
          ),
        ),
      ),
      body: Container(
        height: height,
        color: Cores.cinza1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                FutureBuilder(
                  future: ClassificacaoController.getLista(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List data = snapshot.data as List;

                      data.sort(
                        (a, b) => b['nivel'].compareTo(a['nivel']),
                      );

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            FutureBuilder(
                              future: HomeController.getUser(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Map user = snapshot.data as Map;

                                  return Container(
                                    width: 156,
                                    height: 156,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(999),
                                      color: Cores.amarelo,
                                      border: Border.all(
                                        width: 3,
                                        color: Cores.preto,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.emoji_events,
                                          size: 40,
                                        ),
                                        Text(
                                          user['nivel'],
                                          style: TextStyle(
                                            color: Cores.cinza1,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: Fontes.fonte,
                                          ),
                                        ),
                                        Container(
                                          width: 51,
                                          height: 51,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(999),
                                            color: Cores.amarelo,
                                            border: Border.all(
                                              width: 3,
                                              color: Cores.preto,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              999,
                                            ),
                                            child: Image.network(
                                              user['avatar'],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                            Container(height: 50),
                            for (var i in data)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                                child: Container(
                                  width: width,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Cores.preto,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          i['nome'],
                                          style: TextStyle(
                                            color: Cores.amarelo,
                                          ),
                                        ),
                                        Text(
                                          'Nível ${i['nivel']}',
                                          style: TextStyle(
                                            color: Cores.amarelo,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
