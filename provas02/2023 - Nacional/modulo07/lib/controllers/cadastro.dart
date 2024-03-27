import 'package:firebase_database/firebase_database.dart';

class CadastroController {
  static Future<int> getId() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('avaliacoes').get();
    if (snapshot.exists) {
      List data = snapshot.value as List;
      return data[data.length - 1]['id'] + 1;
    } else {
      return 0;
    }
  }

  static cadastrar(
    String user,
    String local,
    String cidade,
    String coment,
    int avaliacao,
    String data,
    String status,
    String img,
  ) async {
    int id = await getId();

    DatabaseReference ref = FirebaseDatabase.instance.ref("avaliacoes/$id");

    await ref.set({
      "id": id,
      "img": img,
      "user": user,
      "local": local,
      "cidade": cidade,
      "coment": coment,
      "avaliacao": avaliacao,
      "data": data,
      "status": status,
    });
  }
}
