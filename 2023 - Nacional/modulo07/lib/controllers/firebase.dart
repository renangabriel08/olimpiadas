import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modulo07/widgets/toast.dart';

class FirebaseController {
  static deletarAvaliacao(int id) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("avaliacoes/$id");

      ref.remove();
      MyToast.gerarToast('Avaliação deletada com sucesso!');
    } catch (e) {}
  }

  static atualizarAvaliacao(int id, String status, context) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("avaliacoes/$id");

      await ref.update({
        "status": status,
      });
      MyToast.gerarToast('Avaliação atualizada com sucesso!');
      Navigator.pushNamed(context, '/feedbacks');
    } catch (e) {
      MyToast.gerarToast('Erro ao atualizar avaliação!');
    }
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
      } else {
        List data = await formatarData();

        int ultimoId = data[data.length - 1]['id'];

        DatabaseReference ref = FirebaseDatabase.instance.ref(
          "avaliacoes/${ultimoId + 1}",
        );

        await ref.set({
          "id": ultimoId + 1,
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
    try {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('avaliacoes').get();
      if (snapshot.exists) {
        return snapshot.value;
      } else {
        return [];
      }
    } catch (e) {
      print('oi');
    }
  }

  static formatarData() async {
    final data = await getAvaliacoes();

    print(data);

    List dataFormatada = [];

    for (int i = 0; i < data.length; i++) {
      if (data[i] != null) {
        dataFormatada.add(data[i]);
      }
    }

    return dataFormatada;
  }
}
