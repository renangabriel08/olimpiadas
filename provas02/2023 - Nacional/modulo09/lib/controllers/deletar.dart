import 'package:http/http.dart' as http;
import 'package:modulo09/widgets/toast.dart';

class DeletarController {
  static deletar(id) async {
    try {
      final url = Uri.parse(
        'https://apieuvounatrip.azurewebsites.net/api/Reclamacoes/$id',
      );
      final req = await http.delete(url);

      if (req.statusCode == 204) {
        MyToast.get('Reclamação deletada com sucesso!');
      }
    } catch (e) {
      print('erro $e');
    }
  }
}
