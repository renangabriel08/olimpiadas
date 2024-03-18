import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modulo01/controllers/cadastro.dart';
import 'package:modulo01/controllers/validator.dart';
import 'package:modulo01/styles/styles.dart';
import 'package:modulo01/widgets/toast.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String user = '';
  String senha = '';
  String cSenha = '';
  String nome = '';
  String celular = '';
  File? imagem;

  bool obscureText = true;

  tirarFoto() async {
    final ImagePicker picker = ImagePicker();

    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      imagem = File(photo.path);
    }
  }

  cadastrar() {
    if (_formKey.currentState!.validate()) {
      if (imagem != null) {
        CadastroController.cadastrar(email, user, senha, celular, imagem!);
      } else {
        MyToast.gerarToast('Adicione imagem');
      }
    } else {
      MyToast.gerarToast('Preencha os campos corretamente');
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
        color: Cores.cinza1,
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => tirarFoto(),
                          child: Text(
                            'CADASTRO',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Cores.ciano,
                            ),
                          ),
                        ),
                        Text(
                          'Todos os campos são obrigatórios!',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Cores.cinza2,
                          ),
                        ),
                      ],
                    ),
                    Container(height: height * .03),
                    TextFormField(
                      validator: (value) => Validar.validarEmail(email),
                      onChanged: (value) => email = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        label: Text(
                          'Email',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) => Validar.validarLogin(senha),
                      onChanged: (value) => senha = value,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: obscureText,
                      decoration: const InputDecoration(
                        label: Text(
                          'Senha',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) =>
                          Validar.validarCsenha(senha, cSenha),
                      onChanged: (value) => cSenha = value,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: obscureText,
                      decoration: const InputDecoration(
                        label: Text(
                          'Confirme a Senha',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) => Validar.validarTelefone(celular),
                      onChanged: (value) => celular = value,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        label: Text(
                          'Telefone',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) => Validar.validarLogin(user),
                      onChanged: (value) => user = value,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        label: Text(
                          'Apelido',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(height: height * .05),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, 42),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Cores.ciano,
                      ),
                      onPressed: () => cadastrar(),
                      child: Text(
                        'Cadastrar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Cores.cinza1,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Já possui conta?',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/login'),
                          child: const Text('Entre'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
