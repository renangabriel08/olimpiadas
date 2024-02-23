import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo06/controllers/mapa.dart';
import 'package:modulo06/styles/styles.dart';

class Viajante extends StatefulWidget {
  const Viajante({super.key});

  @override
  State<Viajante> createState() => _ViajanteState();
}

class _ViajanteState extends State<Viajante> {
  String tipo = '';

  pesquisar() async {
    MapaController.lugares.clear();
    await MapaController.pesquisar(tipo);
    setState(() {});
  }

  Future<void> _showMyDialog(nome, end, loc) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(nome),
          content: SingleChildScrollView(
              child: Column(
            children: [
              Image.network(
                'https://i0.wp.com/www.sinhoresosasco.com.br/storage/2022/01/WhatsApp-Image-2022-01-28-at-17.08.45-1.jpeg',
              ),
              Textos.txt1(end, Cores.azul1),
            ],
          )),
          actions: <Widget>[
            TextButton(
              child: const Text('Rota'),
              onPressed: () async {
                await MapaController.rota(loc);
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          width: width,
          height: height,
          child: FutureBuilder(
            future: MapaController.init(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                double? latitude = snapshot.data?.latitude;
                double? longitude = snapshot.data?.longitude;

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * .5,
                              height: 50,
                              child: TextFormField(
                                onChanged: (value) => tipo = value,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  label: Textos.txt1('Pesquisar', Cores.azul1),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => pesquisar(),
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(width * .35, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Textos.txt1('Pesquisar', Cores.azul1),
                            ),
                          ],
                        ),
                        Container(height: 20),
                        SizedBox(
                          width: width,
                          height: width,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(latitude!, longitude!),
                              zoom: 17,
                            ),
                            markers: MapaController.markers,
                            polylines: {
                              Polyline(
                                polylineId: PolylineId('Rota'),
                                points: MapaController.points,
                                color: Cores.azul1,
                                width: 4,
                              ),
                            },
                          ),
                        ),
                        Container(height: 20),
                        Column(
                          children: [
                            for (var lugar in MapaController.lugares)
                              GestureDetector(
                                onTap: () => _showMyDialog(
                                  lugar['name'],
                                  lugar['vicinity'],
                                  LatLng(
                                    lugar['geometry']['location']['lat'],
                                    lugar['geometry']['location']['lng'],
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Container(
                                    width: width,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: Cores.azul1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Textos.txt1(
                                              lugar['name'], Cores.azul1)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
