import 'package:flutter/material.dart';
import 'package:modulo01/controllers/login.dart';
import 'package:modulo01/controllers/validator.dart';
import 'package:modulo01/styles/styles.dart';
import 'package:modulo01/widgets/toast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? usuario;
  String? senha;
  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;
  bool enabled = true;

  bloquear() async {
    setState(() {
      enabled = false;
    });

    await Future.delayed(const Duration(seconds: 30));

    setState(() {
      enabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    int erros = 0;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bem vindo de volta a',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: Fontes.fonte,
                        color: Cores.cinza,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Vita',
                          style: TextStyle(
                            fontSize: 40,
                            fontFamily: Fontes.fonte,
                            color: Cores.vermelho,
                          ),
                        ),
                        Text(
                          'Health',
                          style: TextStyle(
                            fontSize: 40,
                            fontFamily: Fontes.fonte,
                            color: Cores.ciano,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(height: 60),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        enabled: enabled,
                        keyboardType: TextInputType.name,
                        validator: (value) => ValidarDadosLogin.validarDados(
                          value!,
                        ),
                        onChanged: (value) => usuario = value,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                          label: Text(
                            'Usuário',
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              color: Cores.cinza,
                            ),
                          ),
                        ),
                      ),
                      Container(height: 20),
                      TextFormField(
                        enabled: enabled,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) => ValidarDadosLogin.validarDados(
                          value!,
                        ),
                        obscureText: obscureText,
                        onChanged: (value) => senha = value,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              obscureText = !obscureText;
                            }),
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          border: const OutlineInputBorder(),
                          label: Text(
                            'Senha',
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              color: Cores.cinza,
                            ),
                          ),
                        ),
                      ),
                      Container(height: 60),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: enabled
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      var res = await LoginController.logar(
                                        usuario!,
                                        senha!,
                                        context,
                                      );

                                      if (res == 'erro') {
                                        erros++;
                                        if (erros % 3 == 0) {
                                          bloquear();
                                          MyToast.gerarToast(
                                            'Login bloqueado: aguarde 30s!',
                                          );
                                        }
                                      }
                                    }
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Entar',
                              style: TextStyle(
                                fontFamily: Fontes.fonte,
                                color: Cores.ciano,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Não possui conta?',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  color: Cores.cinza,
                                ),
                              ),
                              TextButton(
                                onPressed: enabled
                                    ? () => Navigator.pushNamed(
                                          context,
                                          '/cadastro',
                                        )
                                    : null,
                                child: Text(
                                  'Cadastre-se',
                                  style: TextStyle(
                                    fontFamily: Fontes.fonte,
                                    color: Cores.ciano,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
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
