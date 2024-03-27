import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modulo07/controllers/cadastro.dart';
import 'package:modulo07/controllers/validator.dart';
import 'package:modulo07/styles/styles.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  String user = '';
  String local = '';
  String cidade = '';
  String coment = '';
  String data = '';
  String status = 'Em Análise';
  int avaliacao = 0;
  File? img;

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

  tirarFoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        img = File(photo.path);
      }

      setState(() {});
    } catch (e) {}
  }

  enviar() async {
    if (img != null &&
        user != '' &&
        local != '' &&
        cidade != '' &&
        coment != '') {
      data =
          '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';

      CadastroController.cadastrar(
        user,
        local,
        cidade,
        coment,
        avaliacao,
        data,
        status,
        img!.path,
      );
    }
  }

  voltar() async {}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Textos.txt2(
                  'Faça sua Avaliação do Local',
                  Cores.verdeEscuro,
                  TextAlign.center,
                ),
                Container(height: height * .03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => tirarFoto(),
                      child: Container(
                        width: width * .35,
                        height: width * .6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(width: 2, color: Cores.verdeEscuro),
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
                              onChanged: (value) => user = value,
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
                              onChanged: (value) => local = value,
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
                              onChanged: (value) => cidade = value,
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
                    for (int i = 0; i < estrelas.length; i++)
                      GestureDetector(
                        onTap: () => avaliar(i),
                        child: estrelas[i],
                      )
                  ],
                ),
                Container(height: height * .03),
                TextFormField(
                  onChanged: (value) => coment = value,
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
                      onPressed: () => voltar(),
                      child: Textos.txt1(
                        'Voltar',
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
                      onPressed: () => enviar(),
                      child: Textos.txt1(
                        'Enviar',
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
