import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:modulo05/main.dart';

class ApiController {
  static logar(String user, String senha) async {
    try {
      final url = Uri.parse('http://10.91.236.179:3000/tp01/usuarios/login');
      final req = await http.post(url, body: {
        "usuario": user,
        "senha": senha,
      });

      if (req.statusCode == 200) {
        navKey.currentState!.pushNamed('/tarefasRelogio');
      } else {
        navKey.currentState!.pushNamed('/erroRelogio');
      }
    } catch (e) {
      navKey.currentState!.pushNamed('/erroRelogio');
    }
  }

  static getData() async {
    try {
      final url = Uri.parse(
        'https://run.mocky.io/v3/2eaabc74-2bd9-4dca-b152-5aad952bad29',
      );
      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res;
      }
    } catch (e) {}
  }
}
