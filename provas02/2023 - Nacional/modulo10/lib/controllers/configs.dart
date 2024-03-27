import 'package:modulo10/controllers/cache.dart';
import 'package:modulo10/controllers/idioma.dart';

class ConfigsController {
  static Future<List> getConfigs() async {
    final List idioma = await IdiomaController.getIdioma();
    final String tamanho = await CacheController.getTamanho();
    final String tema = await CacheController.getTema();

    return [idioma, tamanho, tema];
  }
}
