import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:modulo01/controllers/cache.dart';
import 'package:modulo01/widgets/toast.dart';

class HomeController {
  static getDesafioAtual() async {
    try {
      final url = Uri.parse(
        'https://run.mocky.io/v3/fddeb8cb-a3d8-4589-8f0d-533c4b7d6af9',
      );

      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res;
      } else {
        MyToast.gerarToast('Erro ao buscar dados!');
      }
    } catch (e) {
      MyToast.gerarToast('Você está sem internet!');
    }
  }

  static getTarefasAtuais() async {
    try {
      final url = Uri.parse(
        'https://run.mocky.io/v3/2889a433-be37-49cc-8afb-9d87eb88504b',
      );

      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res;
      } else {
        MyToast.gerarToast('Erro ao buscar dados!');
      }
    } catch (e) {
      MyToast.gerarToast('Você está sem internet!');
    }
  }

  static getDesafiosPopulares() async {
    try {
      final url = Uri.parse(
        'https://run.mocky.io/v3/96b528dd-2db5-4f57-a30b-dcd7e70956ab',
      );

      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res;
      } else {
        MyToast.gerarToast('Erro ao buscar dados!');
      }
    } catch (e) {
      MyToast.gerarToast('Você está sem internet!');
    }
  }

  static getUser() async {
    try {
      final url = Uri.parse('http://10.91.236.188:3000/tp01/usuarios/');
      String token = await CacheController.getToken();

      final req = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });

      if (req.statusCode == 200) {
        return jsonDecode(utf8.decode(req.bodyBytes));
      }
    } catch (e) {
      
    }
  }
}
