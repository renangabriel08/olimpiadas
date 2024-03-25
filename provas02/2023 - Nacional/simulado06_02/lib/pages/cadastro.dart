import 'package:flutter/material.dart';
import 'package:simulado06_02/controllers/cadastro.dart';
import 'package:simulado06_02/controllers/validators.dart';
import 'package:simulado06_02/styles/styles.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  String nome = '';
  String email = '';
  String apelido = '';
  String senha = '';
  String csenha = '';
  bool obscureText1 = true;
  bool obscureText2 = true;

  final _formKey = GlobalKey<FormState>();

  cadastrar() async {
    if (_formKey.currentState!.validate()) {
      CadastroController.cadastrar(nome, email, senha);
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png', height: 300),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    validator: (value) => Validators.nomeApelido(nome),
                    onChanged: (value) => nome = value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.person_outline),
                      labelText: 'Nome',
                      hintText: 'Nome Sobrenome',
                      labelStyle: TextStyle(fontFamily: Fonts.font),
                      hintStyle: TextStyle(fontFamily: Fonts.font),
                    ),
                  ),
                  Container(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => Validators.email(email),
                    onChanged: (value) => email = value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.email_outlined),
                      labelText: 'Email',
                      hintText: 'email@email.com',
                      labelStyle: TextStyle(fontFamily: Fonts.font),
                      hintStyle: TextStyle(fontFamily: Fonts.font),
                    ),
                  ),
                  Container(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    validator: (value) => Validators.nomeApelido(apelido),
                    onChanged: (value) => apelido = value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.person_outline),
                      labelText: 'Apelido',
                      hintText: 'Apelido',
                      labelStyle: TextStyle(fontFamily: Fonts.font),
                      hintStyle: TextStyle(fontFamily: Fonts.font),
                    ),
                  ),
                  Container(height: 15),
                  TextFormField(
                    obscureText: obscureText1,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => Validators.senha(senha),
                    onChanged: (value) => senha = value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          obscureText1 = !obscureText1;
                        }),
                        icon: Icon(
                          obscureText1
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      labelText: 'Senha',
                      hintText: '********',
                      labelStyle: TextStyle(fontFamily: Fonts.font),
                      hintStyle: TextStyle(fontFamily: Fonts.font),
                    ),
                  ),
                  Container(height: 15),
                  TextFormField(
                    obscureText: obscureText2,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => Validators.csenha(csenha, senha),
                    onChanged: (value) => csenha = value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          obscureText2 = !obscureText2;
                        }),
                        icon: Icon(
                          obscureText2
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      labelText: 'Confirmar senha',
                      hintText: '********',
                      labelStyle: TextStyle(fontFamily: Fonts.font),
                      hintStyle: TextStyle(fontFamily: Fonts.font),
                    ),
                  ),
                  Container(height: 50),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: Size(width, 50),
                    ),
                    onPressed: () => cadastrar(),
                    child: Textos(
                      txt: 'CADASTRAR',
                      textAlign: TextAlign.center,
                      cor: Cores.ciano,
                      size: 16,
                      weight: FontWeight.normal,
                    ),
                  ),
                  Container(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fixedSize: Size(width, 50),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    child: Textos(
                      txt: 'VOLTAR',
                      textAlign: TextAlign.center,
                      cor: Cores.ciano,
                      size: 16,
                      weight: FontWeight.normal,
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
