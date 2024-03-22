import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:modulo01/controllers/cache.dart';

class HomeController {
  static Future getUser() async {
    try {
      final url = Uri.parse('http://10.91.236.150:3000/tp01/usuarios/');

      String token = await CacheController.getToken() ?? '';

      final req = await http.get(url, headers: {
        'AUTHORIZATION': 'Bearer $token',
      });

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));

        print(res);
        return {
          'nome': res['dados_usuario']['nome'],
          'email': res['dados_usuario']['email'],
          'img': res['dados_usuario']['imagem_url'],
        };
      }
    } catch (e) {}
  }
}
