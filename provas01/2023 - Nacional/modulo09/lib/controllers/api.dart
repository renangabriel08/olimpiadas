import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:modulo09/widgets/toast.dart';

class ApiController {
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
    } catch (e) {}
  }

  static Future deleteReclamacoes(id) async {
    try {
      final url = Uri.parse(
        'https://apieuvounatrip.azurewebsites.net/api/Reclamacoes/$id',
      );

      final req = await http.delete(url);
      if (req.statusCode == 204) {
        MyToast.gerar('Reclamação deletada com sucesso');
      }
    } catch (e) {
      MyToast.gerar('Erro ao deletar reclamação');
    }
  }

  static Future cadastrarReclamacao(String titulo, String desc, int id) async {
    try {
      final url = Uri.parse(
        'https://apieuvounatrip.azurewebsites.net/api/Reclamacoes',
      );

      final req = await http.post(url, body: {
        "titulo": titulo,
        "descricao": desc,
        "ordem": 3,
        "usuarioId": 2,
        "tipoReclamacaoId": id,
        "tipoReclamacao": null,
        "usuario": null
      });
      if (req.statusCode == 200) {
        MyToast.gerar('Reclamação cadastrada com sucesso');
      }
    } catch (e) {}
  }
}