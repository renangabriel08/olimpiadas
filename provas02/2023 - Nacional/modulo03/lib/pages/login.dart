import 'package:flutter/material.dart';
import 'package:modulo03/controllers/validator.dart';
import 'package:modulo03/styles/styles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String senha = '';

  bool enabled = true;

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              validator: (value) => Validator.validarLogin(email),
              onChanged: (value) => email = value,
              keyboardType: TextInputType.emailAddress,
              enabled: enabled,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Email',
                labelStyle: TextStyle(fontFamily: Fonts.font),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            TextFormField(
              enabled: enabled,
              obscureText: obscureText,
              validator: (value) => Validator.validarLogin(senha),
              onChanged: (value) => senha = value,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Senha',
                labelStyle: TextStyle(fontFamily: Fonts.font),
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () => setState(() {
                    obscureText = !obscureText;
                  }),
                  icon: Icon(obscureText
                      ? Icons.visibility
                      : Icons.visibility_off_outlined),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
