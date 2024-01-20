import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simulado06_02/styles/styles.dart';

class Mapa extends StatelessWidget {
  const Mapa({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              children: [
                Textos.titulo('GoGo Trip'),
                Container(height: height * .02),
                SizedBox(
                  width: width * .8,
                  height: width * .8,
                  child: const GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(-12.976390858297673, -38.48058858492815),
                      zoom: 14,
                    ),
                  ),
                ),
                Textos.subtitulo('Salvador'),
                Container(height: height * .02),
                SizedBox(
                  width: width,
                  child: Textos.padrao(
                    'Salvador, a capital do estado da Bahia no nordeste do Brasil, é conhecida pela arquitetura colonial portuguesa, pela cultura afrobrasileira e pelo litoral tropical. O bairro do Pelourinho é seu coração histórico, com vielas de paralelepípedo terminando em praças grandes, prédios coloridos e igrejas barrocas, como São Francisco, com trabalhos em madeira revestidos com ouro.',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
