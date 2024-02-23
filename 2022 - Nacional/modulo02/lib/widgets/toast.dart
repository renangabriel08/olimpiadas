import 'package:fluttertoast/fluttertoast.dart';
import 'package:modulo02/styles/styles.dart';

class MyToast {
  static gerar(String txt) {
    Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Cores.vermelho,
      textColor: Cores.branco,
      fontSize: 16.0,
    );
  }
}
