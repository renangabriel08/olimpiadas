import 'package:shared_preferences/shared_preferences.dart';

class TamanhoController {
  static Future<String> getTamanho() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tamanho = prefs.getString('tamanho');

    return tamanho ?? 'M';
  }

  static setTamanho(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('tamanho', value);
  }
}
