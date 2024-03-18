import 'package:modulo01/widgets/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static salvarEvento(Map evento) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      int? id = prefs.getInt('id');

      id == null ? id = 0 : null;

      if (id == 0) {
        await prefs.setInt('id', id + 1);

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
        //Pegando eventos já cadastrados para verificação
        List<Map> eventos = await getEventos();

        //Verificando se evento já existe
        for (int i = 0; i < eventos.length; i++) {
          String comparar =
              '${evento['titulo']}${evento['data']}${evento['horario']}${evento['desc']}${evento['participantes']}${evento['local']}${eventos[i]['chave']}';
          String comparar2 =
              '${eventos[i]['titulo']}${eventos[i]['data']}${eventos[i]['horario']}${eventos[i]['desc']}${eventos[i]['participantes']}${eventos[i]['local']}${eventos[i]['chave']}';

          if (comparar == comparar2) {
            MyToast.gerarToast('Evento já adicionado');
            return;
          }
        }

        //Adicionando evento
        await prefs.setInt('id', id + 1);
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

        //Resposta
        MyToast.gerarToast('Evento adicionado aos desejos');
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao adicionar aos desejos');
    }
  }

  static getEventos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('id');
    List<Map> eventos = [];

    if (id == null) {
      return eventos;
    }

    for (int i = 0; i < id; i++) {
      List<String>? dados = prefs.getStringList('evento$i');
      if (dados != null) {
        eventos.add({
          "titulo": dados[0],
          "data": dados[1],
          "horario": dados[2],
          "desc": dados[3],
          "participantes": dados[4],
          "local": dados[5],
          "chave": dados[6]
        });
      }
    }

    return eventos;
  }

  static deletarEventos(Map evento) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.remove(evento['chave']);

      MyToast.gerarToast('Evento removido com sucesso');
    } catch (e) {
      MyToast.gerarToast('Erro ao remover evento');
    }
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