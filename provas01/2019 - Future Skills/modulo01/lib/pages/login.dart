import 'package:flutter/material.dart';
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

  TextEditingController _controller = TextEditingController();
  String user = '';
  String senha = '';
  bool obscureText = true;

  logar() {
    if (_formKey.currentState!.validate()) {
      LoginController.logar(user, senha);
    } else {
      MyToast.gerarToast('Preencha todos os campos');
    }
  }

  getData(value) {
    user = value[0];
    _controller.text = user;
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([CacheController.getUser()]).then((value) => getData(value));
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
        color: Cores.cinza1,
        child: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/logo3.png'),
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Cores.ciano,
                          ),
                        ),
                      ],
                    ),
                    Container(height: height * .03),
                    TextFormField(
                      controller: _controller,
                      validator: (value) => Validar.validarLogin(user),
                      onChanged: (value) => user = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        label: Text(
                          'Usuário',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) => Validar.validarLogin(senha),
                      onChanged: (value) => senha = value,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: obscureText,
                      decoration: const InputDecoration(
                        label: Text(
                          'Senha',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(height: height * .05),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, 42),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Cores.ciano,
                      ),
                      onPressed: () => logar(),
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Cores.cinza1,
                        ),
                      ),
                    ),
                    Container(height: height * .01),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, 42),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Cores.azul,
                      ),
                      onPressed: () => logar(),
                      child: const Text(
                        'Login com Facebook',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(height: height * .01),
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, 42),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Cores.ciano,
                            width: 2,
                          ),
                        ),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/cadastro'),
                      child: const Text(
                        'Cadastrar-se',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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
