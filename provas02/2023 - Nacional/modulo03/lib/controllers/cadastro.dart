import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:modulo03/main.dart';
import 'package:modulo03/widgets/toast.dart';

class CadastroController {
  static cadastrar(String nome, String email, String senha) async {
    final url = Uri.parse(
      'https://apieuvounatrip.azurewebsites.net/api/Usuarios',
    );

    final req = await http.post(url,
        body: jsonEncode({
          "nome": nome,
          "email": email,
          "senha": senha,
          "dr": "SP",
          "tipoUsuarioId": "1"
        }),
        headers: {
          'Content-Type': 'application/json',
        });

    if (req.statusCode == 200) {
      MyToast.gerar('Usuário cadastrado com sucesso!');
      navKey.currentState!.pushNamed('/login');
    } else {
      MyToast.gerar('Erro ao criar usuário!');
    }

    print(req.statusCode);
  }
}
