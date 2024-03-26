import 'dart:convert';
import 'package:http/http.dart' as http;

class ListaController {
  static Future getReclamacoes() async {
    try {
      final url = Uri.parse(
        'https://apieuvounatrip.azurewebsites.net/api/Reclamacoes',
      );
      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res;
      }
    } catch (e) {
      print('erro $e');
    }
  }
}
