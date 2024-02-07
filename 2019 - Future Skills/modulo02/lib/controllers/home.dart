import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modulo02/widgets/toast.dart';

class HomeController {
  static getUser() async {
    try {
      final url = Uri.parse('https://run.mocky.io/v3/45f08fb1-ab72-4d8b-93e1-7bedb866fcfe');

      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res;
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao retornar dados');
    }
  }

  static getClima() async {
    try {
      final url = Uri.parse('https://run.mocky.io/v3/d1343616-a1ed-43ee-a053-fe27da55c43a');

      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res;
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao retornar dados');
    }
  }

  static returnHome() async {
    return [await getUser(), await getClima()];
  }
}
