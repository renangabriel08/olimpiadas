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
  bool loading = true;
  bool btn = false;
  bool rota = false;

  String pesquisa = '';
  pesquisar() async {
    MapaController.markers.clear();
    MapaController.polylines.clear();
    await MapaController.pesquisar(pesquisa);
    btn = true;
    Future.delayed(const Duration(seconds: 2));
    setState(() {});
  }

  iniciar() {}

  adicionarPonto(Map ponto) async {
    rota = true;
    MapaController.pontosRota.add(ponto);

    setState(() {});
  }

  setar() {
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([MapaController.getPosition()]).then((value) => setar());
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
        child: !loading
            ? Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Textos.subtitulo(
                        'Selecionar destino',
                        TextAlign.center,
                        Cores.verdeEscuro,
                      ),
                      Container(height: 40),
                      TextFormField(
                        onChanged: (value) => pesquisa = value,
                        style: TextStyle(fontFamily: Fonts.font),
                        decoration: InputDecoration(
                          labelText: 'Pesquisar',
                          labelStyle: TextStyle(fontFamily: Fonts.font),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => pesquisar(),
                            icon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                      Container(height: 20),
                      SizedBox(
                        width: width,
                        height: height * .6,
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
                      Container(height: 20),
                      Column(
                        children: [
                          for (var ponto in MapaController.pontosTuristicos)
                            ListTile(
                              title: Textos.padrao(
                                ponto['nome'],
                                TextAlign.start,
                                Cores.azulClaro,
                              ),
                              leading: IconButton(
                                onPressed: () => adicionarPonto(ponto),
                                icon: Icon(Icons.add, color: Cores.verdeEscuro),
                              ),
                            ),
                        ],
                      ),
                      Container(height: 20),
                      rota
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(width, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                await MapaController.gerarNovaRota();
                                Future.delayed(const Duration(seconds: 2));
                                setState(() {});
                              },
                              child: Textos.padrao(
                                'GERAR NOVA ROTA',
                                TextAlign.center,
                                Cores.verdeEscuro,
                              ),
                            )
                          : Container(),
                      Container(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => btn ? iniciar() : null,
                        child: Textos.padrao(
                          'INICIAR VIAGEM',
                          TextAlign.center,
                          Cores.verdeEscuro,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
