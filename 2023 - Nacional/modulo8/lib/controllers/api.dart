import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiCOntroller {
  static Future getData() async {
    final url = Uri.parse(
      'https://apieuvounatrip.azurewebsites.net/api/Locais',
    );

    final req = await http.get(url);
    if (req.statusCode == 200) {
      final res = jsonDecode(utf8.decode(req.bodyBytes));

      return res;
    }
  }

  static Future getUsers() async {
    final url = Uri.parse(
      'https://apieuvounatrip.azurewebsites.net/api/Usuarios',
    );

    final req = await http.get(url);
    if (req.statusCode == 200) {
      final res = jsonDecode(utf8.decode(req.bodyBytes));

      return res;
    }
  }
}
