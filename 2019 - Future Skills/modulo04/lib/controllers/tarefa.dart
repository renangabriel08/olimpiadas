import 'package:firebase_database/firebase_database.dart';
import 'package:modulo04/widgets/toast.dart';

class TarefaController {
  static update(int passos) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("user/");

      await ref.update({
        "passos": passos,
      });
      MyToast.gerarToast('Progresso salvo com sucesso!');
    } catch (e) {
      MyToast.gerarToast('Erro ao salvar progresso');
    }
  }
}
