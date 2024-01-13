import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  static saveScores() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  static getScores() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  }
}
