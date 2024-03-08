import 'package:flutter/material.dart';
import 'package:modulo03/controllers/api.dart';
import 'package:modulo03/controllers/validator.dart';
import 'package:modulo03/styles/styles.dart';
import 'package:modulo03/widgets/toast.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  String nome = '';
  String email = '';
  String dr = '';
  String senha = '';
  String cSenha = '';
  bool obscureText1 = true;
  bool obscureText2 = true;

  cadastrar() async {
    if (_formKey.currentState!.validate()) {
      await ApiController.cadastrar(nome, email, senha, dr);
    } else {
      MyToast.gerar('Preencha todos os campos');
    }
  }

  Future<void> modal() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Textos.txt2(
            'Cancelar?',
            TextAlign.start,
            Cores.azul2,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Textos.txt1(
                  'Deseja realmente cancelar essa operação?',
                  TextAlign.start,
                  Cores.azul1,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Textos.txt1(
                'Não',
                TextAlign.center,
                Cores.azul1,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Textos.txt1(
                'Sim',
                TextAlign.center,
                Cores.azul1,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Textos.txt2('Cadastro', TextAlign.center, Cores.verde3),
                  Container(height: height * .05),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => email = value,
                    validator: (value) => Validator.email(email),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontFamily: Fonts.font,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(height: height * .02),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    onChanged: (value) => nome = value,
                    validator: (value) => Validator.nome(nome),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Nome',
                      labelStyle: TextStyle(
                        fontFamily: Fonts.font,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(height: height * .02),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    onChanged: (value) => dr = value,
                    validator: (value) => Validator.login(dr),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.pin_drop),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'DR',
                      labelStyle: TextStyle(
                        fontFamily: Fonts.font,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(height: height * .02),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscureText1,
                    onChanged: (value) => senha = value,
                    validator: (value) => Validator.senha(senha),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          obscureText1 = !obscureText1;
                        }),
                        icon: Icon(
                          obscureText1
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Senha',
                      labelStyle: TextStyle(
                        fontFamily: Fonts.font,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(height: height * .02),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscureText2,
                    onChanged: (value) => cSenha = value,
                    validator: (value) => Validator.cSenha(cSenha, senha),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          obscureText2 = !obscureText2;
                        }),
                        icon: Icon(
                          obscureText2
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Confirmar senha',
                      labelStyle: TextStyle(
                        fontFamily: Fonts.font,
                        fontSize: 16,
                      ),
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
                    onPressed: () => cadastrar(),
                    child: Textos.txt1(
                      'Acessar',
                      TextAlign.center,
                      Cores.verde3,
                    ),
                  ),
                  Container(height: height * .02),
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      modal();
                    },
                    child: Textos.txt1(
                      'Cancelar',
                      TextAlign.center,
                      Cores.verde3,
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
