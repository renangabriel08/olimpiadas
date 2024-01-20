import 'package:flutter/material.dart';
import 'package:simulado06_02/controllers/api.dart';
import 'package:simulado06_02/controllers/validator.dart';
import 'package:simulado06_02/styles/styles.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;

  String nome = '';
  String email = '';
  String apelido = '';
  String senha = '';
  String cSenha = '';

  void cadastrar() {
    if (_formKey.currentState!.validate()) {
      ApiController.cadastrar(nome, email, apelido, senha, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: SizedBox(
              width: width,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', width: width * .5),
                  Container(height: height * .02),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (value) => nome = value,
                          validator: (value) =>
                              ValidatorController.validarApelido(
                            nome,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Textos.padrao('Nome'),
                          ),
                        ),
                        Container(height: height * .02),
                        TextFormField(
                          onChanged: (value) => email = value,
                          validator: (value) =>
                              ValidatorController.validarEmail(
                            email,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'email@email.com',
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Textos.padrao('Email'),
                          ),
                        ),
                        Container(height: height * .02),
                        TextFormField(
                          onChanged: (value) => apelido = value,
                          validator: (value) =>
                              ValidatorController.validarApelido(
                            apelido,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Textos.padrao('Apelido'),
                          ),
                        ),
                        Container(height: height * .02),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
                          onChanged: (value) => senha = value,
                          validator: (value) =>
                              ValidatorController.validarSenha(
                            senha,
                          ),
                          decoration: InputDecoration(
                            hintText: '********',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                obscureText = !obscureText;
                              }),
                              icon: obscureText
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Textos.padrao('Senha'),
                          ),
                        ),
                        Container(height: height * .02),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
                          onChanged: (value) => cSenha = value,
                          validator: (value) =>
                              ValidatorController.validarCsenha(
                            senha,
                            cSenha,
                          ),
                          decoration: InputDecoration(
                            hintText: '********',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                obscureText = !obscureText;
                              }),
                              icon: obscureText
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Textos.padrao('Confirmar Senha'),
                          ),
                        ),
                        Container(height: height * .05),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => cadastrar(),
                          child: Textos.padrao('Cadastrar'),
                        ),
                        Container(height: height * .02),
                        OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => Navigator.pushNamed(
                            context,
                            '/login',
                          ),
                          child: Textos.padrao('logar'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
