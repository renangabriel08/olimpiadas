import 'package:shared_preferences/shared_preferences.dart';

class Palavras {
  static List<String> p = [
    'Configurações',
    'Região e idioma',
    'Idioma',
    'Português',
    'Inglês',
    'Espanhol',
    'Contraste das telas',
    'Cores do tema',
    'Claro',
    'Escuro',
    'Daltonismo',
    'Desativado',
    'Ativado',
    'Tamanho do texto',
    'Pequeno',
    'Médio',
    'Grande',
    'Voltar',
    'O aplicativo revolucionário EuVouNaTrip oferece uma experiência de viagem incomparável',
    'Com recursos inovadores como gamificação de pontos turísticos, roteiros sob medida baseados nas suas preferências',
    'O EuVouNaTrip é o seu companheiro de viagem indispensável.',
    'Sobre'
  ];

  static List<String> i = [
    'Settings',
    'Region and language',
    'Language',
    'Portuguese',
    'English',
    'Spanish',
    'Contrast of screens',
    'Theme Colors',
    'Light',
    'Dark',
    'Color blindness',
    'Disabled',
    'Activated',
    'Text size',
    'Small',
    'Average',
    'Big',
    'To go back',
    'The revolutionary EuVouNaTrip app offers an unparalleled travel experience',
    'With innovative features such as gamification of tourist attractions, tailored itineraries based on your preferences',
    'EuVouNaTrip is your indispensable travel companion.'
        'About'
  ];

  static List<String> e = [
    'Ajustes',
    'Región e idioma',
    'Idioma',
    'Portugués',
    'Inglés',
    'Español',
    'Contraste de pantallas',
    'Colores del tema',
    'Claro',
    'Oscuro',
    'Daltonismo',
    'Desactivado',
    'Activado',
    'Tamano del texto',
    'Pequeño',
    'Promedio',
    'Grande',
    'Para volver',
    'La revolucionaria aplicación EuVouNaTrip ofrece una experiencia de viaje incomparable',
    'Con características innovadoras como gamificación de atracciones turísticas, itinerarios personalizados según tus preferencias',
    'EuVouNaTrip es su compañero de viaje indispensable.'
        'Acerca de'
  ];
}

class IdiomaController {
  static Future<String> getIdioma() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? idioma = prefs.getString('idioma');

    return idioma ?? 'P';
  }

  static setIdioma(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('idioma', value);
  }

  static returnPalavras() async {
    String v = await getIdioma();
    if (v == 'P') {
      return Palavras.p;
    } else if (v == 'E') {
      return Palavras.e;
    }
    return Palavras.i;
  }
}
