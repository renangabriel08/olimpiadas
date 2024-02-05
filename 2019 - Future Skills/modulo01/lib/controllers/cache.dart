import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  static salvarLogin(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static salvarUser(String user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
  }

  static Future<String> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user = prefs.getString('user');

    return user ?? '';
  }
}
