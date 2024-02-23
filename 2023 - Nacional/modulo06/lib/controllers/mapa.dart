import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapaController {
  static Set<Marker> markers = {};
  static double latitude = 0;
  static double longitude = 0;
  static List lugares = [];
  static List<LatLng> points = [];

  static Future<Position> init() async {
    final pos = await posicaoAtual();
    latitude = pos.latitude;
    longitude = pos.longitude;

    markers.add(
      Marker(
        markerId: const MarkerId('User'),
        position: LatLng(latitude, longitude),
      ),
    );

    return pos;
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

  static pesquisar(String tipo) async {
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${latitude},${longitude}&radius=2000&types=$tipo&key=AIzaSyD5v_ENMQDCUKIb2o9q_PVhnGaAUaTfedk',
      );
      final req = await http.get(url);
      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        List locais = res['results'];

        for (var local in locais) {
          lugares.add(local);

          print(
            Geolocator.bearingBetween(
                  latitude,
                  longitude,
                  local['geometry']['location']['lat'],
                  local['geometry']['location']['lng'],
                ) *
                -1 *
                5,
          );

          markers.add(
            Marker(
              markerId: MarkerId(local['name']),
              position: LatLng(
                local['geometry']['location']['lat'],
                local['geometry']['location']['lng'],
              ),
              infoWindow: InfoWindow(
                title: local['name'],
              ),
            ),
          );
        }
      }
    } catch (e) {}
  }

  static rota(LatLng d) async {
    points = [];
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?destination=${d.latitude},${d.longitude}&origin=${latitude},${longitude}&key=AIzaSyD5v_ENMQDCUKIb2o9q_PVhnGaAUaTfedk',
      );
      final req = await http.get(url);
      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        List p = res['routes'][0]['legs'][0]['steps'];

        for (var i in p) {
          points.add(
            LatLng(i['end_location']['lat'], i['end_location']['lng']),
          );
        }
      }
    } catch (e) {
      print('deu erro');
    }
  }
}
