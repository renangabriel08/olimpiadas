import 'package:flutter/material.dart';
import 'package:modulo05/controllers/api.dart';
import 'package:modulo05/controllers/validator.dart';
import 'package:modulo05/styles/styles.dart';

class LoginTv extends StatefulWidget {
  const LoginTv({super.key});

  @override
  State<LoginTv> createState() => _LoginTvState();
}

class _LoginTvState extends State<LoginTv> {
  final _formKey = GlobalKey<FormState>();
  String user = '';
  String senha = '';

  bool obscureText = true;

  login() {
    if (_formKey.currentState!.validate()) {
      ApiController.logarTv(user, senha, context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Cores.preto,
          content: Textos.txt(
            'Preencha todos os dados!',
            16,
            TextAlign.center,
            Cores.branco,
            FontWeight.w400,
          ),
        ),
      );
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
          padding: EdgeInsets.fromLTRB(
            width * .3,
            height * .1,
            width * .3,
            height * .1,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 209,
                ),
                Container(height: height * .05),
                Textos.txt(
                  'Login',
                  32,
                  TextAlign.center,
                  Cores.ciano,
                  FontWeight.w700,
                ),
                Container(height: height * .05),
                TextFormField(
                  onChanged: (value) => user = value,
                  keyboardType: TextInputType.name,
                  validator: (value) => Validar.validarTv(user),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Cores.ciano,
                      ),
                    ),
                    label: Textos.txt(
                      'Usuário',
                      16,
                      TextAlign.left,
                      Cores.branco,
                      FontWeight.w400,
                    ),
                  ),
                ),
                Container(height: height * .02),
                TextFormField(
                  obscureText: obscureText,
                  onChanged: (value) => senha = value,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) => Validar.validarTv(senha),
                  decoration: InputDecoration(
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
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Cores.ciano,
                      ),
                    ),
                    label: Textos.txt(
                      'Senha',
                      16,
                      TextAlign.left,
                      Cores.branco,
                      FontWeight.w400,
                    ),
                  ),
                ),
                Container(height: height * .05),
                GestureDetector(
                  onTap: () => login(),
                  child: Container(
                    width: width,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Cores.ciano,
                    ),
                    child: Center(
                      child: Textos.txt(
                        'Entrar',
                        16,
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
