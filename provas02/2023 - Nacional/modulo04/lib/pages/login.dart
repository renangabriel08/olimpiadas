import 'package:flutter/material.dart';
import 'package:modulo04/controllers/biometria.dart';
import 'package:modulo04/controllers/login.dart';
import 'package:modulo04/controllers/validator.dart';
import 'package:modulo04/styles/styles.dart';
import 'package:modulo04/widgets/toast.dart';

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

  logar() {
    if (_formKey.currentState!.validate()) {
      LoginController.logar(email, senha);
    } else {
      MyToast.gerar('Preencha todos os campos');
    }
  }

  @override
  void initState() {
    Biometria.logar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/Logo.png'),
                    Container(height: height * .1),
                    TextFormField(
                      onChanged: (value) => email = value,
                      validator: (value) => Validator.validar(email),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(fontFamily: Fonts.font),
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                    ),
                    Container(height: height * .03),
                    TextFormField(
                      obscureText: obscureText,
                      onChanged: (value) => senha = value,
                      validator: (value) => Validator.validar(senha),
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Senha',
                        labelStyle: TextStyle(fontFamily: Fonts.font),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () =>
                              setState(() => obscureText = !obscureText),
                          icon: Icon(obscureText
                              ? Icons.visibility_outlined
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
                      onPressed: () => logar(),
                      child: Textos.padrao(
                        'Acessar',
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
