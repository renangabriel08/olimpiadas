import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:modulo01/main.dart';
import 'package:modulo01/widgets/toast.dart';

class CadastroController {
  static cadastrar(
    File img,
    String email,
    String celular,
    String user,
    String senha,
    String nome,
  ) async {
    try {
      final url = Uri.parse('http://10.91.236.150:3000/tp01/usuarios/cadastro');

      final request = http.MultipartRequest('POST', url);
      final stream = http.ByteStream(img.openRead());
      final length = await img.length();

      request.fields['email'] = email;
      request.fields['senha'] = senha;
      request.fields['nome'] = nome;
      request.fields['usuario'] = user;
      request.fields['celular'] = celular;

      request.files.add(
        http.MultipartFile('imagem', stream, length, filename: img.path),
      );

      final req = await request.send();

      if (req.statusCode == 201) {
        MyToast.get('Cadastro realizado com sucesso');
        navKey.currentState!.pushNamed('/login');
      } else {
        MyToast.get('Erro ao realizar cadastro');
      }
    } catch (e) {
      MyToast.get('Erro ao realizar cadastro');
    }
  }
}
