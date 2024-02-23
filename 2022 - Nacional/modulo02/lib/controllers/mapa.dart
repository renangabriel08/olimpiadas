import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo02/widgets/toast.dart';
import 'package:http/http.dart' as http;

class MapaController {
  static double latitude = 0.0;
  static double longitude = 0.0;

  static late StreamSubscription<Position> posAtual;

  static atualizarPos() async {
    posAtual = Geolocator.getPositionStream().listen((loc) {
      latitude = loc.latitude;
      longitude = loc.longitude;
    });
  }

  static stop() {
    posAtual.cancel();
  }

  static Future<Position> posicaoAtal() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      MyToast.gerar('Serviços de localização desativados');
      return Future.error('Serviços de localização desativados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        MyToast.gerar('As permissões de localização foram negadas');
        return Future.error('As permissões de localização foram negadas');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      MyToast.gerar(
        'As permissões de localização foram negadas permanentemente, não podemos solicitar permissões',
      );
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  static getDistancia(LatLng origem) async {
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?destination=$latitude,$longitude&origin=${origem.latitude},${origem.longitude}&key=AIzaSyD5v_ENMQDCUKIb2o9q_PVhnGaAUaTfedk',
      );

      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res['routes'][0]['legs'][0]['distance']['value'];
      }
    } catch (e) {
      MyToast.gerar('Erro ao realizar requisição');
    }
  }
}
