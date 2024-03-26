import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:modulo09/main.dart';
import 'package:modulo09/widgets/toast.dart';

class CadastroController {
  static cadastrar(String titulo, String desc, String tipo) async {
    int idReclamacao = 1;

    if (tipo == 'Cobrança') {
      idReclamacao = 1;
    }
    if (tipo == 'Serviços') {
      idReclamacao = 2;
    }
    if (tipo == 'Performance') {
      idReclamacao = 3;
    }
    if (tipo == 'Usabilidade') {
      idReclamacao = 4;
    }

    try {
      final url = Uri.parse(
        'https://apieuvounatrip.azurewebsites.net/api/Reclamacoes',
      );
      final req = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "titulo": titulo,
          "descricao": desc,
          "ordem": 3,
          "usuarioId": 2,
          "tipoReclamacaoId": idReclamacao,
          "tipoReclamacao": null,
          "usuario": null
        }),
      );

      if (req.statusCode == 200) {
        MyToast.get('Reclamação cadastrada com sucesso!');
        navKey.currentState!.pushNamed('/lista');
      } else {
        print(req.statusCode);
        MyToast.get('Erro ao cadastrar reclamação!');
      }
    } catch (e) {
      print('erro $e');
      MyToast.get('Erro ao cadastrar reclamação!');
    }
  }
}
