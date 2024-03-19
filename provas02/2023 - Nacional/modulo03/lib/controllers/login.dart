import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:modulo03/widgets/toast.dart';

class LoginController {
  static int erros = 0;
  static bool enabled = true;

  static logar(String email, String senha) async {
    final url = Uri.parse(
      'https://apieuvounatrip.azurewebsites.net/api/Usuarios/Login',
    );

    final req = await http.post(url, body: {'email': email, 'senha': senha});

    if (req.statusCode == 200) {
      final res = jsonDecode(utf8.decode(req.bodyBytes));
    } else {
      erros++;
      MyToast.gerar('Usuário/Senha inválidos!');
    }

    print(req.statusCode);
  }
}
