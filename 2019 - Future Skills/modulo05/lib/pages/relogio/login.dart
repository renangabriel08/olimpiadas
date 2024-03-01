import 'package:flutter/material.dart';
import 'package:modulo05/controllers/api.dart';
import 'package:modulo05/controllers/validator.dart';
import 'package:modulo05/styles/styles.dart';

class LoginRelogio extends StatefulWidget {
  const LoginRelogio({super.key});

  @override
  State<LoginRelogio> createState() => _LoginRelogioState();
}

class _LoginRelogioState extends State<LoginRelogio> {
  final _formKey = GlobalKey<FormState>();
  String user = '';
  String senha = '';

  bool obscureText = true;

  login() {
    if (_formKey.currentState!.validate()) {
      ApiController.logar(user, senha);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Cores.cinza,
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/images/logoP.png'),
                Container(height: height * .05),
                SizedBox(
                  height: height * .15,
                  child: TextFormField(
                    onChanged: (value) => user = value,
                    keyboardType: TextInputType.name,
                    validator: (value) => Validar.validar(user),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Cores.ciano,
                        ),
                      ),
                      label: Textos.txt(
                        'Usuário',
                        14,
                        TextAlign.left,
                        Cores.branco,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(height: height * .02),
                SizedBox(
                  height: height * .15,
                  child: TextFormField(
                    obscureText: obscureText,
                    onChanged: (value) => senha = value,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => Validar.validar(senha),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          obscureText = !obscureText;
                        }),
                        icon: Icon(
                          obscureText
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 15,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Cores.ciano,
                        ),
                      ),
                      label: Textos.txt(
                        'Senha',
                        14,
                        TextAlign.left,
                        Cores.branco,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(height: height * .05),
                GestureDetector(
                  onTap: () => login(),
                  child: Container(
                    width: width,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Cores.ciano,
                    ),
                    child: Center(
                      child: Textos.txt(
                        'Entrar',
                        12,
                        TextAlign.center,
                        Cores.cinza,
                        FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
