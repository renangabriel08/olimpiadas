import 'package:http/http.dart' as http;
import 'package:modulo01/main.dart';
import 'package:modulo01/widgets/toast.dart';

class PrimeiroAcessoController {
  static List<Map> data = [
    {
      'exercicio': 'Caminhada',
      'value': false,
      'hora': 'Horário',
      'dias': [
        {
          'dia': 'D',
          'value': false,
        },
        {
          'dia': 'S',
          'value': false,
        },
        {
          'dia': 'T',
          'value': false,
        },
        {
          'dia': 'Q',
          'value': false,
        },
        {
          'dia': 'Q',
          'value': false,
        },
        {
          'dia': 'S',
          'value': false,
        },
        {
          'dia': 'S',
          'value': false,
        },
      ],
    },
    {
      'exercicio': 'Corrida',
      'value': false,
      'hora': 'Horário',
      'dias': [
        {
          'dia': 'D',
          'value': false,
        },
        {
          'dia': 'S',
          'value': false,
        },
        {
          'dia': 'T',
          'value': false,
        },
        {
          'dia': 'Q',
          'value': false,
        },
        {
          'dia': 'Q',
          'value': false,
        },
        {
          'dia': 'S',
          'value': false,
        },
        {
          'dia': 'S',
          'value': false,
        },
      ],
    },
    {
      'exercicio': 'Pular Corda',
      'value': false,
      'hora': 'Horário',
      'dias': [
        {
          'dia': 'D',
          'value': false,
        },
        {
          'dia': 'S',
          'value': false,
        },
        {
          'dia': 'T',
          'value': false,
        },
        {
          'dia': 'Q',
          'value': false,
        },
        {
          'dia': 'Q',
          'value': false,
        },
        {
          'dia': 'S',
          'value': false,
        },
        {
          'dia': 'S',
          'value': false,
        },
      ],
    }
  ];

  static atualizar(token, peso, altura, nascimento) async {
    try {
      final url = Uri.parse('http://10.91.236.150:3000/tp01/usuarios');

      final req = await http.put(
        url,
        headers: {'AUTHORIZATION': 'Bearer $token'},
        body: {
          "peso": peso.toString(),
          "altura": altura.toString(),
          "dt_nascimento": nascimento
        },
      );

      if (req.statusCode == 200) {
        MyToast.get('Salvo com sucesso');
        navKey.currentState!.pushNamed('/home');
      } else {
        MyToast.get('Erro ao atualizar');
        print(req.statusCode);
      }
    } catch (e) {
      MyToast.get('Erro ao atualizar');
      print('erro $e');
    }
  }
}
