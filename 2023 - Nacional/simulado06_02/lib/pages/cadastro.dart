import 'package:flutter/material.dart';
import 'package:simulado06_02/controllers/api.dart';
import 'package:simulado06_02/styles/styles.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();

  String nome = '';
  String email = '';
  String apelido = '';
  String senha = '';
  String cSenha = '';

  void cadastrar() {
    if (_formKey.currentState!.validate()) {
      ApiController.cadastrar(nome, email, apelido, senha);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  label: Textos.padrao('Email'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
