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
  String local = '';
  bool loading = true;

  pesquisar() async {
    await MapaController.buscarLocal(local);
    await MapaController.buscarLugaresProximos();

    await Future.delayed(const Duration(seconds: 1));

    setState(() {});
  }

  Future<void> modal(local) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Textos.subtitulo(
            local['nome'],
            TextAlign.start,
            Cores.verdeEscuro,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Textos.padrao(
                  local['end'],
                  TextAlign.start,
                  Cores.verdeEscuro,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Textos.padrao(
                'Gerar rota',
                TextAlign.start,
                Cores.verdeEscuro,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Textos.padrao(
                'Fechar',
                TextAlign.start,
                Cores.verdeEscuro,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  checkin() {
    //adicionar 10 pontos
  }

  init() {
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([MapaController.getPosition()]).then((value) => init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: !loading
            ? Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) => local = value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Pesquisar',
                        labelStyle: TextStyle(fontFamily: Fonts.font),
                        suffixIcon: IconButton(
                          onPressed: () => pesquisar(),
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                    Container(
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
                        markers: MapaController.markers,
                      ),
                    ),
                    Column(
                      children: [
                        for (var local in MapaController.locaisProximos)
                          GestureDetector(
                            onTap: () => modal(local),
                            child: ListTile(
                              title: local['nome'],
                              subtitle: local['dis'],
                              leading: local['check']
                                  ? IconButton(
                                      onPressed: () => checkin(),
                                      icon: const Icon(Icons.check_box),
                                    )
                                  : Container(),
                            ),
                          )
                      ],
                    )
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
