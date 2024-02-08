import 'package:fluttertoast/fluttertoast.dart';
import 'package:modulo03/styles/styles.dart';

class MyToast {
  static gerarToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Cores.vermelho,
      textColor: Cores.branco,
      fontSize: 16.0,
    );
  }
}
