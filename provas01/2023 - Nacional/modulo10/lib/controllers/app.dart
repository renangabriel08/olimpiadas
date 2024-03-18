import 'package:modulo10/controllers/idioma.dart';
import 'package:modulo10/controllers/tamanho.dart';
import 'package:modulo10/controllers/tema.dart';

class AppController {
  static getData() async {
    List palavras = await IdiomaController.returnPalavras();
    String tamanho = await TamanhoController.getTamanho();
    String tema = await TemaController.getTema();
    String daltonico = await TemaController.getDaltonico();

    return [palavras, tamanho, tema, daltonico];
  }
}
