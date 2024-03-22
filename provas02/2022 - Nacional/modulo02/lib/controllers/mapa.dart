import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo02/styles/styles.dart';
import 'package:http/http.dart' as http;

class MapaController {
  static double latitudeInicial = 0.0;
  static double longitudeInicial = 0.0;

  static double latitudeAtual = 0.0;
  static double longitudeAtual = 0.0;

  static double latitudeFinal = 0.0;
  static double longitudeFinal = 0.0;

  static Set<Polyline> polylines = {};
  static Set<Marker> markers = {};

  static List<LatLng> points = [];

  static Future getPosition() async {
    final Position pos = await determinePosition();

    latitudeInicial = pos.latitude;
    longitudeInicial = pos.longitude;
  }

  static Future atualizarPos() async {
    final Position pos = await determinePosition();

    latitudeAtual = pos.latitude;
    longitudeAtual = pos.longitude;
  }

  static Future<Position> determinePosition() async {
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

  static getRota() async {
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?destination=$latitudeAtual,$longitudeAtual&origin=$latitudeInicial,$longitudeInicial&key=AIzaSyD5v_ENMQDCUKIb2o9q_PVhnGaAUaTfedk',
      );
      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
      }
    } catch (e) {}
  }

  static getDistance() async {
    await MapaController.atualizarPos();
    addPoints(LatLng(latitudeAtual, longitudeAtual));

    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?destination=$latitudeAtual,$longitudeAtual&origin=$latitudeInicial,$longitudeInicial&key=AIzaSyD5v_ENMQDCUKIb2o9q_PVhnGaAUaTfedk',
      );
      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));

        String dis =
            '${res['routes'][0]['legs'][0]['distance']['value'] / 100}KM';

        return dis;
      }
      return '00KM';
    } catch (e) {
      return '00KM';
    }
  }

  static addMarker(String id, LatLng position) async {
    markers.add(
      Marker(
        markerId: MarkerId(id),
        position: position,
      ),
    );
  }

  static addRoute() async {
    polylines.add(
      Polyline(
        polylineId: PolylineId('Percurso'),
        points: points,
        width: 4,
        color: Cores.ciano,
      ),
    );
  }

  static addPoints(LatLng point) {
    points.add(point);
  }
}
