import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modulo07/controllers/validator.dart';
import 'package:modulo07/styles/styles.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final _formKey = GlobalKey<FormState>();
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Textos.titulo(
                    'Admin',
                    Cores.azulEscuro,
                  ),
                  Container(height: height * .05),
                  ClipRRect(
                    borderRadius: BorderRadiusDirectional.circular(8),
                    child: Image.file(args.image),
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
