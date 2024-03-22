import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modulo01/controllers/cache.dart';
import 'package:modulo01/main.dart';
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
        CacheController.setToken(res['token']);
        getUser(res['token']);
      } else {
        errou();
        MyToast.get('Usuário/Senha inválidos!');
      }
    } catch (e) {
      MyToast.get('Erro ao realizar login');
    }
  }

  static getUser(token) async {
    try {
      final url = Uri.parse('http://10.91.236.150:3000/tp01/usuarios/');

      final req = await http.get(url, headers: {
        'AUTHORIZATION': 'Bearer $token',
      });

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));

        MyToast.get('Autenticado com sucesso');
        if (res['dados_usuario']['dt_nascimento'] == null) {
          navKey.currentState!.pushNamed('/primeiroAcesso');
        } else {
          navKey.currentState!.pushNamed('/home');
        }
      } else {
        errou();
        MyToast.get('Usuário/Senha inválidos!');
      }
    } catch (e) {
      MyToast.get('Erro ao realizar login');
    }
  }
}
