import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo05/controllers/api.dart';
import 'package:modulo05/controllers/mapa.dart';
import 'package:modulo05/styles/styles.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  Timer? timer;

  start() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void initState() {
    start();
    MapaController.start();
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
        child: FutureBuilder(
          future: ApiController.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final Map res = snapshot.data as Map;
              final user = res['tv'];
              MapaController.pos = user['users'];

              return Row(
                children: [
                  SizedBox(
                    height: height,
                    width: width * .75,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          MapaController.latitude,
                          MapaController.longitude,
                        ),
                        zoom: 15,
                      ),
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      markers: MapaController.markers,
                    ),
                  ),
                  Container(
                    height: height,
                    width: width * .25,
                    decoration: BoxDecoration(
                      color: Cores.cinza,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        topLeft: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 123,
                            height: 123,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(width: 2, color: Cores.ciano),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(999),
                              child: Image.network(user['foto']),
                            ),
                          ),
                          Container(height: height * .02),
                          Textos.txt(
                            user['nome'],
                            20,
                            TextAlign.center,
                            Cores.ciano,
                            FontWeight.w700,
                          ),
                          Container(height: height * .02),
                          Container(
                            width: 84,
                            height: 34,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Cores.azul,
                            ),
                            child: Center(
                              child: Textos.txt(
                                'Seguir',
                                16,
                                TextAlign.center,
                                Cores.branco,
                                FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(height: height * .05),
                          Row(
                            children: [
                              Textos.txt(
                                'Desafio atual:',
                                14,
                                TextAlign.start,
                                const Color(0xFFD6E1E0),
                                FontWeight.w400,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Textos.txt(
                                user['desafio'],
                                20,
                                TextAlign.start,
                                const Color(0xFFD6E1E0),
                                FontWeight.w700,
                              ),
                            ],
                          ),
                          Container(height: height * .05),
                          Column(
                            children: [
                              for (var i in user['metas'])
                                Row(
                                  children: [
                                    Textos.txt(
                                      i,
                                      16,
                                      TextAlign.start,
                                      const Color(0xFFD6E1E0),
                                      FontWeight.w400,
                                    ),
                                  ],
                                )
                            ],
                          ),
                          Container(height: height * .12),
                          GestureDetector(
                            onTap: () {
                              MapaController.cancel();
                              Navigator.pushNamed(
                                context,
                                '/loginTv',
                              );
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Cores.vermelho,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  color: Cores.cinza,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
