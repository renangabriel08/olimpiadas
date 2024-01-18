import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:modulo07/widgets/toast.dart';

class FirebaseController {
  static adicionarAvaliacao(
    String user,
    String local,
    String cidade,
    String comentario,
    int estrelas,
    File image,
  ) async {
    try {
      final itens = await getAvaliacoes();

      DatabaseReference ref = FirebaseDatabase.instance.ref(
        "avaliacoes/${itens.length + 1}",
      );

      await ref.set({
        "id": "Avaliação ${itens.length + 1}",
        "user": user,
        "local": local,
        "cidade": cidade,
        "comentario": comentario,
        "estrelas": estrelas,
        "image": image.path,
      });
      MyToast.gerarToast('Avaliação cadastrada com sucesso!');
    } catch (e) {
      MyToast.gerarToast('Erro ao cadastrar avaliação!');
      print(e);
    }
  }

  static getAvaliacoes() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('avaliacoes').get();
    if (snapshot.exists) {
      return (snapshot.value);
    } else {
      return [];
    }
  }
}
