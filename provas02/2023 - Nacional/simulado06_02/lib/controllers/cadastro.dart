import 'package:http/http.dart' as http;
import 'package:simulado06_02/main.dart';
import 'package:simulado06_02/widgets/toast.dart';

class CadastroController {
  static cadastrar(String nome, String email, String senha) async {
    try {
      final url = Uri.parse('https://fredaugusto.com.br/simuladodrs/token');
      final req = http.MultipartRequest('POST', url);

      req.fields['nome_user'] = nome;
      req.fields['email_user'] = email;
      req.fields['senha_user'] = senha;

      final reqSend = await req.send();

      if (reqSend.statusCode == 200) {
        MyToast.gerar('Usuário adicionado com sucesso');
        navKey.currentState!.pushNamed('/login');
      } else {
        MyToast.gerar('Email/senha incorretos');
      }
    } catch (e) {
      MyToast.gerar('Erro ao realizar login');
    }
  }
}
