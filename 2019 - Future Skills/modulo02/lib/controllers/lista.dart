import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modulo02/widgets/toast.dart';

class ListaController {
  static getLista() async {
    try {
      final url = Uri.parse('https://run.mocky.io/v3/fc7d69ee-61a6-4e64-a4f1-ff16f6a2f602');

      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res;
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao retornar dados');
    }
  }
}