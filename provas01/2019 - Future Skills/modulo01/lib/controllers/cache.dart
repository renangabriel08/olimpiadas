import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  static salvarLogs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('logs', 1);
  }

  static Future<int>getLogs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? logs = prefs.getInt('logs');

    return logs ?? 0;
  }

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

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    return token ?? '';
  }

  static logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('token');
  }
}
