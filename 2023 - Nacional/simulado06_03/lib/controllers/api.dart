import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:simulado06_03/controllers/mapa.dart';

class ApiController {
  static Future getUser() async {
    final url = Uri.parse('https://fredaugusto.com.br/simuladodrs/users/1');

    final req = await http.get(url);

    if (req.statusCode == 200) {
      final res = jsonDecode(utf8.decode(req.bodyBytes));
      return res;
    }
  }

  static Future getLocais() async {
    final url = Uri.parse('https://fredaugusto.com.br/simuladodrs/locais');

    final req = await http.get(url);

    if (req.statusCode == 200) {
      final res = jsonDecode(utf8.decode(req.bodyBytes));
      MapaController.markers.clear();

      for (var local in res) {
        MapaController.markers.add(
          Marker(
            markerId: MarkerId(local['id_local']),
            position: LatLng(
              double.parse(local['latitude_local']),
              double.parse(local['longitude_local']),
            ),
          ),
        );
      }

      return res;
    }
  }

  static Future pesquisar(end) async {
    final url = Uri.parse(
      'https://fredaugusto.com.br/simuladodrs/locais/busca/$end',
    );

    final req = await http.get(url);

    if (req.statusCode == 200) {
      final res = jsonDecode(utf8.decode(req.bodyBytes));
      return res;
    }
  }

  static Future getTemp() async {
    final url = Uri.parse(
      'https://brasilapi.com.br/api/cptec/v1/clima/previsao/4796',
    );

    final req = await http.get(url);

    if (req.statusCode == 200) {
      final res = jsonDecode(utf8.decode(req.bodyBytes));
      return res;
    }
  }
}
