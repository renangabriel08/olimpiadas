import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simulado06_03/controllers/api.dart';

class MapaController {
  static double latitude = 0.0;
  static double longitude = 0.0;
  static Set<Marker> markers = {};
  static dynamic idLocal = 0;
  static List locais = [];

  static Future getPosition(context) async {
    final pos = await posicaoAtual();

    latitude = pos.latitude;
    longitude = pos.longitude;

    await ApiController.getLocais(context);
  }

  static Future atualizarPosicao() async {
    final pos = await posicaoAtual();

    latitude = pos.latitude;
    longitude = pos.longitude;
  }

  static Future adicionarDistancias() async {
    for (var local in MapaController.locais) {
      local['distancia'] = await MapaController.getDistancia(LatLng(
        double.parse(local['latitude_local']),
        double.parse(local['longitude_local']),
      ));
    }
  }

  static Future<Position> posicaoAtual() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<String> getDistancia(LatLng d) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json?destination=${d.latitude},${d.longitude}&origin=$latitude,$longitude&key=AIzaSyD5v_ENMQDCUKIb2o9q_PVhnGaAUaTfedk',
    );

    final req = await http.get(url);

    if (req.statusCode == 200) {
      final res = jsonDecode(utf8.decode(req.bodyBytes));
      if (res['status'] == 'ZERO_RESULTS') {
        return 'Sem dados';
      }
      return res['routes'][0]['legs'][0]['distance']['text'];
    }
    return 'Erro';
  }

  static Future<void> showModal(context) async {
    Map local = await ApiController.getLocal(MapaController.idLocal) as Map;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(local['nome_local']),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(local['tipo_local']),
                Text(local['descricao_local']),
                Text(local['endereco_local']),
                Text(local['avaliacao_local']),
                Text(local['distancia']),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
