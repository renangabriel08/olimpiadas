import 'package:shared_preferences/shared_preferences.dart';

class TemaController {
  static Future<String> getTema() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tema = prefs.getString('tema');

    return tema ?? 'C';
  }

  static setTema(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('tema', value);
  }

  static Future<String> getDaltonico() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? daltonico = prefs.getString('daltonico');

    return daltonico ?? 'D';
  }

  static setDaltonico(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('daltonico', value);
  }
}
