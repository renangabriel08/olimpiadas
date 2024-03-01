import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaController {
  static double latitude = -22.0676093;
  static double longitude = -50.2969931;
  static List pos = [];
  static Set<Marker> markers = {};

  static Timer? timer;
  static int s = 0;
  static int sF = 0;
  static bool started = false;

  static double op = 1.0;

  static addMarker(user) {
    markers.add(
      Marker(
        markerId: MarkerId(user['nome']),
        position: LatLng(user['latitude'], user['longitude']),
        infoWindow: InfoWindow(title: user['nome']),
        alpha: op,
      ),
    );
  }

  static start() {
    if (!started) {
      started = true;
      op = 1;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        s++;
        sF++;

        if (sF == 900) {
          op = 0;
          markers.clear();
          for (var userPos in pos) {
            MapaController.addMarker(userPos);
          }
        }

        if (op > .1) {
          if (s == 90) {
            op = op - .1;
            s = 0;
            markers.clear();
            for (var userPos in pos) {
              MapaController.addMarker(userPos);
            }
          }
        }
      });
    }
  }

  static cancel() {
    if (started) {
      timer!.cancel();
      s = 0;
      started = false;
    }
  }
}
