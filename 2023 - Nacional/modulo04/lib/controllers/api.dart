import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiController {
  static logar(String email, String senha, context) async {
    final url = Uri.parse(
      'https://apieuvounatrip.azurewebsites.net/api/Usuarios/Login?email=$email&senha=$senha',
    );

    final req = await http.post(url);

    if (req.statusCode == 200) {
      final res = jsonDecode(utf8.decode(req.bodyBytes));
      return res;
    }
  }
}
