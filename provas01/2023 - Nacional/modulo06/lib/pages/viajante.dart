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

  checkIn() {}

  Future<void> _showMyDialog(nome, end, loc, img) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(nome),
          content: SingleChildScrollView(
              child: Column(
            children: [
              img != null
                  ? Image.network(
                      'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$img&key=AIzaSyD5v_ENMQDCUKIb2o9q_PVhnGaAUaTfedk',
                    )
                  : const Icon(
                      Icons.image,
                      size: 100,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/pontos'),
        child: const Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
      body: SizedBox(
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
                                polylineId: const PolylineId('Rota'),
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
                            for (int i = 0;
                                i < MapaController.lugares.length;
                                i++)
                              GestureDetector(
                                onTap: () => _showMyDialog(
                                  MapaController.lugares[i]['name'],
                                  MapaController.lugares[i]['vicinity'],
                                  LatLng(
                                    MapaController.lugares[i]['geometry']
                                        ['location']['lat'],
                                    MapaController.lugares[i]['geometry']
                                        ['location']['lng'],
                                  ),
                                  MapaController.lugares[i]['photos'] != null
                                      ? MapaController.lugares[i]['photos'][0]
                                          ['photo_reference']
                                      : null,
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
                                      padding: const EdgeInsets.fromLTRB(
                                        5,
                                        0,
                                        5,
                                        0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            MapaController.lugares[i]['name'],
                                            style: TextStyle(
                                              fontFamily: Fontes.fonte,
                                              fontSize: 14,
                                              color: Cores.azul2,
                                            ),
                                          ),
                                          MapaController.proximo[i]
                                              ? IconButton(
                                                  onPressed: () => checkIn(),
                                                  icon: Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 2,
                                                        color: Cores.verde3,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.check,
                                                        size: 20,
                                                        color: Cores.verde3,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
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
