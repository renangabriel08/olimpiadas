import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo05/controllers/mapa.dart';
import 'package:modulo05/styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String end = '';
  bool loading = true;

  bool btn = false;

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
                          icon: const Icon(
                            Icons.search,
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
                                          onPressed: () => MapaController
                                              .pontosTuristicosDeInteresse
                                              .add(ponto),
                                          icon: const Icon(Icons.add),
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
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        btn ? await MapaController.gerarNovaRota(end) : null;
                        setState(() {});
                      },
                      child: Textos.txt1('GERAR NOVA ROTA', Cores.verde3),
                    ),
                    Container(height: height * .01),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => btn ? print('oi') : null,
                      child: Textos.txt1('INICIAR VIAGEM', Cores.verde3),
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
