import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:modulo05/styles/styles.dart';

class MapaController {
  static double latitude = 0.0;
  static double longitude = 0.0;

  static Set<Marker> markers = {};
  static Set<Polyline> polylines = {};

  static List steps = [];
  static List<LatLng> points = [];

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

  static pesquisar(String pesquisa) async {
    String end = pesquisa.replaceAll(' ', '+');

    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$end&key=AIzaSyD5v_ENMQDCUKIb2o9q_PVhnGaAUaTfedk',
      );
      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        final double lat = res['results'][0]['geometry']['location']['lat'];
        final double lng = res['results'][0]['geometry']['location']['lng'];

        await gerarRota(LatLng(lat, lng));
        addMarker('Destino', LatLng(lat, lng));
      }
    } catch (e) {
      print('object');
    }
  }

  static gerarRota(LatLng d) async {
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?destination=${d.latitude},${d.longitude}&origin=$latitude,$longitude&key=AIzaSyD5v_ENMQDCUKIb2o9q_PVhnGaAUaTfedk',
      );
      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        steps = res['routes'][0]['legs'][0]['steps'];

        for (var step in steps) {
          points.add(
            LatLng(
              step['start_location']['lat'],
              step['start_location']['lng'],
            ),
          );

          points.add(
            LatLng(
              step['end_location']['lat'],
              step['end_location']['lng'],
            ),
          );
        }

        addPolyline('Rota');
      }
    } catch (e) {
      print('object');
    }
  }

  static addMarker(String id, LatLng position) {
    markers.add(
      Marker(
        markerId: MarkerId(id),
        position: position,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  static addPolyline(String id) {
    polylines.add(
      Polyline(
        polylineId: PolylineId(id),
        color: Cores.azulEscuro,
        width: 4,
        points: points,
      ),
    );
  }
}
