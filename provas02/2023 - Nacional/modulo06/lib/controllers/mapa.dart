import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapaController {
  static double latitude = 0.0;
  static double longitude = 0.0;

  static LatLng locLocal = const LatLng(0, 0);
  static List<Map> locaisProximos = [];

  static Set<Marker> markers = {};

  static Future getPosition() async {
    final Position pos = await posicaoAtual();

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

  static buscarLocal(String local) async {
    String end = local.replaceAll(' ', '+');

    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$end&key=AIzaSyD5v_ENMQDCUKIb2o9q_PVhnGaAUaTfedk',
      );

      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));

        double lat = res['results'][0]['geometry']['location']['lat'];
        double lng = res['results'][0]['geometry']['location']['lng'];

        locLocal = LatLng(lat, lng);

        addMarker('Pesquisa', locLocal);
      }
    } catch (e) {}
  }

  static buscarLugaresProximos() async {
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=500&types=bar&key=AIzaSyD5v_ENMQDCUKIb2o9q_PVhnGaAUaTfedk',
      );

      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        print('locaisProximos');

        for (var local in res['results']) {
          LatLng pos = LatLng(
            local['geometry']['location']['lat'],
            local['geometry']['location']['lng'],
          );
          double dis = getDistancia(pos);

          locaisProximos.add({
            'nome': local['name'],
            'end': local['vicinity'],
            'dis': dis,
            'img': local['photos']['photo_reference'],
            'loc': pos,
            'check': dis <= 500,
          });
        }

        print(locaisProximos);
        print('locaisProximos');
      }
    } catch (e) {}
  }

  static getDistancia(LatLng d) {
    double dis = Geolocator.distanceBetween(
      latitude,
      longitude,
      d.latitude,
      d.longitude,
    );

    return dis;
  }

  static addMarker(String id, LatLng loc) {
    markers.add(
      Marker(
        markerId: MarkerId(id),
        position: loc,
      ),
    );
  }
}
