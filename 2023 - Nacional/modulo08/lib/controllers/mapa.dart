import 'package:geolocator/geolocator.dart';

class MapaController {
  static double latitude = 0.0;
  static double longitude = 0.0;

  static getPosition() async {
    final pos = await posicaoAtual();

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

  static calcularDistancia(lat1, lng1, lat2, lng2) {
    double distanceInMeters = Geolocator.distanceBetween(
      lat1,
      lng1,
      lat2,
      lng2,
    );

    print(distanceInMeters);

    return distanceInMeters;
  }
}
