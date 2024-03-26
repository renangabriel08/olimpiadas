import 'package:modulo09/widgets/toast.dart';

class Validator {
  static validar(String value) {
    if (value.isEmpty) {
      MyToast.get('Todos os campos são obrigatórios!');
      return 'Cacmpo obrigatório';
    }
    return null;
  }
}
