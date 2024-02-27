import 'package:flutter/material.dart';
import 'package:modulo8/controllers/api.dart';
import 'package:modulo8/controllers/cache.dart';
import 'package:modulo8/controllers/json.dart';
import 'package:modulo8/controllers/mapa.dart';
import 'package:modulo8/styles/styles.dart';

class Lista extends StatefulWidget {
  const Lista({super.key});
  static const routeName = '/lista';

  @override
  State<Lista> createState() => _ListaState();
}

class ScreenArguments {
  final List cidades;
  final String preco;

  ScreenArguments(this.cidades, this.preco);
}

class _ListaState extends State<Lista> {
  String precoSelecionado = '500';
  List precos = ['500', '300', '200', '100'];

  List cidades = CidadesEstados.json['estados'][0]['cidades'];
  String cidadeSelecionada = 'Acrelândia';

  bool loading = true;

  setar(value) {
    loading = true;
    cidadeSelecionada = value[0];
    precoSelecionado = value[1];
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([CacheController.getCidade(), CacheController.getPreco()])
        .then((value) => setar(value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    cidades = args.cidades;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Textos.txt2('Ofertas', Cores.azul1),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              width: width,
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Textos.txt1('E uma cidade', Cores.azul1),
                        ],
                      ),
                      DropdownButtonFormField(
                        value: cidadeSelecionada,
                        items: [
                          for (var cidade in cidades)
                            DropdownMenuItem(
                              value: cidade['cidade'],
                              child: Textos.txt1(cidade['cidade'], Cores.azul1),
                            ),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) => setState(() {
                          cidadeSelecionada = value.toString();
                        }),
                      ),
                      Container(height: height * .01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Textos.txt1('E um limite de preço', Cores.azul1),
                        ],
                      ),
                      DropdownButtonFormField(
                        value: precoSelecionado,
                        items: [
                          for (var preco in precos)
                            DropdownMenuItem(
                              value: preco,
                              child: Textos.txt1(preco, Cores.azul1),
                            ),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) => setState(() {
                          precoSelecionado = value.toString();
                        }),
                      ),
                      Container(height: height * .03),
                      FutureBuilder(
                        future: ApiCOntroller.getData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List data = snapshot.data as List;
                            List locais = [];

                            for (var i in data) {
                              if (i['enderecoLocal']
                                      .contains(cidadeSelecionada) &&
                                  i['custoMedio'] <
                                      int.parse(precoSelecionado)) {
                                locais.add(i);
                              }
                            }

                            return Column(
                              children: [
                                for (var local in locais)
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 7, 0, 7),
                                    child: Container(
                                      width: width,
                                      height: height * .15,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Cores.azul2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Textos.txt1(local['nomeLocal'],
                                                    Cores.azul1),
                                                Textos.txt1(
                                                  local['tipoLocal'],
                                                  Cores.azul1,
                                                ),
                                                Textos.txt1(
                                                  MapaController
                                                              .calcularDistancia(
                                                            MapaController
                                                                .latitude,
                                                            MapaController
                                                                .longitude,
                                                            double.parse(
                                                              local['latitude'],
                                                            ),
                                                            double.parse(
                                                              local[
                                                                  'longitude'],
                                                            ),
                                                          ) >
                                                          1000
                                                      ? '${(MapaController.calcularDistancia(
                                                            MapaController
                                                                .latitude,
                                                            MapaController
                                                                .longitude,
                                                            double.parse(
                                                              local['latitude'],
                                                            ),
                                                            double.parse(
                                                              local[
                                                                  'longitude'],
                                                            ),
                                                          ) / 1000).toInt()} Km'
                                                      : '${(MapaController.calcularDistancia(
                                                          MapaController
                                                              .latitude,
                                                          MapaController
                                                              .longitude,
                                                          double.parse(
                                                            local['latitude'],
                                                          ),
                                                          double.parse(
                                                            local['longitude'],
                                                          ),
                                                        )).toInt()} Metros',
                                                  Cores.azul1,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    for (int i = 0;
                                                        i <
                                                            local['avaliacao']
                                                                .toInt();
                                                        i++)
                                                      const Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                        size: 13,
                                                      ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    precoSelecionado == '100'
                                                        ? Icon(
                                                            Icons
                                                                .attach_money_rounded,
                                                            size: 12,
                                                            color: Cores.verde3,
                                                          )
                                                        : precoSelecionado ==
                                                                '200'
                                                            ? Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .attach_money_rounded,
                                                                    size: 12,
                                                                    color: Cores
                                                                        .verde3,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .attach_money_rounded,
                                                                    size: 12,
                                                                    color: Cores
                                                                        .verde3,
                                                                  )
                                                                ],
                                                              )
                                                            : precoSelecionado ==
                                                                    '300'
                                                                ? Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .attach_money_rounded,
                                                                        size:
                                                                            12,
                                                                        color: Cores
                                                                            .verde3,
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .attach_money_rounded,
                                                                        size:
                                                                            12,
                                                                        color: Cores
                                                                            .verde3,
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .attach_money_rounded,
                                                                        size:
                                                                            12,
                                                                        color: Cores
                                                                            .verde3,
                                                                      )
                                                                    ],
                                                                  )
                                                                : precoSelecionado ==
                                                                        '400'
                                                                    ? Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.attach_money_rounded,
                                                                            size:
                                                                                12,
                                                                            color:
                                                                                Cores.verde3,
                                                                          ),
                                                                          Icon(
                                                                            Icons.attach_money_rounded,
                                                                            size:
                                                                                12,
                                                                            color:
                                                                                Cores.verde3,
                                                                          ),
                                                                          Icon(
                                                                            Icons.attach_money_rounded,
                                                                            size:
                                                                                12,
                                                                            color:
                                                                                Cores.verde3,
                                                                          ),
                                                                          Icon(
                                                                            Icons.attach_money_rounded,
                                                                            size:
                                                                                12,
                                                                            color:
                                                                                Cores.verde3,
                                                                          )
                                                                        ],
                                                                      )
                                                                    : Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.attach_money_rounded,
                                                                            size:
                                                                                12,
                                                                            color:
                                                                                Cores.verde3,
                                                                          ),
                                                                          Icon(
                                                                            Icons.attach_money_rounded,
                                                                            size:
                                                                                12,
                                                                            color:
                                                                                Cores.verde3,
                                                                          ),
                                                                          Icon(
                                                                            Icons.attach_money_rounded,
                                                                            size:
                                                                                12,
                                                                            color:
                                                                                Cores.verde3,
                                                                          ),
                                                                          Icon(
                                                                            Icons.attach_money_rounded,
                                                                            size:
                                                                                12,
                                                                            color:
                                                                                Cores.verde3,
                                                                          ),
                                                                          Icon(
                                                                            Icons.attach_money_rounded,
                                                                            size:
                                                                                12,
                                                                            color:
                                                                                Cores.verde3,
                                                                          )
                                                                        ],
                                                                      )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
