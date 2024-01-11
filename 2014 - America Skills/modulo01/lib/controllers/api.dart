import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:modulo01/widgets/toast.dart';

class ApiController {
  static Future<List<dynamic>> getEvents() async {
    try {
      final url = Uri.parse(
        'https://run.mocky.io/v3/cb450eb6-cee9-4851-bf77-5aca9334a315',
      );

      final req = await http.get(url);

      if (req.statusCode == 200) {
        final List<dynamic> res = jsonDecode(utf8.decode(req.bodyBytes));
        return res;
      }

      return [];
    } catch (e) {
      MyToast.gerarToast('Erro ao realizar requisição');
      return [];
    }
  }
}
