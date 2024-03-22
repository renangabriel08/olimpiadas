import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  static Future<bool?> getLog() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('log');
  }

  static Future setLog() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('log', true);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future setToken(String tkn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', tkn);
  }
}
