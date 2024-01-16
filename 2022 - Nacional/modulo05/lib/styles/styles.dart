import 'package:flutter/material.dart';

class Cores {
  static Color ciano = const Color(0xFF2ed9c3);
  static Color vermelho = const Color(0xFFff4438);
  static Color cinza = const Color(0xFF404041);
}

class Fontes {
  static String fonte = 'Montserrat';

  static getTamanhoFontePadrao(String tamanho) {
    Map<String, double> tamanhos = {
      'Normal': 15,
      'Médio': 15 * 1.5,
      'Grande': 15 * 2,
      'Promedio': 15 * 1.5,
      'Average': 15 * 1.5,
      'Big': 15 * 2,
    };

    return tamanhos[tamanho]!.toDouble();
  }

  static getTamanhoFonteSubtitulo(String tamanho) {
    Map<String, double> tamanhos = {
      'Normal': 18,
      'Médio': 18 * 1.5,
      'Grande': 18 * 2,
      'Promedio': 18 * 1.5,
      'Average': 18 * 1.5,
      'Big': 18 * 2,
    };

    return tamanhos[tamanho]!.toDouble();
  }

  static getTamanhoFonteTitulo(String tamanho) {
   Map<String, double> tamanhos = {
      'Normal': 22,
      'Médio': 22 * 1.5,
      'Grande': 22 * 2,
      'Promedio': 22 * 1.5,
      'Average': 22 * 1.5,
      'Big': 22 * 2,
    };

    return tamanhos[tamanho]!.toDouble();
  }
}

class Idiomas {
  static getIdioma(String idioma) {
    final portugues = [
      ['Home', 'Exercícios', 'WsCoin', 'Loja', 'Configurações', 'Sair'],
      [
        'Configurações de Acessibilidade',
        'Ajuste de contraste',
        'Padrão',
        'Daltônico',
        'Monocromático',
        'Escuro',
        'Menu de Acessibilidade',
        'Ativar menu de acessibilidade',
        'Tamanho da fonte',
        'Normal',
        'Médio',
        'Grande',
        'Idioma',
        'Portugues',
        'Ingles',
        'Espanhol',
        'Voltar'
      ],
    ];

    final ingles = [
      ['Home', 'Workouts', 'WsCoin', 'Store', 'Settings', 'Exit'],
      [
        'Accessibility Settings',
        'Contrast adjustment',
        'Standard',
        'Color blind',
        'Monochrome',
        'Dark',
        'Accessibility Menu',
        'Enable accessibility menu',
        'Font size',
        'Normal',
        'Average',
        'Big',
        'Language',
        'Portugues',
        'Ingles',
        'Espanhol',
        'To go back'
      ],
    ];

    final espanhol = [
      [
        'Inicio',
        'Entrenamientos',
        'WsCoin',
        'Tienda',
        'Configuración',
        'Salir'
      ],
      [
        'Configuración de accesibilidad',
        'Ajuste de contraste',
        'Estándar',
        'daltónico',
        'Monocromo',
        'Oscuro',
        'Menú de accesibilidad',
        'Habilitar menú de accesibilidad',
        'Tamaño de fuente',
        'Normal',
        'Promedio',
        'Grande',
        'Idioma',
        'Portugues',
        'Ingles',
        'Espanhol',
        'Para volver'
      ],
    ];

    if (idioma == 'Portugues' ||
        idioma == 'Portugués' ||
        idioma == 'Portuguese') {
      return portugues;
    }
    if (idioma == 'Ingles' || idioma == 'English' || idioma == 'Inglés') {
      return ingles;
    }
    return espanhol;
  }
}
