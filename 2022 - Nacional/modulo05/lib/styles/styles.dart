import 'package:flutter/material.dart';

class Cores {
  static Color ciano = const Color(0xFF2ed9c3);
  static Color vermelho = const Color(0xFFff4438);
  static Color cinza = const Color(0xFF404041);
}

class Fontes {
  static String fonte = 'Montserrat';

  static getTamanhoFontePadrao(String tamanho) {
    var tamanhos = {
      'Normal': 15,
      'Médio': 15 * 1.5,
      'Grande': 15 * 2,
    };

    return tamanhos[tamanho];
  }

  static getTamanhoFonteSubtitulo(String tamanho) {
    var tamanhos = {
      'Normal': 18,
      'Médio': 18 * 1.5,
      'Grande': 18 * 2,
    };

    return tamanhos[tamanho];
  }

  static getTamanhoFonteTitulo(String tamanho) {
    var tamanhos = {
      'Normal': 22,
      'Médio': 22 * 1.5,
      'Grande': 22 * 2,
    };

    return tamanhos[tamanho];
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
        'Português',
        'Inglês',
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
        'Portuguese',
        'English',
        'Spanish',
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
        'Portugués',
        'Inglés',
        'Español',
        'Para volver'
      ],
    ];

    if (idioma == 'Portugês' || idioma == 'Portugués' || idioma == 'Portuguese') {
      return portugues;
    }
    if (idioma == 'Inglês' || idioma == 'English' || idioma == 'Inglés') {
      return ingles;
    }
    return espanhol;
  }
}
