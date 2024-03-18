import 'package:firebase_database/firebase_database.dart';
import 'package:modulo04/widgets/toast.dart';

class PerfilController {
  static Future<bool> criar(
    String nome,
    String apelido,
    String cidade,
    String sobrenome,
    String imagem,
    String email,
  ) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("user/");

      await ref.set({
        "nome": nome,
        "apelido": apelido,
        "cidade": cidade,
        "sobrenome": sobrenome,
        "imagem": imagem,
        "email": email,
        "id": 1,
        "senha": '1234',
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Map> getData() async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('user/').get();
      if (snapshot.exists) {
        return snapshot.value as Map;
      } else {
        MyToast.gerarToast('Erro ao buscar dados do usuário');

        return {
          'senha': '',
          'cidade': '',
          'apelido': '',
          'imagem': null,
          'nome': '',
          'id': '',
          'sobrenome': ''
        };
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao buscar dados do usuário');

      return {
        'senha': '',
        'cidade': '',
        'apelido': '',
        'imagem': null,
        'nome': '',
        'id': '',
        'sobrenome': ''
      };
    }
  }
}
