import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simulado06_02/styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Column(
          children: [
            Textos(
              txt: 'GoGo Trip',
              textAlign: TextAlign.center,
              cor: Cores.cinza,
              size: 30,
              weight: FontWeight.bold,
            ),
            Container(
              width: width,
              height: width,
              child: const GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(-12.976390858297673, -38.48058858492815),
                  zoom: 17,
                ),
              ),
            ),
            Textos(
              txt:
                  'Salvador, a capital do estado da Bahia no nordeste do Brasil, é conhecida pela arquitetura colonial portuguesa, pela cultura afrobrasileira e pelo litoral tropical. O bairro do Pelourinho é seu coração histórico, com vielas de paralelepípedo terminando em praças grandes, prédios coloridos e igrejas barrocas, como São Francisco, com trabalhos em madeira revestidos com ouro.',
              textAlign: TextAlign.center,
              cor: Cores.cinza,
              size: 30,
              weight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
