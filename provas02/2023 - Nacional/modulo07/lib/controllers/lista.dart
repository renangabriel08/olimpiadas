import 'package:firebase_database/firebase_database.dart';

class ListaController {
  static Future<List> get() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('avaliacoes').get();
    if (snapshot.exists) {
      List data = snapshot.value as List;
      List data2 = [];

      for (var i in data) {
        if (i != null) {
          data2.add(i);
        }
      }

      return data2;
    } else {
      return [];
    }
  }

  static deletar(id) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = ref.child('avaliacoes/$id');
    snapshot.remove();
  }
}
