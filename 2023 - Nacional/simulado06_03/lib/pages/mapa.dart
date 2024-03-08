// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simulado06_03/controllers/api.dart';
import 'package:simulado06_03/controllers/cache.dart';
import 'package:simulado06_03/controllers/mapa.dart';
import 'package:simulado06_03/styles/styles.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  Timer? timer;

  start() async {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      await MapaController.atualizarPosicao();
      setState(() {});
    });
  }

  bool loading = true;
  double size = 16;

  int min = 0;
  int max = 0;

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

    min = value[3]['clima'][0]['min'];
    max = value[3]['clima'][0]['max'];

    loading = false;

    setState(() {});

    MapaController.showModal(context);

    start();
  }

  @override
  void initState() {
    Future.wait([
      ApiController.getUser(),
      CacheController.getTamanho(),
      CacheController.getTema(),
      ApiController.getTemp(),
      MapaController.getPosition(context),
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
            : Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        MapaController.latitude,
                        MapaController.longitude,
                      ),
                    ),
                    markers: MapaController.markers,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/home'),
                          child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: bg,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: t2,
                                ),
                                Text(
                                  'Voltar',
                                  style: TextStyle(
                                    fontFamily: Fonts.font,
                                    fontSize: size,
                                    color: t2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 170,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: bg,
                          ),
                          child: Center(
                            child: Text(
                              'min: $min | max: $max',
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                fontSize: size,
                                color: t1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
