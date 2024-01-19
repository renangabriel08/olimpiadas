import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modulo07/widgets/toast.dart';

class FirebaseController {
  static deletarAvaliacao() async {}

  static atualizarAvaliacao(int id, String status) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("avaliacoes/$id");

    await ref.update({
      "status": status,
    });
  }

  static criarAvaliacao(
    String nome,
    String local,
    String cidade,
    File image,
    String comentario,
    int estrelas,
    context,
  ) async {
    try {
      final data = await formatarData();
      int id = data.length;

      if (id == 0) {
        DatabaseReference ref = FirebaseDatabase.instance.ref("avaliacoes/$id");

        await ref.set({
          "id": id,
          "nome": nome,
          "local": local,
          "cidade": cidade,
          "image": image.path,
          "comentario": comentario,
          "estrelas": estrelas,
          "data":
              '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
          "status": "Aguardando"
        });
        MyToast.gerarToast('Avaliação enviada com sucesso!');
        Navigator.pushNamed(context, '/feedbacks');
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao enviar avaliação!');
    }
  }

  static getAvaliacoes() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('avaliacoes').get();
    if (snapshot.exists) {
      print(snapshot.value);
      return snapshot.value;
    } else {
      return [];
    }
  }

  static formatarData() async {
    final data = await getAvaliacoes();

    return data;
  }
}
