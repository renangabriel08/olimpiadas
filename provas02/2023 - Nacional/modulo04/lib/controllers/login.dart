import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modulo04/main.dart';
import 'package:modulo04/widgets/toast.dart';

class LoginController {
  static String token = '';

  static logar(String email, String senha) async {
    try {
      final url = Uri.parse(
        'https://apieuvounatrip.azurewebsites.net/api/Usuarios/Login?email=$email&senha=$senha',
      );

      final req = await http.post(url);
      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        token = res['token'];
        navKey.currentState!.pushNamed('/inicio');
        MyToast.gerar('Login realizado com sucesso');
      } else {
        MyToast.gerar('Email/senha incorretos');
      }
    } catch (e) {
      MyToast.gerar('Erro ao realizar login');
    }
  }
}
