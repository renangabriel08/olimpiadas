import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static Map configPadrao = {
    'tipoPartida': 'Por tempo',
    'tempoPartida': '30',
    'tempoPalavra': '3000',
    'cores': [
      {'cor': 'Amarelo', 'check': true},
      {'cor': 'Verde', 'check': true},
      {'cor': 'Azul', 'check': true},
      {'cor': 'Vermelho', 'check': true},
      {'cor': 'Roxo', 'check': true},
      {'cor': 'Laranja', 'check': true},
      {'cor': 'Preto', 'check': true},
    ]
  };

  static salvarConfigs(
    String tipoPartida,
    String tempoPartida,
    String tempoPalavra,
    List<Map> cores,
  ) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String> configs = [
        tipoPartida,
        tempoPartida,
        tempoPalavra,
      ];

      for (int i = 0; i < cores.length; i++) {
        configs.add(cores[i]['check'].toString());
      }

      await prefs.setStringList('configs', configs);
    } catch (e) {
      print(e);
    }
  }

  static getConfigs() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? configs = prefs.getStringList('configs');

      if (configs != null) {
        Map configsFormatadas = {
          'tipoPartida': configs[0],
          'tempoPartida': configs[1],
          'tempoPalavra': configs[2],
          'cores': [
            {'cor': 'Amarelo', 'check': configs[3] == 'false' ? false : true},
            {'cor': 'Verde', 'check': configs[4] == 'false' ? false : true},
            {'cor': 'Azul', 'check': configs[5] == 'false' ? false : true},
            {'cor': 'Vermelho', 'check': configs[6] == 'false' ? false : true},
            {'cor': 'Roxo', 'check': configs[7] == 'false' ? false : true},
            {'cor': 'Laranja', 'check': configs[8] == 'false' ? false : true},
            {'cor': 'Preto', 'check': configs[9] == 'false' ? false : true},
          ]
        };

        return configsFormatadas;
      } else {
        return configPadrao;
      }
    } catch (e) {
      print(e);
    }
  }

  //Formatar dados
  static dateTimeToString() {}
  static stringToDateTime() {}
}
