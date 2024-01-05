import 'package:flutter/material.dart';
import 'package:modulo04/controller/api.dart';

class Modais {
  static showMyDialogExluir(context, String titulo, String msg, id) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(titulo),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancelar'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Sim');
              ApiCntroller.deleteProdutos(id);
            },
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }

  static showMyDialogComprar(
      context, String titulo, String msg, id, preco) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(titulo),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancelar'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Sim');
              ApiCntroller.comprarProdutos(id, preco);
            },
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }
}
