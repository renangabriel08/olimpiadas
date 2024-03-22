import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:modulo01/widgets/toast.dart';

class LoginController {
  static int erros = 0;
  static bool errouLogin = false;
  static bool enabled = true;

  static errou() {
    erros++;
    errouLogin = true;
  }

  static logar(String user, String senha) async {
    try {
      final url = Uri.parse('http://10.91.236.150:3000/tp01/usuarios/login');

      final req = await http.post(
        url,
        body: {"usuario": user, "senha": senha},
      );

      if (req.statusCode == 200) {
        errouLogin = false;
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        print(res);
      } else {
        errou();
        MyToast.get('Usuário/Senha inválidos!');
      }
    } catch (e) {
      MyToast.get('Erro ao realizar login');
    }
  }
}
