import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:modulo03/widgets/toast.dart';

class GetUser {
  static getUser(String token) async {
    try {
      final url = Uri.parse('http://192.168.86.100:3000/tp03/usuarios');

      final req = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res['usuario'];
      } else {
        MyToast.gerarToast('Erro ao buscar dados do usuário');
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao buscar dados do usuário');
    }
  }
}

class PutCoins {
  static atualizar(String token, int coins) async {
    try {
      final url = Uri.parse('http://192.168.86.100:3000/tp03/usuarios/wscoins');

      final req = await http.put(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {'wscoins': '$coins'},
      );

      if (req.statusCode == 200) {
        MyToast.gerarToast('Troca realizada com sucesso');
      } else {
        MyToast.gerarToast('Erro realizar troca');
      }
    } catch (e) {
      MyToast.gerarToast('Erro realizar troca');
    }
  }

  static atualizarQuiz(String token, int coins) async {
    try {
      final url = Uri.parse('http://192.168.86.100:3000/tp03/usuarios/wscoins');

      final req = await http.put(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {'wscoins': '$coins'},
      );

      if (req.statusCode == 200) {
        MyToast.gerarToast('Parabéns! Você ganhou 10 coins');
      } else {
        MyToast.gerarToast('Erro ao adicionar coins');
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao adicionar coins');
    }
  }
}
