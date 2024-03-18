import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  static salvarContraste(String contraste) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('contraste', contraste);
  }

  static salvarIdioma(String idioma) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('idioma', idioma);
  }

  static salvarTamanhoFonte(String tamanhoFonte) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('tamanhoFonte', tamanhoFonte);
  }

  static salvarAcessibilidade(bool acessibilidade) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('acessibilidade', acessibilidade);
  }

  static Future<List> getConfigs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? contraste = prefs.getString('contraste');
    bool? acessibilidade = prefs.getBool('acessibilidade');
    String? tamanhoFonte = prefs.getString('tamanhoFonte');
    String? idioma = prefs.getString('idioma');

    return [contraste, acessibilidade, tamanhoFonte, idioma];
  }
}
