import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modulo07/controllers/firebase.dart';
import 'package:modulo07/styles/styles.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});
  static const routeName = '/admin';

  @override
  State<Admin> createState() => _AdminState();
}

class ScreenArguments {
  final int i;
  final int id;

  ScreenArguments(this.i, this.id);
}

class _AdminState extends State<Admin> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _localController = TextEditingController();
  TextEditingController _cidadeController = TextEditingController();
  TextEditingController _comentarioController = TextEditingController();

  int estrelas = 0;

  List listaEstrelas = [
    const Icon(Icons.star_border),
    const Icon(Icons.star_border),
    const Icon(Icons.star_border),
    const Icon(Icons.star_border),
    const Icon(Icons.star_border),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: FirebaseController.formatarData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List data = snapshot.data as List;
                  int index = args.i;

                  _nomeController.text = data[index]['nome'];
                  _localController.text = data[index]['local'];
                  _cidadeController.text = data[index]['cidade'];
                  _comentarioController.text = data[index]['comentario'];

                  listaEstrelas.clear();

                  estrelas = data[index]['estrelas'];

                  for (int e = 0; e < estrelas; e++) {
                    listaEstrelas.add(
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    );
                  }

                  for (int e = listaEstrelas.length; e < 5; e++) {
                    listaEstrelas.add(
                      const Icon(Icons.star_border),
                    );
                  }

                  return Column(
                    children: [
                      Container(height: height * .03),
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(data[index]['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(height: height * .03),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            //Nome
                            TextFormField(
                              controller: _nomeController,
                              enabled: false,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                label: Textos.padrao('Nome', Cores.azulEscuro),
                                prefixIcon: const Icon(Icons.person),
                              ),
                            ),
                            Container(height: height * .02),
                            //Luagr
                            TextFormField(
                              controller: _localController,
                              enabled: false,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                label: Textos.padrao('Local', Cores.azulEscuro),
                                prefixIcon: const Icon(Icons.pin_drop_outlined),
                              ),
                            ),
                            Container(height: height * .02),

                            //Cidade
                            TextFormField(
                              controller: _cidadeController,
                              enabled: false,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                label:
                                    Textos.padrao('Cidade', Cores.azulEscuro),
                                prefixIcon: const Icon(Icons.map_outlined),
                              ),
                            ),
                            Container(height: height * .02),
                            TextFormField(
                              controller: _comentarioController,
                              enabled: false,
                              keyboardType: TextInputType.text,
                              maxLines: 7,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Container(height: height * .02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    for (int i = 0; i < 5; i++)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {});
                                        },
                                        child: listaEstrelas[i],
                                      ),
                                  ],
                                ),
                                Container(
                                  width: width * .4,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      5,
                                      0,
                                      5,
                                      0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Textos.padrao(
                                          data[index]['data'],
                                          Cores.azulEscuro,
                                        ),
                                        const Icon(
                                          Icons.calendar_month_outlined,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(height: height * .02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(width * .43, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () =>
                                      FirebaseController.atualizarAvaliacao(
                                    data[index]["id"],
                                    'Rejeitado',
                                    context,
                                  ),
                                  child: Textos.padrao(
                                    'Rejeitar',
                                    Cores.azulEscuro,
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(width * .43, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () =>
                                      FirebaseController.atualizarAvaliacao(
                                    data[index]["id"],
                                    'Aprovado',
                                    context,
                                  ),
                                  child: Textos.padrao(
                                    'Aprovar',
                                    Cores.azulEscuro,
                                  ),
                                ),
                              ],
                            ),
                            Container(height: height * .02),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(width * .43, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (index < 1) {
                                      null;
                                    } else {
                                      index = index - 1;
                                      setState(() {});
                                    }
                                  },
                                  child: Textos.padrao(
                                    'Anterior',
                                    Cores.azulEscuro,
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(width * .43, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (index == data.length - 1) {
                                      null;
                                    } else {
                                      index = index + 1;
                                      setState(() {});
                                    }
                                  },
                                  child: Textos.padrao(
                                    'Proxima',
                                    Cores.azulEscuro,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(color: Cores.azulEscuro),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
