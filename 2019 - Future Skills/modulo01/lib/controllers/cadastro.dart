import 'dart:io';

import 'package:modulo01/controllers/cache.dart';
import 'package:modulo01/main.dart';
import 'package:modulo01/widgets/toast.dart';
import 'package:http/http.dart' as http;

class CadastroController {
  static cadastrar(
    String email,
    String user,
    String senha,
    String cel,
    File file,
  ) async {
    try {
      final url = Uri.parse('http://10.91.236.188:3000/tp01/usuarios/cadastro');

      final stream = http.ByteStream(file.openRead());
      final length = await file.length();
      final name = file.path;
      final img = http.MultipartFile('imagem', stream, length, filename: name);
      final req = http.MultipartRequest('POST', url);

      req.fields['email'] = email;
      req.fields['senha'] = senha;
      req.fields['nome'] = user;
      req.fields['usuario'] = user;
      req.fields['celular'] = cel;

      req.files.add(img);

      final request = await req.send();

      if (request.statusCode == 201) {
        MyToast.gerarToast('Usuário cadastrado com sucesso!');
        CacheController.salvarUser(user);
        navKey.currentState!.pushNamed('/login');
      } else {
        MyToast.gerarToast('Erro ao realizar cadastro!');
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao realizar cadastro!');
    }
  }
}
