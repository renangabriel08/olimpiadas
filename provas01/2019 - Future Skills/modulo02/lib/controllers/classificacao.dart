import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modulo02/widgets/toast.dart';

class ClassificacaoController {
  static getLista() async {
    try {
      final url = Uri.parse('https://run.mocky.io/v3/e4b100f0-e801-4294-adcb-743b1647eae8');

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