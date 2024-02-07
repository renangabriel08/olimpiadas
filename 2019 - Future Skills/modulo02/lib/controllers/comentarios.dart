import 'dart:convert';

import 'package:modulo02/widgets/toast.dart';
import 'package:http/http.dart' as http;

class ComentariosController {
  static getComentarios() async {
    try {
      final url = Uri.parse('https://run.mocky.io/v3/526ddd16-8d5c-40aa-bb17-0e98a4fdc76b');

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