import 'package:flutter/material.dart';
import 'package:simulado06_02/controllers/login.dart';
import 'package:simulado06_02/controllers/validators.dart';
import 'package:simulado06_02/styles/styles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String senha = '';
  bool obscureText = true;

  final _formKey = GlobalKey<FormState>();

  logar() async {
    if (_formKey.currentState!.validate()) {
      LoginController.logar(email, senha);
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
              child: SizedBox(
                height: height - 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png', height: 300),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => Validators.login(email),
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
                      obscureText: obscureText,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) => Validators.login(senha),
                      onChanged: (value) => senha = value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            obscureText = !obscureText;
                          }),
                          icon: Icon(
                            obscureText
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
                    Container(height: 50),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fixedSize: Size(width, 50),
                      ),
                      onPressed: () {
                        if (email != '' && senha != '') {
                          logar();
                        }
                      },
                      child: Textos(
                        txt: 'ENTRAR',
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
                      onPressed: () =>
                          Navigator.pushNamed(context, '/cadastro'),
                      child: Textos(
                        txt: 'CADASTRAR',
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
      ),
    );
  }
}
