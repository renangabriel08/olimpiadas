import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modulo07/controllers/firebase.dart';
import 'package:modulo07/controllers/validator.dart';
import 'package:modulo07/styles/styles.dart';
import 'package:modulo07/widgets/toast.dart';

class Criar extends StatefulWidget {
  const Criar({super.key});

  @override
  State<Criar> createState() => _CriarState();
}

class _CriarState extends State<Criar> {
  final _formKey = GlobalKey<FormState>();

  File? image;
  String nome = '';
  String local = '';
  String cidade = '';
  String comentario = '';
  int estrelas = 0;

  List listaEstrelas = [
    Icon(Icons.star_border),
    Icon(Icons.star_border),
    Icon(Icons.star_border),
    Icon(Icons.star_border),
    Icon(Icons.star_border),
  ];

  tirarFoto() async {
    final ImagePicker picker = ImagePicker();

    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      image = File(photo.path);
    }
    setState(() {});
  }

  enviar() {
    if (_formKey.currentState!.validate()) {
      if (image != null) {
        FirebaseController.criarAvaliacao(
          nome,
          local,
          cidade,
          image!,
          comentario,
          estrelas,
          context,
        );
      } else {
        MyToast.gerarToast('Preencha todos os campos');
      }
    } else {
      MyToast.gerarToast('Preencha todos os campos');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(height: height * .03),
                GestureDetector(
                  onTap: () => tirarFoto(),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: image == null
                        ? const Center(
                            child: Icon(Icons.camera_alt_outlined),
                          )
                        : ClipRRect(
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
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
                        onChanged: (value) => nome = value,
                        validator: (value) => Validator.validar(nome),
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
                        onChanged: (value) => local = value,
                        validator: (value) => Validator.validar(local),
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
                        onChanged: (value) => cidade = value,
                        validator: (value) => Validator.validar(cidade),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: Textos.padrao('Cidade', Cores.azulEscuro),
                          prefixIcon: const Icon(Icons.map_outlined),
                        ),
                      ),
                      Container(height: height * .02),
                      TextFormField(
                        onChanged: (value) => comentario = value,
                        validator: (value) => Validator.validar(comentario),
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
                        children: [
                          for (int i = 0; i < 5; i++)
                            GestureDetector(
                              onTap: () {
                                listaEstrelas.clear();
                                estrelas = i + 1;

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

                                setState(() {});
                              },
                              child: listaEstrelas[i],
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
                            onPressed: () => Navigator.pushNamed(
                              context,
                              '/feedbacks',
                            ),
                            child: Textos.padrao('Voltar', Cores.azulEscuro),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width * .43, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => enviar(),
                            child: Textos.padrao('Enviar', Cores.azulEscuro),
                          ),
                        ],
                      )
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
