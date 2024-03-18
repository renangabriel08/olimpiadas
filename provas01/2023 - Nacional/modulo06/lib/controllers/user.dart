import 'dart:convert';
import 'package:http/http.dart' as http;

class UserController {
  static List checkins = [];

  static getUser() async {
    try {
      final url = Uri.parse(
        'https://apieuvounatrip.azurewebsites.net/api/Usuarios/2',
      );
      final req = await http.get(url);
      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res;
      }
    } catch (e) {}
  }

  static check() async {
    try {
      final url =
          Uri.parse('https://apieuvounatrip.azurewebsites.net/api/Checkins');
      final req = await http.get(url);
      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
      }
    } catch (e) {}
  }

  static Future getCheckins() async {
    try {
      final url =
          Uri.parse('https://apieuvounatrip.azurewebsites.net/api/Checkins');
      final req = await http.get(url);
      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        checkins = res;
      }
    } catch (e) {}
  }
}
