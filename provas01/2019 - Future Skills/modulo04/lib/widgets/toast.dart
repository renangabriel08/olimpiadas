import 'package:fluttertoast/fluttertoast.dart';
import 'package:modulo04/styles/styles.dart';

class MyToast {
  static gerarToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Cores.vermelho,
      textColor: Cores.branco,
      fontSize: 16.0,
    );
  }
}
