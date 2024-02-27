import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  static Future salvarCidade(String cidade) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('cidade', cidade);
  }

  static Future salvarPreco(String preco) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('preco', preco);
  }

  static Future getCidade() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('cidade');
  }

  static Future getPreco() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('preco');
  }
}
