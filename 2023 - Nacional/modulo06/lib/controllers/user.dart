import 'dart:convert';
import 'package:http/http.dart' as http;

class UserController {
  static getUser() async {
    try {
      final url = Uri.parse('uri');
      final req = await http.get(url);
      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
      }
    } catch (e) {}
  }
}
