import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo05/controllers/mapa.dart';
import 'package:modulo05/styles/styles.dart';
import 'package:modulo05/widgets/toast.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String end = '';
  bool loading = true;

  bool btn = false;
  bool corrida = false;
  List vs = [];
  bool v = false;

  Timer? timer;

  start() {
    if (corrida) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        MapaController.getPosition();
        MapaController.gerarRota(
          LatLng(MapaController.latitude, MapaController.longitude),
          MapaController.destino,
        );

        vs.clear();

        for (var i in MapaController.pontosTuristicos) {
          if (Geolocator.bearingBetween(
                  MapaController.latitude,
                  MapaController.longitude,
                  i['geometry']['location']['lat'],
                  i['geometry']['location']['lng']) <
              500) {
            vs.add(true);
          }
        }

        if (vs.contains(true)) {
          v = true;
        } else {
          v = false;
        }

        setState(() {});
      });
    }
  }

  cancel() {
    timer!.cancel();
  }

  @override
  void initState() {
    Future.wait([MapaController.getPosition()]).then(
      (value) => setState(() => loading = false),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: !loading
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Textos.txt2('Selecionar destino', Cores.verde3),
                    Container(height: height * .02),
                    TextFormField(
                      onChanged: (value) => end = value,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            await MapaController.pesquisar(end);
                            btn = true;
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.search,
                            color: Cores.verde3,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text(
                          'Pesquisar',
                          style: TextStyle(fontFamily: Fontes.fonte),
                        ),
                      ),
                    ),
                    Container(height: height * .05),
                    SizedBox(
                      width: width,
                      height: width * 1.3,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            MapaController.latitude,
                            MapaController.longitude,
                          ),
                          zoom: 17,
                        ),
                        markers: MapaController.markers,
                        polylines: MapaController.polylines,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                      ),
                    ),
                    Column(
                      children: [
                        Container(height: height * .05),
                        for (var ponto in MapaController.pontosTuristicos)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                            child: Container(
                              width: width,
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Cores.verde3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Textos.txt1(
                                          ponto['name'],
                                          Cores.azul2,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            MapaController
                                                .pontosTuristicosDeInteresse
                                                .add(ponto);
                                            MyToast.gerar('Ponto adicionado');
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            color: Cores.azul1,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                    Container(height: height * .05),
                    !corrida
                        ? OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              btn
                                  ? await MapaController.gerarNovaRota(end)
                                  : null;
                              setState(() {});
                            },
                            child: Textos.txt1('GERAR NOVA ROTA', Cores.verde3),
                          )
                        : Container(),
                    Container(height: height * .01),
                    !corrida
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              btn ? corrida = true : null;
                              start();
                            },
                            child: Textos.txt1('INICIAR VIAGEM', Cores.verde3),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              corrida = false;
                              MapaController.encerrarCorrida();
                              setState(() {});
                            },
                            child: Textos.txt1('ENCERRAR VIAGEM', Cores.verde3),
                          ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: Visibility(
        visible: v,
        child: FloatingActionButton(
          onPressed: () => (),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
