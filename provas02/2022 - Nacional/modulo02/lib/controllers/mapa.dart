import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart';

class MapaController {
  static double latitudeInicial = 0.0;
  static double longitudeInicial = 0.0;

  static Future getPosition() async {
    final Position pos = await determinePosition();

    latitudeInicial = pos.latitude;
    longitudeInicial = pos.longitude;
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
}
