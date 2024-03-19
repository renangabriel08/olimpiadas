import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modulo03/widgets/toast.dart';

class CadastroController {
  static cadastrar(String nome, String email, String senha) async {
    final url = Uri.parse(
      'https://apieuvounatrip.azurewebsites.net/api/Usuarios',
    );

    final req = await http.post(url, body: {
      "nome": nome,
      "email": email,
      "senha": senha,
      "dr": "SP",
      "tipoUsuarioId": "1"
    });

    if (req.statusCode == 200) {
      final res = jsonDecode(utf8.decode(req.bodyBytes));
      print(res);
    } else {
      MyToast.gerar('Erro ao criar usuário!');
    }

    print(req.statusCode);
  }
}
