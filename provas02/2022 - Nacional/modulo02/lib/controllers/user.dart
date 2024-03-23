import 'dart:convert';

import 'package:http/http.dart' as http;

class UserController {
  static Future getUser() async {
    try {
      final url = Uri.parse('http://10.91.236.150:3000/tp01/usuarios/');
      final req = await http.get(url, headers: {
        'AUTHORIZATION':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJlbm5hbkBnbWFpbC5jb20iLCJpZF91c3VhcmlvIjo4LCJub21lIjoiUmVuYW4gR2FicmllbCIsImlhdCI6MTcxMTEzODYyNX0.WoH6cWdGKgrY0gC_FblSSxnl7pWe7k3p586ujHFr09c'
      });

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));

        Map<String, dynamic> user = {
          'nome': res['dados_usuario']['nome'],
          'email': res['dados_usuario']['email'],
          'img': res['dados_usuario']['imagem_url'],
        };

        return user;
      }
    } catch (e) {}
  }
}
