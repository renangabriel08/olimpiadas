import 'package:http/http.dart' as http;
import 'package:modulo05/main.dart';

class ApiController {
  static logar(String user, String senha) async {
    try {
      final url = Uri.parse('http://10.91.236.179:3000/tp01/usuarios/login');
      final req = await http.post(url, body: {
        "usuario": user,
        "senha": senha,
      });

      if (req.statusCode == 200) {
        navKey.currentState!.pushNamed('/tarefasRelogio');
      } else {
        navKey.currentState!.pushNamed('/erroRelogio');
      }
    } catch (e) {
      navKey.currentState!.pushNamed('/erroRelogio');
    }
  }
}
