import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modulo07/controllers/validator.dart';
import 'package:modulo07/styles/styles.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});
  static const routeName = '/admin';

  @override
  State<Admin> createState() => _AdminState();
}

class ScreenArguments {
  final Map avaliacao;

  ScreenArguments(this.avaliacao);
}

class _AdminState extends State<Admin> {
  final _formKey = GlobalKey<FormState>();
  String user = '';
  String local = '';
  String cidade = '';
  String coment = '';
  String data = '';
  String status = 'Em Análise';
  int avaliacao = 0;
  File? img;

  TextEditingController userController = TextEditingController();
  TextEditingController localController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController comentController = TextEditingController();

  List<Widget> estrelas = [
    const Icon(Icons.star_outline, size: 40),
    const Icon(Icons.star_outline, size: 40),
    const Icon(Icons.star_outline, size: 40),
    const Icon(Icons.star_outline, size: 40),
    const Icon(Icons.star_outline, size: 40),
  ];

  avaliar(q) {
    estrelas.clear();
    avaliacao = q + 1;

    for (int i = 0; i < avaliacao; i++) {
      estrelas.add(const Icon(Icons.star, color: Colors.yellow, size: 40));
    }

    while (estrelas.length < 5) {
      estrelas.add(const Icon(Icons.star_outline, size: 40));
    }

    setState(() {});
  }

  aprovar() async {}

  reprovar() async {}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    userController.text = args.avaliacao['user'];
    comentController.text = args.avaliacao['coment'];
    localController.text = args.avaliacao['local'];
    cidadeController.text = args.avaliacao['cidade'];
    avaliacao = args.avaliacao['avaliacao'];

    estrelas.clear();

    for (int i = 0; i < avaliacao; i++) {
      estrelas.add(const Icon(Icons.star, color: Colors.yellow, size: 40));
    }

    while (estrelas.length < 5) {
      estrelas.add(const Icon(Icons.star_outline, size: 40));
    }

    img = File(args.avaliacao['img']);

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width * .32, 40),
                        backgroundColor: Cores.verdeEscuro,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () => (),
                      child: Textos.txt1(
                        'Admin',
                        Cores.verdeClaro,
                        TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width * .57, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/lista'),
                      child: Textos.txt1(
                        'Lista de Feedbacks',
                        Cores.verdeEscuro,
                        TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Container(height: height * .03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * .35,
                      height: width * .6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Cores.verdeEscuro),
                      ),
                      child: Center(
                        child: img != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(img!, fit: BoxFit.cover),
                              )
                            : Icon(
                                Icons.camera_alt_outlined,
                                size: 60,
                                color: Cores.verdeEscuro,
                              ),
                      ),
                    ),
                    Container(
                      width: width * .5,
                      height: width * .6,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextFormField(
                              enabled: false,
                              controller: userController,
                              validator: (value) => Validator.validar(user),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Usuário',
                                labelStyle: TextStyle(fontFamily: Fonts.font),
                                prefixIcon: const Icon(Icons.person_outline),
                              ),
                            ),
                            TextFormField(
                              enabled: false,
                              controller: localController,
                              validator: (value) => Validator.validar(local),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Local',
                                labelStyle: TextStyle(fontFamily: Fonts.font),
                                prefixIcon: const Icon(Icons.pin_drop_outlined),
                              ),
                            ),
                            TextFormField(
                              enabled: false,
                              controller: cidadeController,
                              validator: (value) => Validator.validar(cidade),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Cidade',
                                labelStyle: TextStyle(fontFamily: Fonts.font),
                                prefixIcon: const Icon(Icons.map),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(height: height * .03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < estrelas.length; i++) estrelas[i]
                  ],
                ),
                Container(height: height * .03),
                TextFormField(
                  enabled: false,
                  controller: comentController,
                  validator: (value) => Validator.validar(coment),
                  keyboardType: TextInputType.name,
                  maxLines: 7,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Comentário',
                    hintStyle: TextStyle(fontFamily: Fonts.font),
                  ),
                ),
                Container(height: height * .05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width * .4, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => reprovar(),
                      child: Textos.txt1(
                        'Reprovar',
                        Cores.verdeEscuro,
                        TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width * .4, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => aprovar(),
                      child: Textos.txt1(
                        'Aprovar',
                        Cores.verdeEscuro,
                        TextAlign.center,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
