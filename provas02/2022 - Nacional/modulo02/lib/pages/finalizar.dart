import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo02/controllers/mapa.dart';
import 'package:modulo02/controllers/user.dart';
import 'package:modulo02/styles/styles.dart';

class Finalizar extends StatefulWidget {
  const Finalizar({super.key});
  static const routeName = '/Finalizar';

  @override
  State<Finalizar> createState() => _FinalizarState();
}

class FinalizarArguments {
  final String tipo;
  final LatLng locInicial;
  final DateTime hrInicio;
  final String tempo;
  final String dis;

  FinalizarArguments(
    this.tipo,
    this.locInicial,
    this.hrInicio,
    this.tempo,
    this.dis,
  );
}

class _FinalizarState extends State<Finalizar> {
  String img = '';
  String nome = '';
  bool loading = true;

  set(user) {
    nome = user['nome'];
    img = user['img'].toString().replaceFirst(
          'localhost:3000/localhost:3000',
          'http://10.91.236.150:3000',
        );

    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([
      UserController.getUser(),
    ]).then((value) => set(value[0]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final args =
        ModalRoute.of(context)!.settings.arguments as FinalizarArguments;

    return Scaffold(
      appBar: AppBar(
        title: Texto(
          txt: 'Progresso Final',
          textAlign: TextAlign.center,
          size: 16,
          weight: FontWeight.bold,
          cor: Cores.cinza,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: !loading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(width: 2, color: Cores.cinza),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: Image.network(
                              img,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Texto(
                              txt: nome,
                              textAlign: TextAlign.center,
                              size: 16,
                              weight: FontWeight.bold,
                              cor: Cores.cinza,
                            ),
                            Texto(
                              txt:
                                  '${args.tipo} - ${args.hrInicio.day}/${args.hrInicio.month}/${args.hrInicio.year} - ${args.hrInicio.hour}:${args.hrInicio.minute}',
                              textAlign: TextAlign.center,
                              size: 16,
                              weight: FontWeight.bold,
                              cor: Cores.cinza,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Texto(
                              txt: 'Distânca total',
                              textAlign: TextAlign.center,
                              size: 16,
                              weight: FontWeight.bold,
                              cor: Cores.cinza,
                            ),
                            Texto(
                              txt: args.dis,
                              textAlign: TextAlign.center,
                              size: 16,
                              weight: FontWeight.bold,
                              cor: Cores.cinza,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Texto(
                              txt: 'Tempo total',
                              textAlign: TextAlign.center,
                              size: 16,
                              weight: FontWeight.bold,
                              cor: Cores.cinza,
                            ),
                            Texto(
                              txt: args.tempo,
                              textAlign: TextAlign.center,
                              size: 16,
                              weight: FontWeight.bold,
                              cor: Cores.cinza,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width,
                    height: height * .5,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          MapaController.latitudeInicial,
                          MapaController.longitudeInicial,
                        ),
                        zoom: 17,
                      ),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      markers: MapaController.markers,
                      polylines: MapaController.polylines,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/home'),
                      child: Texto(
                        txt: 'Voltar ao início',
                        textAlign: TextAlign.center,
                        size: 16,
                        weight: FontWeight.normal,
                        cor: Cores.ciano,
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(color: Cores.ciano),
              ),
      ),
    );
  }
}
