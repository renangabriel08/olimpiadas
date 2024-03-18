import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo02/controllers/mapa.dart';
import 'package:modulo02/controllers/user.dart';
import 'package:modulo02/styles/styles.dart';

class Progresso extends StatefulWidget {
  const Progresso({super.key});
  static const routeName = '/progresso';

  @override
  State<Progresso> createState() => _ProgressoState();
}

class DadosProgresso {
  final DateTime horario;
  final LatLng localizacao;
  final String tipo;
  final String tempo;
  final String distancia;

  DadosProgresso(
    this.horario,
    this.localizacao,
    this.tipo,
    this.tempo,
    this.distancia,
  );
}

class _ProgressoState extends State<Progresso> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final args = ModalRoute.of(context)!.settings.arguments as DadosProgresso;

    String dia =
        args.horario.day < 10 ? '0${args.horario.day}' : '${args.horario.day}';
    String mes = args.horario.month < 10
        ? '0${args.horario.month}'
        : '${args.horario.month}';

    String data = '$dia/$mes/${args.horario.year}';

    String sec = args.horario.second < 10
        ? '0${args.horario.second}'
        : '${args.horario.second}';
    String min = args.horario.minute < 10
        ? '0${args.horario.minute}'
        : '${args.horario.minute}';
    String hr = args.horario.hour < 10
        ? '0${args.horario.hour}'
        : '${args.horario.hour}';

    String hora = '$hr:$min:$sec';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Textos.getTxt('Progresso', 25, Cores.cinza),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Container(
                  width: width * .15,
                  height: width * .15,
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
                  child: FutureBuilder(
                    future: UserController.getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List data = snapshot.data as List;

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: Image.network(data[1], fit: BoxFit.cover),
                        );
                      }
                      return const Center(
                        child: Icon(Icons.person),
                      );
                    },
                  ),
                ),
                Container(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: UserController.getUser(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List data = snapshot.data as List;

                          return Textos.getTxt(
                            data[0],
                            16,
                            Cores.cinza,
                          );
                        }
                        if (snapshot.hasError) {
                          return Textos.getTxt(
                            'Erro ao carregar usuário:',
                            16,
                            Cores.vermelho,
                          );
                        }
                        return Textos.getTxt('Carregando...', 16, Cores.cinza);
                      },
                    ),
                    Textos.getTxt(
                      '${args.tipo} - $data - $hora',
                      16,
                      Cores.cinza,
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Textos.getTxt('Distância Total:', 16, Cores.cinza),
                    Textos.getTxt(args.distancia, 16, Cores.cinza),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Textos.getTxt('Tempo Total:', 16, Cores.cinza),
                    Textos.getTxt(args.tempo, 16, Cores.cinza),
                  ],
                )
              ],
            ),
            Container(
              width: width,
              height: width,
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
                  target: LatLng(
                    args.localizacao.latitude,
                    args.localizacao.longitude,
                  ),
                  zoom: 17,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('Origem'),
                    position: MapaController.points[0],
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueCyan,
                    ),
                    infoWindow: const InfoWindow(title: 'Origem'),
                  ),
                  Marker(
                    markerId: const MarkerId('Destino'),
                    position:
                        MapaController.points[MapaController.points.length - 1],
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueCyan,
                    ),
                    infoWindow: const InfoWindow(title: 'Destino'),
                  ),
                },
                polylines: {
                  Polyline(
                    polylineId: const PolylineId('Rota'),
                    points: MapaController.points,
                    color: Cores.azul,
                    width: 4,
                  ),
                },
                myLocationButtonEnabled: false,
                myLocationEnabled: false,
              ),
            ),
            GestureDetector(
              onTap: () {
                MapaController.points = [];
                Navigator.pushNamed(context, '/home');
              },
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
                  child: Textos.getTxt('Home', 20, Cores.cinza),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
