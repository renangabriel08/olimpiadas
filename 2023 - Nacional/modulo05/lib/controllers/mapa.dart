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
  static List<LatLng> points = [];
  static List pontosTuristicos = [];
  static List pontosTuristicosDeInteresse = [];
  static List locPontosTuristicosDeInteresse = [];

  static Future getPosition() async {
    final Position pos = await posicaoAtual();

    latitude = pos.latitude;
    longitude = pos.longitude;
  }

  static pesquisar(String end) async {
    try {
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
        await buscarPontos();
      } else {
        print('deu ruim');
      }
    } catch (e) {
      print('Endereço não encontrado');
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

      polylines.add(
        Polyline(
          polylineId: PolylineId('${MapaController.points[0].latitude}'),
          points: MapaController.points,
          color: Cores.verde2,
          width: 4,
        ),
      );
    }
  }

  static buscarPontos() async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=1500&types=tourist_attraction&key=AIzaSyD5v_ENMQDCUKIb2o9q_PVhnGaAUaTfedk',
    );

    final req = await http.get(url);

    if (req.statusCode == 200) {
      final res = jsonDecode(utf8.decode(req.bodyBytes));
      pontosTuristicos = res['results'];
      print(pontosTuristicos);
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

  static gerarNovaRota(String end) async {
    polylines.clear();
    points.clear();
    end = end.replaceAll(' ', '-');
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?address=$end&key=AIzaSyD5v_ENMQDCUKIb2o9q_PVhnGaAUaTfedk',
    );

    final req = await http.get(url);

    if (req.statusCode == 200) {
      final res = jsonDecode(utf8.decode(req.bodyBytes));
      double lat = res['results'][0]['geometry']['location']['lat'];
      double lng = res['results'][0]['geometry']['location']['lng'];

      locPontosTuristicosDeInteresse.add(LatLng(latitude, longitude));

      for (var pt in pontosTuristicosDeInteresse) {
        final lt = pt['geometry']['location']['lat'];
        final lg = pt['geometry']['location']['lng'];

        locPontosTuristicosDeInteresse.add(LatLng(lt, lg));
      }

      locPontosTuristicosDeInteresse.add(LatLng(lat, lng));

      for (int i = 0; i < locPontosTuristicosDeInteresse.length - 1; i++) {
        gerarRota(
          LatLng(
            locPontosTuristicosDeInteresse[i].latitude,
            locPontosTuristicosDeInteresse[i].longitude,
          ),
          LatLng(
            locPontosTuristicosDeInteresse[i + 1].latitude,
            locPontosTuristicosDeInteresse[i + 1].longitude,
          ),
        );
      }
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
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }
}
