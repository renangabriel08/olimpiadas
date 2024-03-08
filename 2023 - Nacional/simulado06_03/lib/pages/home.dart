import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simulado06_03/controllers/api.dart';
import 'package:simulado06_03/controllers/cache.dart';
import 'package:simulado06_03/controllers/mapa.dart';
import 'package:simulado06_03/styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String pesquisa = '';
  List locais = [];

  bool loading = true;
  double size = 16;

  Color t1 = const Color(0xFF00E1C2);
  Color t2 = const Color(0xFF2C2C2D);
  Color t3 = const Color(0xFFE10051);
  Color bg = const Color(0xFFFFFFFF);

  setar(value) {
    if (value[1] == 'P') {
      size = 14;
    } else if (value[1] == 'M') {
      size = 16;
    } else {
      size = 18;
    }

    if (value[2] == 'C') {
      t1 = const Color(0xFF00E1C2);
      t2 = const Color(0xFF2C2C2D);
      t3 = const Color(0xFFE10051);
      bg = const Color(0xFFFFFFFF);
    } else {
      t1 = const Color(0xFFFFFFFF);
      t2 = const Color(0xFFFFFFFF);
      t3 = const Color(0xFFFFFFFF);
      bg = const Color(0xFF2C2C2D);
    }

    loading = false;

    setState(() {});
  }

  @override
  void initState() {
    Future.wait([
      ApiController.getUser(),
      CacheController.getTamanho(),
      CacheController.getTema(),
      MapaController.getPosition(),
    ]).then((value) => setar(value));
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
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder(
                future: Future.wait([
                  ApiController.getLocais(),
                  ApiController.pesquisar(pesquisa),
                ]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (pesquisa != '') {
                      snapshot.data![1] != null
                          ? locais = snapshot.data![1] as List
                          : locais = [];
                    } else {
                      locais = snapshot.data![0] as List;
                    }

                    adicionarDistancias() async {
                      for (var local in locais) {
                        local['distancia'] =
                            await MapaController.getDistancia(LatLng(
                          double.parse(local['latitude_local']),
                          double.parse(local['longitude_local']),
                        ));
                      }
                    }

                    adicionarDistancias();

                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              onChanged: (value) => pesquisa = value,
                              style: TextStyle(
                                fontFamily: Fonts.font,
                                fontSize: size,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Pesquisar",
                                labelStyle: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.search, color: t1),
                                ),
                              ),
                            ),
                            Container(height: 20),
                            for (var local in locais)
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: Container(
                                  width: width,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: t1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              local['nome_local'].length < 15
                                                  ? local['nome_local']
                                                  : '${local['nome_local'].substring(0, 15)} [...]',
                                              style: TextStyle(
                                                fontFamily: Fonts.font,
                                                fontSize: size,
                                              ),
                                            ),
                                            Text(
                                              local['descricao_local'].length <
                                                      30
                                                  ? local['descricao_local']
                                                  : '${local['descricao_local'].substring(0, 30)} [...]',
                                              style: TextStyle(
                                                fontFamily: Fonts.font,
                                                fontSize: size * .8,
                                              ),
                                            ),
                                            Text(
                                              local['distancia'].toString(),
                                              style: TextStyle(
                                                fontFamily: Fonts.font,
                                                fontSize: size,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                for (int i = 0;
                                                    i <
                                                        double.parse(local[
                                                                'avaliacao_local'])
                                                            .round();
                                                    i++)
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: 10,
                                                  )
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
      ),
    );
  }
}
