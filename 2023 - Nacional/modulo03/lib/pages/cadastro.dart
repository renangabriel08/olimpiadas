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
  String email = '';
  String senha = '';
  bool obscureText = true;

  logar() async {
    if (_formKey.currentState!.validate()) {
      await ApiController.logar(email, senha);
      setState(() {});
    } else {
      MyToast.gerar('Preencha todos os campos');
    }
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
              child: SizedBox(
                width: width,
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Textos.txt2('Cadastro', TextAlign.center, Cores.verde3),
                    Container(height: height * .15),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => email = value,
                      validator: (value) => Validator.login(email),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
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
                    Container(height: height * .03),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: obscureText,
                      onChanged: (value) => senha = value,
                      validator: (value) => Validator.login(senha),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
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
                    Container(height: height * .15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => logar(),
                      child: Textos.txt1(
                        'Acessar',
                        TextAlign.center,
                        Cores.verde3,
                      ),
                    ),
                    Container(height: height * .2),
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
