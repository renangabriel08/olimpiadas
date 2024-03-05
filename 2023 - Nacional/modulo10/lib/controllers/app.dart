import 'package:modulo10/controllers/idioma.dart';
import 'package:modulo10/controllers/tamanho.dart';

class AppController {
  static getData() async {
    List palavras = await IdiomaController.returnPalavras();
    String tamanho = await TamanhoController.getTamanho();

    return [palavras, tamanho];
  }
}
