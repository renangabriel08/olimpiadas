import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  static getIdioma() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idioma = prefs.getString('idioma');

    return idioma ?? 'pt';
  }

  static setIdioma(String idioma) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('idioma', idioma);
  }

  static getTema() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tema = prefs.getString('tema');

    return tema ?? 'c';
  }

  static setTema(String tema) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tema', tema);
  }

  static getTamanho() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tamanho = prefs.getString('tamanho');

    return tamanho ?? 'm';
  }

  static setTamanho(String tamanho) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('tamanho', tamanho);
  }
}
