import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapaController {
  static double latitude = 0.0;
  static double longitude = 0.0;
  static Set<Marker> markers = {};
  static List<LatLng> points = [];

  static Future getPosition() async {
    final Position pos = await posicaoAtual();

    latitude = pos.latitude;
    longitude = pos.longitude;
  }

  static pesquisar(String end) async {
    end = end.replaceAll(' ', '-');
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?address=$end&key=AIzaSyD5v_ENMQDCUKIb2o9q_PVhnGaAUaTfedk',
    );

    final req = await http.get(url);

    if (req.statusCode == 200) {
      final res = jsonDecode(utf8.decode(req.bodyBytes));
      double lat = res['results'][0]['geometry']['location']['lat'];
      double lng = res['results'][0]['geometry']['location']['lng'];
      String id = res['results'][0]['formatted_address'];
      markers.clear();
      points.clear();
      await adicionarMarker(lat, lng, id);
      await gerarRota(LatLng(latitude, longitude), LatLng(lat, lng));
    }
  }

  static gerarRota(LatLng o, LatLng d) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json?destination=${d.latitude},${d.longitude}&origin=${o.latitude},${o.longitude}&key=AIzaSyD5v_ENMQDCUKIb2o9q_PVhnGaAUaTfedk',
    );

    final req = await http.get(url);

    if (req.statusCode == 200) {
      final res = jsonDecode(utf8.decode(req.bodyBytes));
      List pontos = res['routes'][0]['legs'][0]['steps'];

      for (var ponto in pontos) {
        final lt = ponto['end_location']['lat'];
        final lg = ponto['end_location']['lng'];

        adicionarPolylines(LatLng(lt, lg));
      }
    }
  }

  static adicionarPolylines(LatLng point) {
    points.add(point);
  }

  static adicionarMarker(double latitude, double longitude, String id) {
    markers.add(
      Marker(
        markerId: MarkerId(id),
        position: LatLng(latitude, longitude),
      ),
    );
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
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }
}
