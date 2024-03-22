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
}
