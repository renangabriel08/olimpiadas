import 'package:flutter/material.dart';
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
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
