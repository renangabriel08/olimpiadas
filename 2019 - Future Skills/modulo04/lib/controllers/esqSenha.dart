import 'package:firebase_database/firebase_database.dart';
import 'package:modulo04/widgets/toast.dart';

class EsqSenhaController {
  static update(senha) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("user/");

      await ref.update({
        "senha": senha,
      });
      MyToast.gerarToast('Senha alterada com sucesso!');
    } catch (e) {
      MyToast.gerarToast('Erro ao alterar senha!');
    }
  }

  static getSenha(senha) async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('user/senha').get();
      if (snapshot.exists) {
        return snapshot.value.toString() == senha;
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao verificar senha');
      return false;
    }
  }
}
