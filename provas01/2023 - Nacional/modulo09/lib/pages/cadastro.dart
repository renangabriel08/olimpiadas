import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:modulo09/controllers/api.dart';
import 'package:modulo09/controllers/validator.dart';
import 'package:modulo09/styles/styles.dart';
import 'package:modulo09/widgets/toast.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  TextEditingController tController = TextEditingController();
  TextEditingController dController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List reclamacoes = [];
  String titulo = '';
  String desc = '';
  String tipo = 'Cobrança';
  List<String> tipos = ['Cobrança', 'Serviços', 'Performance', 'Usabilidade'];

  cadastrar() {
    if (_formKey.currentState!.validate()) {
      ApiController.cadastrarReclamacao(titulo, desc, tipos.indexOf(tipo) + 1);
    } else {
      MyToast.gerar('Todos os campos são obrigatórios!');
    }
  }

  cancelar() {
    dController.text = '';
    tController.text = '';
  }

  Future<void> modal() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Textos.txt2('Atenção!', TextAlign.start, Cores.azul2),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Textos.txt1(
                  'Sua conexão com a internet está indisponível! Aguarde!',
                  TextAlign.start,
                  Cores.azul1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool modalAberto = false;
  Timer? timer;

  start() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      final connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.none) {
        if (!modalAberto) {
          modalAberto = true;
          modal();
        }
      } else {
        if (modalAberto) {
          modalAberto = false;
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  void initState() {
    start();
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
        child: SingleChildScrollView(
          child: Container(
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Textos.txt2(
                  'Registro de reclamação',
                  TextAlign.center,
                  Cores.verde3,
                ),
                Container(height: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: tController,
                        keyboardType: TextInputType.name,
                        onChanged: (value) => titulo = value,
                        validator: (value) => Validator.validar(titulo),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Título',
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: Fonts.font,
                          ),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        controller: dController,
                        keyboardType: TextInputType.name,
                        onChanged: (value) => desc = value,
                        validator: (value) => Validator.validar(desc),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Descrição',
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: Fonts.font,
                          ),
                        ),
                      ),
                      Container(height: 10),
                      DropdownButtonFormField(
                        value: tipo,
                        validator: (value) => Validator.validar(tipo),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Tipo',
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: Fonts.font,
                          ),
                        ),
                        items: [
                          for (var i in tipos)
                            DropdownMenuItem(
                              child:
                                  Textos.txt1(i, TextAlign.left, Colors.grey),
                              value: i,
                            )
                        ],
                        onChanged: (value) => tipo = value.toString(),
                      ),
                      Container(height: 50),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => cadastrar(),
                        child: Textos.txt1(
                          'Cadastrar',
                          TextAlign.center,
                          Cores.verde3,
                        ),
                      ),
                      Container(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => cancelar(),
                        child: Textos.txt1(
                          'Cancelar',
                          TextAlign.center,
                          Cores.verde3,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
