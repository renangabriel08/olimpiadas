import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  static salvarTamanho(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('tamanho', value);
  }

  static salvarTemam(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('tema', value);
  }

  static Future<String> getTamanho() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tamanho = prefs.getString('tamanho');

    return tamanho ?? 'M';
  }

  static Future<String> getTema() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tema = prefs.getString('tema');

    return tema ?? 'C';
  }
}
