import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  static salvarConfigs(
    String contraste,
    bool acessibilidade,
    String tamanhoFonte,
    String idioma,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('contraste', contraste);
    await prefs.setBool('acessibilidade', acessibilidade);
    await prefs.setString('tamanhoFonte', tamanhoFonte);
    await prefs.setString('idioma', idioma);
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
