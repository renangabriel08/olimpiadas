import 'package:flutter/material.dart';
import 'package:modulo04/controllers/api.dart';
import 'package:modulo04/controllers/biometria.dart';
import 'package:modulo04/controllers/validator.dart';
import 'package:modulo04/styles/styles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;
  String? senha;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Biometria.logar(context);
    super.initState();
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
          child: SingleChildScrollView(
            child: Container(
              width: width,
              height: height - 20,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/Logo.png', height: 40),
                    Container(height: height * .1),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => email = value,
                      validator: (value) => Validator.validarDados(email),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          'Email',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                        ),
                      ),
                    ),
                    Container(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onChanged: (value) => senha = value,
                      validator: (value) => Validator.validarDados(senha),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        label: Text(
                          'Senha',
                          style: TextStyle(
                            fontFamily: Fontes.fonte,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                        ),
                      ),
                    ),
                    Container(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ApiController.logar(email!, senha!, context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                          fontFamily: Fontes.fonte,
                        ),
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
