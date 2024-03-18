import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo02/controllers/mapa.dart';
import 'package:modulo02/pages/andamento.dart';
import 'package:modulo02/styles/styles.dart';

class Exercicio extends StatefulWidget {
  const Exercicio({super.key});
  static const routeName = '/exercicios';

  @override
  State<Exercicio> createState() => _ExercicioState();
}

class ScreenArguments {
  final String tipo;

  ScreenArguments(this.tipo);
}

class _ExercicioState extends State<Exercicio> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Textos.getTxt(args.tipo, 25, Cores.cinza),
        centerTitle: true,
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: FutureBuilder(
          future: MapaController.posicaoAtal(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Position res = snapshot.data as Position;

              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: width,
                      height: width * 1.3,
                      decoration: BoxDecoration(
                        color: Cores.branco,
                        border: Border.all(width: 2, color: Cores.cinza),
                        boxShadow: [
                          BoxShadow(
                            color: Cores.cinza,
                            blurRadius: 2,
                            offset: const Offset(1, 1),
                          )
                        ],
                      ),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(res.latitude, res.longitude),
                          zoom: 17,
                        ),
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        Andamento.routeName,
                        arguments: DadosExercicios(
                          DateTime.now(),
                          LatLng(res.latitude, res.longitude),
                          args.tipo,
                        ),
                      ),
                      child: Container(
                        width: width * .25,
                        height: width * .25,
                        decoration: BoxDecoration(
                          color: Cores.branco,
                          border: Border.all(width: 2, color: Cores.cinza),
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: [
                            BoxShadow(
                              color: Cores.cinza,
                              blurRadius: 2,
                              offset: const Offset(1, 1),
                            )
                          ],
                        ),
                        child: Center(
                          child: Textos.getTxt('Iniciar', 20, Cores.cinza),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Textos.getTxt(
                  'Erro ao carregar mapa',
                  20,
                  Cores.vermelho,
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(color: Cores.azul),
            );
          },
        ),
      ),
    );
  }
}
