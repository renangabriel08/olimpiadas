import 'package:flutter/material.dart';
import 'package:modulo02/controllers/lista.dart';
import 'package:modulo02/styles/styles.dart';

class ListaDeDesafios extends StatefulWidget {
  const ListaDeDesafios({super.key});

  @override
  State<ListaDeDesafios> createState() => _ListaDeDesafiosState();
}

class _ListaDeDesafiosState extends State<ListaDeDesafios> {
  List opcs = ['Novas', 'Populares', 'Nenhum'];
  String opc = 'Nenhum';
  List desafios = [];
  String pesquisa = '';

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
          'Lista de Desafios',
          style: TextStyle(
            color: Cores.cinza1,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: Fontes.fonte,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          color: Cores.cinza1,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) => setState(() {
                    pesquisa = value;
                  }),
                  decoration: const InputDecoration(
                    label: Text('Pesquisar por termo'),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                SizedBox(
                  width: width,
                  child: DropdownButton(
                    value: opc,
                    items: [
                      for (String op in opcs)
                        DropdownMenuItem(
                          value: op,
                          child: Text(
                            op,
                            style: TextStyle(color: Cores.cinza2),
                          ),
                        ),
                    ],
                    onChanged: (value) => setState(() {
                      opc = value!;
                    }),
                  ),
                ),
                FutureBuilder(
                  future: ListaController.getLista(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List data = snapshot.data as List;

                      if (opc == 'Novas') {
                        data.sort((a, b) => a['data'].compareTo(b['data']));
                      }
                      if (opc == 'Populares') {
                        data.sort((a, b) =>
                            b['popularidade'].compareTo(a['popularidade']));
                      }
                      if (opc == 'Nenhum') {
                        data.sort((a, b) => a['nome'].compareTo(b['nome']));
                      }

                      if (pesquisa != '') {
                        desafios.clear();
                        for (var e in data) {
                          if (e['nome']
                                  .toString()
                                  .toLowerCase()
                                  .substring(0, pesquisa.length) ==
                              pesquisa) {
                            desafios.add(e);
                          }
                        }
                      } else {
                        desafios = data;
                      }

                      return Column(
                        children: [
                          for (var desafio in desafios)
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
                                        desafio['nome'],
                                        style: TextStyle(
                                          color: Cores.vermelho,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_circle_right_rounded,
                                        color: Cores.vermelho,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
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
