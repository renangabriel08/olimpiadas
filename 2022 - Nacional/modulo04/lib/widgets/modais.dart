import 'package:flutter/material.dart';
import 'package:modulo04/controller/api.dart';
import 'package:modulo04/styles/styles.dart';

class Modais {
  static showMyDialogExluir(context, String titulo, String msg, id) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          titulo,
          style: TextStyle(
            fontFamily: Fontes.fonte,
            color: Cores.vermelho,
          ),
        ),
        content: Text(
          msg,
          style: TextStyle(
            fontFamily: Fontes.fonte,
            color: Cores.cinza,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancelar'),
            child: Text(
              'Cancelar',
              style: TextStyle(
                fontFamily: Fontes.fonte,
                color: Cores.cinza,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Sim');
              ApiCntroller.deleteProdutos(id);
            },
            child: Text(
              'Sim',
              style: TextStyle(
                fontFamily: Fontes.fonte,
                color: Cores.vermelho,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static showMyDialogComprar(
    context,
    String titulo,
    String msg,
    id,
    preco,
  ) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          titulo,
          style: TextStyle(
            fontFamily: Fontes.fonte,
            color: Cores.ciano,
          ),
        ),
        content: Text(
          msg,
          style: TextStyle(
            fontFamily: Fontes.fonte,
            color: Cores.cinza,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancelar'),
            child: Text(
              'Cancelar',
              style: TextStyle(
                fontFamily: Fontes.fonte,
                color: Cores.cinza,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Sim');
              ApiCntroller.comprarProdutos(id, preco);
            },
            child: Text(
              'Sim',
              style: TextStyle(
                fontFamily: Fontes.fonte,
                color: Cores.ciano,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static showMyDialogErroCadastrar(context, String titulo, String msg) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          titulo,
          style: TextStyle(
            fontFamily: Fontes.fonte,
            color: Cores.vermelho,
          ),
        ),
        content: Text(
          msg,
          style: TextStyle(
            fontFamily: Fontes.fonte,
            color: Cores.cinza,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Ok, Entendi');
            },
            child: Text(
              'Ok, Entendi',
              style: TextStyle(
                fontFamily: Fontes.fonte,
                color: Cores.vermelho,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static showMyDialogCadastrar(context, String titulo, String msg) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          titulo,
          style: TextStyle(
            fontFamily: Fontes.fonte,
            color: Cores.ciano,
          ),
        ),
        content: Text(
          msg,
          style: TextStyle(
            fontFamily: Fontes.fonte,
            color: Cores.cinza,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/produtos');
            },
            child: Text(
              'Ok',
              style: TextStyle(
                fontFamily: Fontes.fonte,
                color: Cores.ciano,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
