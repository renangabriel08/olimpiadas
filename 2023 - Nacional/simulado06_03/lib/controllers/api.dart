import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiController {
  static Future getUser() async {
    final url = Uri.parse('https://fredaugusto.com.br/simuladodrs/users/1');

    final req = await http.get(url);

    if (req.statusCode == 200) {
      final res = jsonDecode(utf8.decode(req.bodyBytes));
      return res;
    }
  }
}
