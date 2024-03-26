import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:simulado06_02/main.dart';
import 'package:simulado06_02/widgets/toast.dart';

class LoginController {
  static logar(String email, String senha) async {
    try {
      final url = Uri.parse('https://fredaugusto.com.br/simuladodrs/token');
      final req = http.MultipartRequest('POST', url);

      req.fields['email'] = email;
      req.fields['senha'] = senha;

      final reqSend = await req.send();

      if (reqSend.statusCode == 200) {
        final response = await http.Response.fromStream(reqSend);
        final res = jsonDecode(response.body);
        Map<String, dynamic> user = JwtDecoder.decode(res['access_token']);
        MyToast.gerar('Bem vindo ${user['nome_user']}!');
        navKey.currentState!.pushNamed('/inicio');
      } else {
        MyToast.gerar('Email/senha incorretos');
      }
    } catch (e) {
      MyToast.gerar('Erro ao realizar login');
    }
  }
}
