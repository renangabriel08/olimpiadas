import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  static salvarLogin(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}