import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo8/controllers/mapa.dart';
import 'package:modulo8/styles/styles.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  late Position posAtual;

  setar(value) {
    posAtual = value[0];
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([MapaController.posicaoAtual()]).then((value) => setar(value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => (),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Textos.txt2('Ofertas', Cores.azul1),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: width,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(posAtual.latitude, posAtual.longitude),
                  zoom: 17,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Textos.txt1('Recomendado', Cores.azul1),
              ],
            )
          ],
        ),
      ),
    );
  }
}
