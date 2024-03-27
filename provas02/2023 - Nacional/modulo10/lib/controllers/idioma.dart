import 'package:modulo10/controllers/cache.dart';

class IdiomaController {
  static Future<List> getIdioma() async {
    String idioma = await CacheController.getIdioma();

    if (idioma == 'pt') {
      return pt;
    }
    if (idioma == 'es') {
      return es;
    }

    return en;
  }

  static List<String> pt = [
    'Sobre',
    'Configurações',
    'Região e idioma',
    'Idioma',
    'Português BR',
    'Inglês',
    'Espanhol',
    'Contraste das telas',
    'Cores do tema',
    'Claro',
    'Escuro',
    'Deutaronotopia',
    'Ativado',
    'Desativado',
    'Tamanho do texto',
    'Pequeno',
    'Medio',
    'Grande',
    'Voltar',
    'Em seguida são exibidos 3 parágrafos, onde o primeiro será apresentado juntamente com uma imagem em seu lado direito',
  ];

  static List<String> en = [
    'About',
    'Settings',
    'Region and language',
    'Language',
    'Portuguese BR',
    'English',
    'Spanish',
    'Contrast of screens',
    'Theme Colors',
    'Clear',
    'Dark',
    'Deutaronotopia',
    'Activated',
    'Disabled',
    'Text size',
    'Small',
    'Average',
    'Big',
    'To go back',
    'Next, 3 paragraphs are displayed, where the first will be presented together with an image on its right side',
  ];

  static List<String> es = [
    'Acerca de',
    'Ajustes',
    'Región e idioma',
    'Idioma',
    'BR portuguesa',
    'Inglés',
    'Español',
    'Contraste de pantallas',
    'Colores del tema',
    'Claro',
    'Oscuro',
    'Deutaronotopía',
    'Activado',
    'Desactivado',
    'Tamano del texto',
    'Pequeño',
    'Promedio',
    'Grande',
    'Para volver',
    'A continuación se muestran 3 párrafos, donde el primero se presentará junto con una imagen en su lado derecho',
  ];
}
