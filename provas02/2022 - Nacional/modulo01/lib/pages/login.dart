import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modulo01/controllers/cache.dart';
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
  final _formKey = GlobalKey<FormState>();
  String user = '';
  String senha = '';
  bool obscureText = true;

  verificarErros() {
    if (LoginController.erros != 0 && LoginController.erros % 3 == 0) {
      LoginController.enabled = false;
      MyToast.get('Login bloqueado: aguarde 30s!');
      Future.delayed(const Duration(seconds: 30)).then(
        (value) => LoginController.enabled = true,
      );
    } else {
      LoginController.enabled = true;
    }
  }

  logar() async {
    if (_formKey.currentState!.validate()) {
      await LoginController.logar(user, senha);
      if (LoginController.errouLogin) {
        verificarErros();
      }
    }

    setState(() {});
  }

  esconderSenha() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    CacheController.setLog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: width,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo.png', height: 50),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            txt: 'Login',
                            size: 32,
                            textAlign: TextAlign.center,
                            cor: Cores.ciano,
                          ),
                          MyText(
                            txt: 'Acesse nosso sistema',
                            size: 16,
                            textAlign: TextAlign.center,
                            cor: Cores.cinza,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(height: height * .1),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          enabled: LoginController.enabled,
                          onChanged: (value) => user = value,
                          validator: (value) => Validator.login(user),
                          keyboardType: TextInputType.name,
                          style: TextStyle(fontFamily: Fonts.font),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Usuário',
                            labelStyle: TextStyle(fontFamily: Fonts.font),
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                        ),
                        Container(height: 10),
                        TextFormField(
                          enabled: LoginController.enabled,
                          obscureText: obscureText,
                          onChanged: (value) => senha = value,
                          validator: (value) => Validator.login(senha),
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(fontFamily: Fonts.font),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Senha',
                            labelStyle: TextStyle(fontFamily: Fonts.font),
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: () => esconderSenha(),
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
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
                          onPressed: () =>
                              LoginController.enabled ? logar() : null,
                          child: MyText(
                            txt: 'Acessar',
                            size: 16,
                            textAlign: TextAlign.center,
                            cor: Cores.ciano,
                          ),
                        ),
                        Container(height: 10),
                        OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => LoginController.enabled
                              ? Navigator.pushNamed(
                                  context,
                                  '/cadastro',
                                )
                              : null,
                          child: MyText(
                            txt: 'Cadastre-se',
                            size: 16,
                            textAlign: TextAlign.center,
                            cor: Cores.cinza,
                          ),
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
