import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simulado06_03/controllers/api.dart';
import 'package:simulado06_03/controllers/cache.dart';
import 'package:simulado06_03/controllers/mapa.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  bool loading = true;
  double size = 16;

  Color t1 = const Color(0xFF00E1C2);
  Color t2 = const Color(0xFF2C2C2D);
  Color t3 = const Color(0xFFE10051);
  Color bg = const Color(0xFFFFFFFF);

  setar(value) {
    if (value[1] == 'P') {
      size = 14;
    } else if (value[1] == 'M') {
      size = 16;
    } else {
      size = 18;
    }

    if (value[2] == 'C') {
      t1 = const Color(0xFF00E1C2);
      t2 = const Color(0xFF2C2C2D);
      t3 = const Color(0xFFE10051);
      bg = const Color(0xFFFFFFFF);
    } else {
      t1 = const Color(0xFFFFFFFF);
      t2 = const Color(0xFFFFFFFF);
      t3 = const Color(0xFFFFFFFF);
      bg = const Color(0xFF2C2C2D);
    }

    loading = false;

    setState(() {});
  }

  @override
  void initState() {
    Future.wait([
      ApiController.getUser(),
      CacheController.getTamanho(),
      CacheController.getTema(),
      MapaController.getPosition(),
    ]).then((value) => setar(value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    MapaController.latitude,
                    MapaController.longitude,
                  ),
                ),
                markers: MapaController.markers,
              ),
      ),
    );
  }
}
