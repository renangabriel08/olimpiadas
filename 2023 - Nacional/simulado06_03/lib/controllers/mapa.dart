import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simulado06_03/controllers/api.dart';

class MapaController {
  static double latitude = 0.0;
  static double longitude = 0.0;
  static Set<Marker> markers = {};

  static Future getPosition() async {
    final pos = await posicaoAtual();

    await ApiController.getLocais();

    latitude = pos.latitude;
    longitude = pos.longitude;
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
      return 'opa';
    }
    return '2KM';
  }
}
