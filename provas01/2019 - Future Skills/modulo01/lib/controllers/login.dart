import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modulo01/controllers/cache.dart';
import 'package:modulo01/main.dart';
import 'package:modulo01/widgets/toast.dart';

class LoginController {
  static logar(String user, String senha) async {
    try {
      final url = Uri.parse('http://10.91.236.188:3000/tp01/usuarios/login');

      final req = await http.post(
        url,
        body: {"usuario": user, "senha": senha},
      );

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        CacheController.salvarLogin(res['token']);
        MyToast.gerarToast(res['message']);
        navKey.currentState!.pushNamed('/home');
      } else {
        MyToast.gerarToast('Usuário ou senha incorreto!');
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao realzar login!');
    }
  }
}
