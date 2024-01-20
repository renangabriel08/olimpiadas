import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:simulado06_02/widgets/toast.dart';

class ApiController {
  static logar(String email, String senha, context) async {
    try {
      final url = Uri.parse('https://fredaugusto.com.br/simuladodrs/token');

      final req = http.MultipartRequest('POST', url);

      req.fields['email'] = email;
      req.fields['senha'] = senha;

      final res = await req.send();

      if (res.statusCode == 200) {
        await http.Response.fromStream(res).then((value) {
          Map<String, dynamic> decodedToken = JwtDecoder.decode(value.body);

          MyToast.gerarToast('Bem vindo ${decodedToken['nome_user']}!');
          Navigator.pushNamed(context, '/home');
        });
      } else {
        MyToast.gerarToast('Email ou senha incorreto');
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao realizar login');
    }
  }

  static cadastrar(nome, email, apelido, senha) async {}
}
