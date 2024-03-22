import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modulo01/styles/styles.dart';

class MyToast {
  static get(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Cores.vermelho,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
