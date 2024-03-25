import 'package:http/http.dart' as http;
import 'package:simulado06_02/main.dart';
import 'package:simulado06_02/widgets/toast.dart';

class LoginController {
  static logar(String email, String senha) async {
    try {
      final url = Uri.parse('https://fredaugusto.com.br/simuladodrs/token');
      final req = http.MultipartRequest('POST', url);

      req.fields['email'] = email;
      req.fields['senha'] = senha;

      final reqSend = await req.send();

      if (reqSend.statusCode == 200) {
        MyToast.gerar('Bem vindo');
        navKey.currentState!.pushNamed('/home');
      } else {
        MyToast.gerar('Email/senha incorretos');
      }
    } catch (e) {
      MyToast.gerar('Erro ao realizar login');
    }
  }
}
