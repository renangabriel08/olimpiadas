import 'package:http/http.dart' as http;

class LoginController {
  static logar(String email, String senha) async {
    try {
      final url = Uri.parse('https://fredaugusto.com.br/simuladodrs/token');
      final req = http.MultipartRequest('POST', url);

      req.fields['email'] = email;
      req.fields['senha'] = senha;

      final reqSend = await req.send();

      if (reqSend.statusCode == 200) {
        print('login');
      }
    } catch (e) {}
  }
}
