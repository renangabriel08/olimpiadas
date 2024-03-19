import 'package:flutter/material.dart';
import 'package:modulo03/controllers/login.dart';
import 'package:modulo03/controllers/validator.dart';
import 'package:modulo03/styles/styles.dart';
import 'package:modulo03/widgets/toast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String senha = '';

  bool obscureText = true;

  logar() async {
    if (_formKey.currentState!.validate()) {
      await LoginController.logar(email, senha);
      if (LoginController.erros % 3 == 0) {
        LoginController.enabled = false;
        setState(() {});
        MyToast.gerar('Login bloqueado: aguarde 30s!');
        Future.delayed(const Duration(seconds: 30));
        LoginController.enabled = true;
        setState(() {});
      }
    } else {
      MyToast.gerar('Usuário/Senha inválidos!');
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Textos.titulo('Login', TextAlign.center, Cores.verdeEscuro),
                    Container(height: height * .1),
                    TextFormField(
                      validator: (value) => Validator.validarLogin(email),
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
                      obscureText: obscureText,
                      validator: (value) => Validator.validarLogin(senha),
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
                            obscureText = !obscureText;
                          }),
                          icon: Icon(obscureText
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
                      onPressed: () => LoginController.enabled ? logar() : null,
                      child: Textos.padrao(
                        'Acessar',
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
                      onPressed: () => LoginController.enabled
                          ? Navigator.pushNamed(context, '/cadastro')
                          : null,
                      child: Textos.padrao(
                        'Cadastre-se',
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
