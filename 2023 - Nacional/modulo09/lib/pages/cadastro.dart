import 'package:flutter/material.dart';
import 'package:modulo09/controllers/api.dart';
import 'package:modulo09/styles/styles.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  List reclamacoes = [];
  String pes = '';

  editar(id) {}
  deletar(id) {}

  setar(value) {
    reclamacoes = value[0];
  }

  @override
  void initState() {
    Future.wait([ApiController.getReclamacoes()]).then((value) => setar(value));
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: TabBar(
        controller: _controller,
        tabs: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/lista'),
            child: Textos.txt1('Reclamações', TextAlign.center, Cores.verde3),
          ),
          TextButton(
            onPressed: () => (),
            child: Textos.txt1('Registros', TextAlign.center, Cores.verde3),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Textos.txt2(
              'Registro de reclamação',
              TextAlign.center,
              Cores.verde3,
            ),
            Container(height: 20),
            TextFormField(
              keyboardType: TextInputType.name,
              onChanged: (value) => pes = value,
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
            for (var rec in reclamacoes)
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Container(
                  width: width,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Cores.branco,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Cores.verde3),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        offset: const Offset(1, 1),
                        color: Cores.verde2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: width * .55,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Textos.txt1(
                                rec['titulo'],
                                TextAlign.left,
                                Cores.azul2,
                              ),
                              Textos.txt1(
                                rec['descricao'],
                                TextAlign.left,
                                Cores.azul2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: width * .3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => editar(rec['id']),
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () => deletar(rec['id']),
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
