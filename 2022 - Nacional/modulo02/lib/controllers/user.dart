import 'dart:convert';

import 'package:modulo02/widgets/toast.dart';
import 'package:http/http.dart' as http;

class UserController {
  static getUser() async {
    try {
      String tkn =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJlbmFuQGdtYWlsLmNvbSIsImlkX3VzdWFyaW8iOjEsIm5vbWUiOiJSZW5hbiIsImlhdCI6MTcwODcxNjE1OX0.7JrSdKEI4zjtWK3xSfoIQ-3ggUX7gsId54Tmi426TIo';

      final url = Uri.parse('http://10.91.236.243:3000/tp01/usuarios/');
      final req =
          await http.get(url, headers: {'Authorization': 'Bearer $tkn'});

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));

        String nome = res['dados_usuario']['nome'];
        String img = res['dados_usuario']['imagem_url'];
        img = img.replaceAll('localhost', 'http://10.91.236.243');
        img = img.replaceFirst('http://10.91.236.243:3000/', '');

        return [nome, img];
      }
    } catch (e) {
      MyToast.gerar('Erro ao buscar dados do usuário');
    }
  }

  static salvar(String dtHr, double distancia, String tempo) async {
    try {
      String tkn =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJlbmFuQGdtYWlsLmNvbSIsImlkX3VzdWFyaW8iOjEsIm5vbWUiOiJSZW5hbiIsImlhdCI6MTcwODcxNjE1OX0.7JrSdKEI4zjtWK3xSfoIQ-3ggUX7gsId54Tmi426TIo';

      final url = Uri.parse(
        'http://10.91.236.243:3000/tp02/corridas_caminhadas',
      );
      final req = await http.post(
        url,
        headers: {'Authorization': 'Bearer $tkn'},
        body: {
          "data_hora": dtHr,
          "distancia": distancia.toString(),
          "tempo": tempo
        },
      );

      if (req.statusCode == 200) {
        MyToast.gerar('Exercício registrado com sucesso');
      } else {
        MyToast.gerar('Erro ao registrar exercício');
      }
    } catch (e) {
      MyToast.gerar('Erro ao registrar exercício');
      print('Erro: $e');
    }
  }
}
