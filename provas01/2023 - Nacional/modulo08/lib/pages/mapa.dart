import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo8/controllers/api.dart';
import 'package:modulo8/controllers/mapa.dart';
import 'package:modulo8/styles/styles.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Textos.txt2('Ofertas', Cores.azul1),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: FutureBuilder(
          future: Future.wait(
            [ApiCOntroller.getUsers(), ApiCOntroller.getData()],
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List users = snapshot.data![0] as List;
              List locais = snapshot.data![1] as List;
              Set<Marker> markers = {};

              for (var user in users) {
                if (user['latitude'] != null && user['longitude'] != null) {
                  final dis = MapaController.calcularDistancia(
                    MapaController.latitude,
                    MapaController.longitude,
                    double.parse(user['latitude']),
                    double.parse(user['longitude']),
                  );

                  if (dis < 2000) {
                    markers.add(
                      Marker(
                        markerId: MarkerId(user['nome']),
                        position: LatLng(
                          double.parse(user['latitude']),
                          double.parse(user['longitude']),
                        ),
                        infoWindow: InfoWindow(title: user['nome']),
                      ),
                    );
                  }
                }
              }

              for (var local in locais) {
                if (local['latitude'] != 'string') {
                  final dis = MapaController.calcularDistancia(
                    MapaController.latitude,
                    MapaController.longitude,
                    double.parse(local['latitude']),
                    double.parse(local['longitude']),
                  );

                  if (dis < 2000) {
                    markers.add(
                      Marker(
                        markerId: MarkerId(local['nomeLocal']),
                        position: LatLng(
                          double.parse(local['latitude']),
                          double.parse(local['longitude']),
                        ),
                        infoWindow: InfoWindow(title: local['nomeLocal']),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueAzure,
                        ),
                      ),
                    );
                  }
                }
              }

              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: width,
                        height: width,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              MapaController.latitude,
                              MapaController.longitude,
                            ),
                            zoom: 17,
                          ),
                          markers: markers,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          zoomControlsEnabled: true,
                        ),
                      ),
                      Container(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Textos.txt2('Recomendados', Cores.azul1),
                        ],
                      ),
                      Container(height: 10),
                      FutureBuilder(
                        future: ApiCOntroller.getData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List data = snapshot.data as List;
                            List locais = [];

                            for (var i in data) {
                              if (i['latitude'] != 'string') {
                                locais.add(i);
                              }
                            }

                            return Column(
                              children: [
                                for (var local in locais)
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      7,
                                      0,
                                      7,
                                    ),
                                    child: Container(
                                      width: width,
                                      height: height * .15,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Cores.azul2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Textos.txt1(local['nomeLocal'],
                                                    Cores.azul1),
                                                Textos.txt1(
                                                  local['tipoLocal'],
                                                  Cores.azul1,
                                                ),
                                                Textos.txt1(
                                                  MapaController
                                                              .calcularDistancia(
                                                            MapaController
                                                                .latitude,
                                                            MapaController
                                                                .longitude,
                                                            double.parse(
                                                              local['latitude'],
                                                            ),
                                                            double.parse(
                                                              local[
                                                                  'longitude'],
                                                            ),
                                                          ) >
                                                          1000
                                                      ? '${(MapaController.calcularDistancia(
                                                            MapaController
                                                                .latitude,
                                                            MapaController
                                                                .longitude,
                                                            double.parse(
                                                              local['latitude'],
                                                            ),
                                                            double.parse(
                                                              local[
                                                                  'longitude'],
                                                            ),
                                                          ) / 1000).toInt()} Km'
                                                      : '${(MapaController.calcularDistancia(
                                                          MapaController
                                                              .latitude,
                                                          MapaController
                                                              .longitude,
                                                          double.parse(
                                                            local['latitude'],
                                                          ),
                                                          double.parse(
                                                            local['longitude'],
                                                          ),
                                                        )).toInt()} Metros',
                                                  Cores.azul1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    for (int i = 0;
                                                        i <
                                                            local['avaliacao']
                                                                .toInt();
                                                        i++)
                                                      const Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                        size: 13,
                                                      ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    local['custoMedio'] > 500
                                                        ? Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .attach_money_rounded,
                                                                size: 12,
                                                                color: Cores
                                                                    .verde3,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .attach_money_rounded,
                                                                size: 12,
                                                                color: Cores
                                                                    .verde3,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .attach_money_rounded,
                                                                size: 12,
                                                                color: Cores
                                                                    .verde3,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .attach_money_rounded,
                                                                size: 12,
                                                                color: Cores
                                                                    .verde3,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .attach_money_rounded,
                                                                size: 12,
                                                                color: Cores
                                                                    .verde3,
                                                              )
                                                            ],
                                                          )
                                                        : local['custoMedio'] >
                                                                400
                                                            ? Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .attach_money_rounded,
                                                                    size: 12,
                                                                    color: Cores
                                                                        .verde3,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .attach_money_rounded,
                                                                    size: 12,
                                                                    color: Cores
                                                                        .verde3,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .attach_money_rounded,
                                                                    size: 12,
                                                                    color: Cores
                                                                        .verde3,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .attach_money_rounded,
                                                                    size: 12,
                                                                    color: Cores
                                                                        .verde3,
                                                                  ),
                                                                ],
                                                              )
                                                            : local['custoMedio'] >
                                                                    400
                                                                ? Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .attach_money_rounded,
                                                                        size:
                                                                            12,
                                                                        color: Cores
                                                                            .verde3,
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .attach_money_rounded,
                                                                        size:
                                                                            12,
                                                                        color: Cores
                                                                            .verde3,
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .attach_money_rounded,
                                                                        size:
                                                                            12,
                                                                        color: Cores
                                                                            .verde3,
                                                                      ),
                                                                    ],
                                                                  )
                                                                : local['custoMedio'] >
                                                                        300
                                                                    ? Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.attach_money_rounded,
                                                                            size:
                                                                                12,
                                                                            color:
                                                                                Cores.verde3,
                                                                          ),
                                                                          Icon(
                                                                            Icons.attach_money_rounded,
                                                                            size:
                                                                                12,
                                                                            color:
                                                                                Cores.verde3,
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.attach_money_rounded,
                                                                            size:
                                                                                12,
                                                                            color:
                                                                                Cores.verde3,
                                                                          ),
                                                                        ],
                                                                      )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
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
