// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:modulo09/controllers/api.dart';
import 'package:modulo09/styles/styles.dart';

class Lista extends StatefulWidget {
  const Lista({super.key});

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> with SingleTickerProviderStateMixin {
  late TabController _controller;
  List reclamacoes = [];
  List data = [];
  String pes = '';
  List<bool> visible = [];

  bool loading = true;

  editar(id) {}
  deletar(id) async {
    await ApiController.deleteReclamacoes(id);
    await Future.delayed(Duration(seconds: 1));
    data = await ApiController.getReclamacoes();
    reclamacoes = data;
    setState(() {});
  }

  setar(value) {
    reclamacoes = value[0];
    data = value[0];

    for (var r in reclamacoes) {
      visible.add(false);
    }

    loading = false;

    setState(() {});
  }

  @override
  void initState() {
    Future.wait([ApiController.getReclamacoes()]).then((value) => setar(value));
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: TabBar(
        controller: _controller,
        tabs: [
          TextButton(
            onPressed: () => (),
            child: Textos.txt1('Reclamações', TextAlign.center, Cores.verde3),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/cadastro'),
            child: Textos.txt1('Registros', TextAlign.center, Cores.verde3),
          ),
        ],
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder(
              future: ApiController.getReclamacoes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  data = snapshot.data as List;

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Textos.txt2(
                            'Lista de registros',
                            TextAlign.center,
                            Cores.verde3,
                          ),
                          Container(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              pes = value;
                              if (pes != '') {
                                reclamacoes.clear();
                                for (int i = 0; i < data.length; i++) {
                                  if (data[i]['titulo']
                                          .substring(0, pes.length)
                                          .toLowerCase() ==
                                      pes.toLowerCase()) {
                                    reclamacoes.add(data[i]);
                                  }
                                }
                              } else {
                                reclamacoes = data;
                              }
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              labelText: 'Pesquisar',
                              labelStyle: TextStyle(
                                fontFamily: Fonts.font,
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: const Icon(Icons.search),
                            ),
                          ),
                          Container(height: 20),
                          for (int i = 0; i < reclamacoes.length; i++)
                            GestureDetector(
                              onLongPress: () => setState(() {
                                visible[i] = true;
                              }),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Container(
                                  width: width,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Cores.branco,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 2,
                                      color: Cores.verde3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 1,
                                        offset: const Offset(1, 1),
                                        color: Cores.verde2,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Container(
                                          width: width * .55,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Textos.txt1(
                                                reclamacoes[i]['titulo'],
                                                TextAlign.left,
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
                                              Textos.txt1(
                                                reclamacoes[i]['descricao'],
                                                TextAlign.left,
                                                Cores.azul2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: visible[i],
                                        child: Container(
                                          width: width * .3,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 2,
                                                height: 70,
                                                color: Cores.verde3,
                                              ),
                                              IconButton(
                                                onPressed: () => editar(
                                                    reclamacoes[i]['id']),
                                                icon: const Icon(Icons.edit),
                                              ),
                                              IconButton(
                                                onPressed: () => deletar(
                                                    reclamacoes[i]['id']),
                                                icon: const Icon(Icons.delete),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
