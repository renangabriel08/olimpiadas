import 'package:modulo01/widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static salvarEvento(Map evento) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? id = prefs.getInt('id');

    id == null ? id = 0 : null;

    if (id == 0) {
      await prefs.setInt('id', id++);

      await prefs.setStringList(
        'evento$id',
        <String>[
          evento['titulo'].toString(),
          evento['data'].toString(),
          evento['horario'].toString(),
          evento['desc'].toString(),
          evento['participantes'].toString(),
          evento['local'].toString(),
          'evento$id'
        ],
      );
      MyToast.gerarToast('Evento adicionado aos desejos');
    } else {
      List<Map> eventos = await getEventos();

      for (int i = 0; i < eventos.length; i++) {
        Map comparar = {
          "titulo": evento['titulo'],
          "data": evento['data'],
          "horario": evento['horario'],
          "desc": evento['desc'],
          "participantes": int.parse(evento['participantes']),
          "local": evento['local'],
          "chave": eventos[i]['chave']
        };
        if (eventos[i] == comparar) {
          MyToast.gerarToast('Evento já adicionado');
        }
      }
    }
  }

  static getEventos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    List<Map> eventos = [];

    if (id == null) {
      return eventos;
    }

    for (int i = 1; i < id; i++) {
      List<String>? dados = prefs.getStringList('evento$id');
      eventos.add({
        "titulo": dados![0],
        "data": dados[1],
        "horario": dados[2],
        "desc": dados[3],
        "participantes": int.parse(dados[4]),
        "local": dados[5],
        "chave": dados[6]
      });
    }

    return eventos;
  }

  static deletarEventos(Map evento) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove(evento['chave']);
  }
}


// {
//     "titulo" : "Titulo teste",
//     "data" : "10/01/2024",
//     "horario" : "10:00",
//     "desc" : "Abc Descrição",
//     "participantes" : 10,
//     "local" : "CCI",
//     "chave" : "evento$id"
// },