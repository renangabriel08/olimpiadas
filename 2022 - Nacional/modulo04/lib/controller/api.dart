import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:modulo04/widgets/modais.dart';
import 'package:modulo04/widgets/toast.dart';

class ApiCntroller {
  static String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3RlQGdtYWlsLmNvbSIsImlkX3VzdWFyaW8iOjEsIm5vbWUiOiJ0ZXN0ZSIsImlhdCI6MTcwNDQ3NDc3Nn0.l_P9BEo5ZjnG3rNEuMEpM7edWZeWheDx1xfPSl0fTeI';

  static Future<Map> getUser() async {
    try {
      final url = Uri.parse('http://192.168.86.103:3000/tp04/usuarios');

      final req =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res;
      } else {
        MyToast.gerarToast(
          'Falha ao tentar acessar o sistema, tente novamente mais tarde.',
        );
        return {};
      }
    } catch (e) {
      MyToast.gerarToast(
        'Falha ao tentar acessar o sistema, tente novamente mais tarde.',
      );
      print(e);
      return {};
    }
  }

  static Future<Map> getProdutos() async {
    try {
      final url = Uri.parse('http://192.168.86.103:3000/tp04/produtos');

      final req =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res;
      } else {
        MyToast.gerarToast(
          'Falha ao tentar acessar o sistema, tente novamente mais tarde.',
        );
        return {};
      }
    } catch (e) {
      MyToast.gerarToast(
        'Falha ao tentar acessar o sistema, tente novamente mais tarde.',
      );
      print(e);
      return {};
    }
  }

  static deleteProdutos(id) async {
    try {
      final url = Uri.parse('http://192.168.86.103:3000/tp04/produtos/$id');

      final req = await http.delete(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (req.statusCode == 200) {
        MyToast.gerarToast(
          'Produto apagado com sucesso!',
        );
      } else {
        MyToast.gerarToast(
          'Falha ao deletar produto.',
        );
        return {};
      }
    } catch (e) {
      MyToast.gerarToast(
        'Falha ao deletar produto.',
      );
      print(e);
    }
  }

  static comprarProdutos(id, preco) async {
    try {
      final url = Uri.parse(
        'http://192.168.86.103:3000/tp04/produtos/comprar/$id',
      );

      final req = await http.post(
        url,
        body: {'preco': preco.toString()},
        headers: {'Authorization': 'Bearer $token'},
      );

      if (req.statusCode == 200) {
        MyToast.gerarToast(
          'Produto comprado com sucesso!',
        );
      } else {
        MyToast.gerarToast(
          'Falha ao comprar produto.',
        );
        return {};
      }
    } catch (e) {
      MyToast.gerarToast(
        'Falha ao comprar produto.',
      );
      print(e);
    }
  }

  static cadastrarProduto(nome, desc, preco, File img, context) async {
    try {
      final url = Uri.parse('http://192.168.86.103:3000/tp04/produtos');

      final stream = http.ByteStream(img.openRead());
      final length = await img.length();
      final image = http.MultipartFile(
        'imagem',
        stream,
        length,
        filename: 'oi',
      );
      final request = http.MultipartRequest('POST', url);

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['nome'] = nome;
      request.fields['descricao'] = desc;
      request.fields['preco'] = preco;

      request.files.add(image);

      final res = await request.send();

      if (res.statusCode == 201) {
        Modais.showMyDialogCadastrar(
          context,
          'Parabéns!',
          'Produto cadastrado com sucesso!',
        );
      } else {
        MyToast.gerarToast(
          'Falha ao tentar acessar o sistema, tente novamente mais tarde',
        );
      }
    } catch (e) {
      MyToast.gerarToast(
        'Falha ao tentar acessar o sistema, tente novamente mais tarde',
      );
      print(e);
    }
  }
}
