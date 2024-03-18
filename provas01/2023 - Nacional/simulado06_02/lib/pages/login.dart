import 'package:flutter/material.dart';
import 'package:simulado06_02/controllers/api.dart';
import 'package:simulado06_02/controllers/validator.dart';
import 'package:simulado06_02/styles/styles.dart';

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

  void logar() {
    if (_formKey.currentState!.validate()) {
      ApiController.logar(email, senha, context);
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
                          onChanged: (value) => email = value,
                          validator: (value) =>
                              ValidatorController.validarLogin(
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
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
                          onChanged: (value) => senha = value,
                          validator: (value) =>
                              ValidatorController.validarLogin(
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
                        Container(height: height * .05),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => logar(),
                          child: Textos.padrao('Entar'),
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
                            '/cadastro',
                          ),
                          child: Textos.padrao('Cadastrar'),
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
