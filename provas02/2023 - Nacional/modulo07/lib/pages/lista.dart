import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modulo07/controllers/lista.dart';
import 'package:modulo07/pages/admin.dart';
import 'package:modulo07/styles/styles.dart';

class Lista extends StatefulWidget {
  const Lista({super.key});

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  bool loading = true;
  List avaliacoes = [];

  setar(value) {
    avaliacoes = value;
    loading = false;
    setState(() {});
  }

  deletar(id) async {
    await ListaController.deletar(id);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder(
              future: ListaController.get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List avaliacoes = snapshot.data as List;
                  if (avaliacoes.isEmpty) {
                    return Center(
                      child: Textos.txt1(
                        'Cadastre a primeira avalição para pode administrar',
                        Cores.azulEscuro,
                        TextAlign.center,
                      ),
                    );
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width * .32, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            onPressed: () => (),
                            child: Textos.txt1(
                              'Admin',
                              Cores.verdeEscuro,
                              TextAlign.center,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width * .57, 40),
                              backgroundColor: Cores.verdeEscuro,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            onPressed: () => (),
                            child: Textos.txt1(
                              'Lista de Feedbacks',
                              Cores.verdeClaro,
                              TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Container(height: height * .03),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          '/cadastro',
                        ),
                        child: Textos.txt1(
                          'Crie uma avaliação de Teste',
                          Cores.verdeEscuro,
                          TextAlign.center,
                        ),
                      ),
                      Container(height: height * .03),
                      Textos.txt2(
                        'Lista de Avaliação',
                        Cores.azulEscuro,
                        TextAlign.center,
                      ),
                      Container(height: height * .03),
                      for (var av in avaliacoes)
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            Admin.routeName,
                            arguments: ScreenArguments(av),
                          ),
                          child: Slidable(
                            key: ValueKey(av['id']),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              dismissible: DismissiblePane(
                                onDismissed: () => deletar(av['id']),
                              ),
                              children: [
                                SlidableAction(
                                  onPressed: (context) => deletar(av['id']),
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Deletar',
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6, bottom: 6),
                              child: Container(
                                width: width,
                                height: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: Cores.azulEscuro),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Textos.txt1(
                                    'Avaliação ${av['id']}',
                                    Cores.azulEscuro,
                                    TextAlign.start,
                                  ),
                                  subtitle: Textos.txt1(
                                    '${av['status']}',
                                    Cores.azulClaro,
                                    TextAlign.start,
                                  ),
                                ),
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
            ),
          ),
        ),
      ),
    );
  }
}
