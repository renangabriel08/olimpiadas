import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  static saveScores(String time, String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? id = prefs.getInt('id');
    id ??= 0;

    await prefs.setStringList('score${id + 1}', ['score${id + 1}', data, time]);
    await prefs.setInt('id', id + 1);
  }

  static getScores() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List scores = [];

    int? id = prefs.getInt('id');
    id ??= 0;

    for (int i = 0; i < id + 1; i++) {
      if (prefs.getStringList('score$i') != null) {
        scores.add(prefs.getStringList('score$i'));
      }
    }

    return scores;
  }

  static ordenarScores() async {
    List scores = await getScores();

    if (scores.isNotEmpty) {
      scores.sort((a, b) => a[2].compareTo(b[2]));
    }

    return scores;
  }

  static saveUltimoScore(String time, String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('ultimoScore', [data, time]);
  }

  static getUltimoScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getStringList('ultimoScore');
  }
}


// int id = null || numero

// scoreX = [
//   'scoreX', -> Id
//   '10/01/2000', -> Data
//   '00:00:30', -> Tempo
// ];