import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:modulo03/main.dart';
import 'package:modulo03/widgets/toast.dart';

class LoginController {
  static int erros = 0;
  static bool enabled = true;
  static String token = '';

  static logar(String email, String senha) async {
    final url = Uri.parse(
      'https://apieuvounatrip.azurewebsites.net/api/Usuarios/Login?email=$email&senha=$senha',
    );

    final req = await http.post(url);

    if (req.statusCode == 200) {
      final res = jsonDecode(utf8.decode(req.bodyBytes));
      token = res['token'];
      erros = 0;
      navKey.currentState!.pushNamed('/home');
    } else {
      erros++;
      MyToast.gerar('Usuário/Senha inválidos!');
    }

    print(req.statusCode);
  }
}
