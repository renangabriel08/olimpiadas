import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:modulo03/main.dart';
import 'package:modulo03/models/user.dart';
import 'package:modulo03/widgets/toast.dart';

class ApiController {
  static int erros = 0;

  static logar(String email, String senha) async {
    try {
      final url = Uri.parse(
        'https://apieuvounatrip.azurewebsites.net/api/Usuarios/Login?email=$email&senha=$senha',
      );
      final req = await http.post(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        Map<String, dynamic> decodedToken = JwtDecoder.decode(res['token']);

        User.user = decodedToken;

        MyToast.gerar('Login realizado com sucesso!');
        erros = 1;

        navKey.currentState!.pushNamed('/home');
      } else {
        erros++;
        MyToast.gerar('Usuário/Senha inválidos!');
      }
    } catch (e) {
      MyToast.gerar('Erro ao realizar login!');
    }
  }
}
