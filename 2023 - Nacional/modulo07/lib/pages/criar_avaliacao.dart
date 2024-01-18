import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modulo07/controllers/firebase.dart';
import 'package:modulo07/controllers/validator.dart';
import 'package:modulo07/styles/styles.dart';
import 'package:modulo07/widgets/toast.dart';

class CriarAvaliacao extends StatefulWidget {
  const CriarAvaliacao({super.key});

  @override
  State<CriarAvaliacao> createState() => _CriarAvaliacaoState();
}

class _CriarAvaliacaoState extends State<CriarAvaliacao> {
  final _formKey = GlobalKey<FormState>();

  File? image;
  String nomeUser = '';
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
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        image = File(photo.path);
      }

      setState(() {});
    } catch (e) {
      MyToast.gerarToast('Erro ao tirar foto');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    enviar() {
      if (_formKey.currentState!.validate()) {
        if (image != null) {
          FirebaseController.adicionarAvaliacao(
            nomeUser,
            local,
            cidade,
            comentario,
            estrelas,
            image!,
          );
        }
      } else {
        MyToast.gerarToast('Preencha todos os campos');
      }
    }

    voltar() {
      Navigator.pushNamed(context, '/listaAvaliacoes');
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Textos.titulo(
                    'Faça sua Avaliação do Local',
                    Cores.azulEscuro,
                  ),
                  Container(height: height * .05),
                  GestureDetector(
                    onTap: () => tirarFoto(),
                    child: Container(
                      width: width * .5,
                      height: width * .50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Cores.verdeEscuro),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: image == null
                          ? const Center(
                              child: Icon(Icons.camera_alt_outlined),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadiusDirectional.circular(8),
                              child: Image.file(image!, fit: BoxFit.cover),
                            ),
                    ),
                  ),
                  Container(height: height * .05),
                  //
                  TextFormField(
                    onChanged: (value) => local = value,
                    validator: (value) => ValidarForm.validar(local),
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
                  //
                  TextFormField(
                    onChanged: (value) => cidade = value,
                    validator: (value) => ValidarForm.validar(cidade),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Textos.padrao('Cidade', Cores.azulEscuro),
                      prefixIcon: const Icon(Icons.map),
                    ),
                  ),
                  Container(height: height * .02),
                  //
                  TextFormField(
                    onChanged: (value) => nomeUser = value,
                    validator: (value) => ValidarForm.validar(nomeUser),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Textos.padrao('Usuário', Cores.azulEscuro),
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  Container(height: height * .02),
                  //
                  TextFormField(
                    onChanged: (value) => comentario = value,
                    validator: (value) => ValidarForm.validar(comentario),
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
                      for (int i = 0; i < listaEstrelas.length; i++)
                        GestureDetector(
                          onTap: () => setState(() {
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

                            if (estrelas < 5) {
                              for (int a = estrelas; a < 5; a++) {
                                listaEstrelas.add(
                                  const Icon(Icons.star_border),
                                );
                              }
                            }
                          }),
                          child: listaEstrelas[i],
                        )
                    ],
                  ),
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () => voltar(),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(width * .4, 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Textos.padrao('Voltar', Cores.azulEscuro),
                      ),
                      ElevatedButton(
                        onPressed: () => enviar(),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(width * .4, 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: Textos.padrao('Enviar', Cores.azulEscuro),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
