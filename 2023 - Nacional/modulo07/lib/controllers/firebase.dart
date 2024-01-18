import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modulo07/widgets/toast.dart';

class FirebaseController {
  static adicionarAvaliacao(String user, String local, String cidade,
      String comentario, int estrelas, File image, context) async {
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
        "status": "Em análise",
      });
      MyToast.gerarToast('Avaliação cadastrada com sucesso!');
      Navigator.pushNamed(context, '/listaAvaliacoes');
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

  static atualizarAvaliacao(
    String id,
    String user,
    String local,
    String cidade,
    String comentario,
    int estrelas,
    String image,
    String status,
    context,
  ) async {
    id = id.substring(id.indexOf(' ') + 1);

    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref(
        "avaliacoes/$id",
      );

      await ref.set({
        "id": "Avaliação $id",
        "user": user,
        "local": local,
        "cidade": cidade,
        "comentario": comentario,
        "estrelas": estrelas,
        "image": image,
        "status": status,
      });
      MyToast.gerarToast('Avaliação $status com sucesso!');
      Navigator.pushNamed(context, '/listaAvaliacoes');
    } catch (e) {
      MyToast.gerarToast('Erro ao atualizar avaliação!');
      print(e);
    }
  }

  static deletar(id) {
    try {
      id = id.substring(id.indexOf(' ') + 1);
      DatabaseReference ref = FirebaseDatabase.instance.ref("avaliacoes/$id");

      ref.remove();

      MyToast.gerarToast('Avaliação deletada com sucesso!');
    } catch (e) {
      MyToast.gerarToast('Erro ao deletar avaliação!');
    }
  }
}
