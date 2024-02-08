import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modulo03/widgets/toast.dart';

class HomeController {
  static Future getData() async {
    try {
      final url = Uri.parse(
        'https://run.mocky.io/v3/02a48975-f147-4b54-8e43-fa9cb78ef053',
      );

      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res;
      } else {
        MyToast.gerarToast('Erro ao buscar dados');
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao realizar requisição');
    }
  }
}
