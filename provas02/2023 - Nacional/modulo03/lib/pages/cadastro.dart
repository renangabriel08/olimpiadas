import 'package:flutter/material.dart';
import 'package:modulo03/controllers/cadastro.dart';
import 'package:modulo03/controllers/login.dart';
import 'package:modulo03/controllers/validator.dart';
import 'package:modulo03/styles/styles.dart';
import 'package:modulo03/widgets/toast.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();

  String nome = '';
  String email = '';
  String senha = '';
  String csenha = '';

  bool obscureText1 = true;
  bool obscureText2 = true;

  cadastrar() async {
    if (_formKey.currentState!.validate()) {
      await CadastroController.cadastrar(nome, email, senha);
    } else {
      MyToast.gerar('Campos inválidos!');
    }
  }

  Future<void> modal() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Textos.subtitulo(
            'Cancelar',
            TextAlign.start,
            Cores.azulEscuro,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Textos.padrao(
                  'Deseja realmente cancelar seu cadastro?',
                  TextAlign.start,
                  Cores.azulEscuro,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Textos.padrao('Sim', TextAlign.center, Cores.azulClaro),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            TextButton(
              child: Textos.padrao('Não', TextAlign.center, Cores.azulEscuro),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Textos.titulo('Login', TextAlign.center, Cores.verdeEscuro),
                    Container(height: height * .1),
                    TextFormField(
                      validator: (value) => Validator.validarNome(nome),
                      onChanged: (value) => nome = value,
                      keyboardType: TextInputType.emailAddress,
                      enabled: LoginController.enabled,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Nome',
                        labelStyle: TextStyle(fontFamily: Fonts.font),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    Container(height: height * .01),
                    TextFormField(
                      validator: (value) => Validator.validarEmail(email),
                      onChanged: (value) => email = value,
                      keyboardType: TextInputType.emailAddress,
                      enabled: LoginController.enabled,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(fontFamily: Fonts.font),
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                    ),
                    Container(height: height * .01),
                    TextFormField(
                      enabled: LoginController.enabled,
                      obscureText: obscureText1,
                      validator: (value) => Validator.validarSenha(senha),
                      onChanged: (value) => senha = value,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Senha',
                        labelStyle: TextStyle(fontFamily: Fonts.font),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            obscureText1 = !obscureText1;
                          }),
                          icon: Icon(obscureText1
                              ? Icons.visibility
                              : Icons.visibility_off_outlined),
                        ),
                      ),
                    ),
                    Container(height: height * .01),
                    TextFormField(
                      enabled: LoginController.enabled,
                      obscureText: obscureText2,
                      validator: (value) =>
                          Validator.validarCsenha(csenha, senha),
                      onChanged: (value) => csenha = value,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Confirmar Senha',
                        labelStyle: TextStyle(fontFamily: Fonts.font),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            obscureText2 = !obscureText2;
                          }),
                          icon: Icon(obscureText2
                              ? Icons.visibility
                              : Icons.visibility_off_outlined),
                        ),
                      ),
                    ),
                    Container(height: height * .1),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => cadastrar(),
                      child: Textos.padrao(
                        'Cadastrar',
                        TextAlign.center,
                        Cores.verdeEscuro,
                      ),
                    ),
                    Container(height: height * .01),
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => modal(),
                      child: Textos.padrao(
                        'Cancelar',
                        TextAlign.center,
                        Cores.verdeEscuro,
                      ),
                    ),
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
