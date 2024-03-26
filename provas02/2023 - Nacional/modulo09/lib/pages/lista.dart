import 'package:flutter/material.dart';
import 'package:modulo09/controllers/lista.dart';
import 'package:modulo09/styles/styles.dart';

class Lista extends StatefulWidget {
  const Lista({super.key});

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  bool loading = true;

  List<bool> visible = [];
  String pes = '';
  List reclamacoes = [];

  set(value) {
    reclamacoes = value;

    for (int i = 0; i < reclamacoes.length; i++) {
      visible.add(false);
    }

    loading = false;

    setState(() {});
  }

  @override
  void initState() {
    Future.wait([ListaController.getReclamacoes()]).then(
      (value) => set(value[0]),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: !loading
            ? SingleChildScrollView(
                child: FutureBuilder(
                  future: ListaController.getReclamacoes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List pesq = [];
                      for (var req in reclamacoes) {
                        if (req['titulo']
                                .substring(
                                  0,
                                  pes.length,
                                )
                                .toLowerCase() ==
                            pes.toLowerCase()) {
                          pesq.add(req);
                        }
                      }

                      if (pes != '') {
                        reclamacoes = pesq;
                      } else {
                        reclamacoes = snapshot.data as List;
                      }

                      return Column(
                        children: [
                          SingleChildScrollView(
                            child: SizedBox(
                              height: height * .9,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Textos.txt2(
                                      'Lista de Registros',
                                      TextAlign.center,
                                      Cores.verdeEscuro,
                                    ),
                                    Container(height: height * .03),
                                    TextFormField(
                                      onChanged: (value) {
                                        pes = value;
                                        setState(() {});
                                      },
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelText: 'Pesquisar',
                                        labelStyle:
                                            TextStyle(fontFamily: Fonts.font),
                                        suffixIcon: const Icon(Icons.search),
                                      ),
                                    ),
                                    Container(height: height * .03),
                                    for (int i = 0; i < reclamacoes.length; i++)
                                      GestureDetector(
                                        onLongPress: () => setState(() {
                                          visible[i] = true;
                                        }),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 7,
                                            bottom: 7,
                                          ),
                                          child: Container(
                                            width: width,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2,
                                                color: Cores.verdeClaro,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Textos.txt1(
                                                    reclamacoes[i]['titulo'],
                                                    TextAlign.start,
                                                    reclamacoes[i][
                                                                'tipoReclamacaoId'] ==
                                                            1
                                                        ? Colors.green
                                                        : reclamacoes[i][
                                                                    'tipoReclamacaoId'] ==
                                                                2
                                                            ? Colors.blue
                                                            : reclamacoes[i][
                                                                        'tipoReclamacaoId'] ==
                                                                    3
                                                                ? Colors.orange
                                                                : Colors.purple,
                                                  ),
                                                  Visibility(
                                                    visible: visible[i],
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          child:
                                                              Icon(Icons.edit),
                                                        ),
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          child: Icon(
                                                              Icons.delete),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * .1,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      Navigator.pushNamed(context, '/lista'),
                                  child: Container(
                                    width: width * .5,
                                    height: height * .1,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: Cores.azulEscuro,
                                      ),
                                      color: Cores.azulEscuro,
                                    ),
                                    child: Center(
                                      child: Textos.txt1(
                                        'Reclamações',
                                        TextAlign.center,
                                        Cores.azulClaro,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => (),
                                  child: Container(
                                    width: width * .5,
                                    height: height * .1,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: Cores.azulEscuro,
                                      ),
                                    ),
                                    child: Center(
                                      child: Textos.txt1(
                                        'Cadastro',
                                        TextAlign.center,
                                        Cores.azulClaro,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
