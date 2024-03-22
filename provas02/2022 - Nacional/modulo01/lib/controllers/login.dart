import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:modulo01/widgets/toast.dart';

class LoginController {
  static int erros = 0;
  static bool enabled = true;

  static errou() {
    erros++;
    verificarErros();
  }

  static verificarErros() {
    if (erros != 0 && erros % 3 == 0) {
      enabled = false;
      MyToast.get('Login bloqueado: aguarde 30s!');
      Future.delayed(const Duration(seconds: 30)).then(
        (value) => enabled = true,
      );
    }
  }

  static logar(String user, String senha) async {
    try {
      final url = Uri.parse('http://10.91.236.150:3000/tp01/usuarios/login');

      final req = await http.post(
        url,
        body: {"usuario": user, "senha": senha},
      );

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
      } else {
        errou();
        MyToast.get('Usuário/Senha inválidos!');
      }
    } catch (e) {
      MyToast.get('Erro ao realizar login');
    }
  }
}
