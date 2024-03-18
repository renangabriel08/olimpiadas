import 'package:flutter/material.dart';
import 'package:modulo01/controllers/api.dart';
import 'package:modulo01/controllers/cache.dart';
import 'package:modulo01/controllers/notificacao.dart';
import 'package:modulo01/styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final pesquisaController = TextEditingController();
  String? pesquisa;
  List data = [];
  bool pesquisou = false;
  List dataPesquisa = [];

  List<String> filtros = ['Descrição', 'Participantes', 'Local'];
  String filtroSelecionado = '';

  modal(titulo, desc, local, data, hora, participantes) async {
    final List eventosDesejos = await Cache.getEventos();
    Map eventoIgual = {};
    bool jaAdicionado = false;

    //Verificando se evento já existe
    for (int i = 0; i < eventosDesejos.length; i++) {
      String comparar = '$titulo$data$hora$desc$participantes$local';
      String comparar2 =
          '${eventosDesejos[i]['titulo']}${eventosDesejos[i]['data']}${eventosDesejos[i]['horario']}${eventosDesejos[i]['desc']}${eventosDesejos[i]['participantes']}${eventosDesejos[i]['local']}';

      if (comparar == comparar2) {
        eventoIgual = eventosDesejos[i];
        jaAdicionado = true;
      }
    }

    // ignore: use_build_context_synchronously
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Textos.titulo(titulo, Cores.azulMedio),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: Cores.cinza),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Cores.cinza,
                  ),
                ),
              ),
            ),
          ],
        ),
        content: SizedBox(
          height: 115,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Textos.padrao('Descrição: $desc', Cores.cinza),
              Textos.padrao('Local: $local', Cores.cinza),
              Textos.padrao('Data: $data', Cores.cinza),
              Textos.padrao('Horário: $hora', Cores.cinza),
              Textos.padrao('Participantes: $participantes', Cores.cinza),
            ],
          ),
        ),
        actions: <Widget>[
          jaAdicionado
              ? TextButton(
                  onPressed: () {
                    Cache.deletarEventos(eventoIgual);
                    Navigator.pop(context, 'Remover dos desejos');
                  },
                  child: Textos.padrao('Remover dos desejos', Colors.red),
                )
              : TextButton(
                  onPressed: () async {
                    Map evento = {
                      "titulo": titulo,
                      "data": data,
                      "horario": hora,
                      "desc": desc,
                      "participantes": participantes,
                      "local": local,
                    };

                    Cache.salvarEvento(evento);

                    await Notificar.showNotification(
                      '$titulo - $data',
                      '$desc. Venha conferir',
                    );
                    Navigator.pop(context, 'Adicionar aos desejos');
                  },
                  child: Textos.padrao(
                    'Adicionar aos desejos',
                    Cores.azulMedio,
                  ),
                ),
        ],
      ),
    );
  }

  void setarVariaveis(value) {
    data = value as List;
  }

  @override
  void initState() {
    Future.wait([ApiController.getEvents()]).then(
      (value) => setarVariaveis(value[0]),
    );
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
        child: FutureBuilder(
          future: ApiController.getEvents(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //Ordenando por filtro
              if (filtroSelecionado == 'Descrição') {
                for (int i = 0; i < data.length; i++) {
                  data.sort((a, b) => a['desc'].compareTo(b['desc']));
                }
              } else if (filtroSelecionado == 'Participantes') {
                for (int i = 0; i < data.length; i++) {
                  data.sort(
                    (a, b) => b['participantes'].compareTo(a['participantes']),
                  );
                }
              } else if (filtroSelecionado == 'Local') {
                for (int i = 0; i < data.length; i++) {
                  data.sort((a, b) => a['local'].compareTo(b['local']));
                }
              } else {
                for (int i = 0; i < data.length; i++) {
                  data.sort((a, b) => a['horario'].compareTo(b['horario']));
                }
              }

              void pesquisar(String? txt) {
                pesquisou = true;
                if (txt != null && txt != '') {
                  if (filtroSelecionado == 'Descrição') {
                    for (int i = 0; i < data.length; i++) {
                      if (data[i]['desc'].toString().toLowerCase() ==
                          txt.toLowerCase()) {
                        dataPesquisa.add(data[i]);
                      }
                    }
                  }

                  if (filtroSelecionado == 'Participantes') {
                    for (int i = 0; i < data.length; i++) {
                      if (data[i]['participantes'].toString().toLowerCase() ==
                          txt.toLowerCase()) {
                        dataPesquisa.add(data[i]);
                      }
                    }
                  }

                  if (filtroSelecionado == 'Local') {
                    for (int i = 0; i < data.length; i++) {
                      if (data[i]['local'].toString().toLowerCase() ==
                          txt.toLowerCase()) {
                        dataPesquisa.add(data[i]);
                      }
                    }
                  }
                }
                setState(() {});
              }

              void limparPesquisa() {
                setState(() {
                  pesquisou = false;
                  dataPesquisa = [];
                  pesquisaController.text = '';
                  pesquisa = '';
                });
              }

              //Salvando datasEventos dos eventos
              List datasEventos = [];
              if (!pesquisou) {
                for (int i = 0; i < data.length; i++) {
                  if (!datasEventos.contains(data[i]['data'])) {
                    datasEventos.add(data[i]['data']);
                  }
                }
              } else {
                for (int i = 0; i < dataPesquisa.length; i++) {
                  if (!datasEventos.contains(dataPesquisa[i]['data'])) {
                    datasEventos.add(dataPesquisa[i]['data']);
                  }
                }
              }

              return Padding(
                padding: const EdgeInsets.all(25),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //Header
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(color: Cores.cinza),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(child: Icon(Icons.arrow_back)),
                          ),
                          Container(width: width * .13),
                          Textos.titulo('Tela de eventos', Cores.azulEscuro),
                        ],
                      ),

                      //Pesquisa
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: SizedBox(
                          width: width,
                          height: 50,
                          child: TextFormField(
                            controller: pesquisaController,
                            onChanged: (value) => pesquisa = value,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () => pesquisou
                                    ? limparPesquisa()
                                    : pesquisar(pesquisa),
                                icon: pesquisou
                                    ? const Icon(Icons.close)
                                    : const Icon(Icons.search),
                              ),
                              border: const OutlineInputBorder(),
                              label: Text(
                                'Pesquisar',
                                style: TextStyle(fontFamily: Fontes.fonte),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //Filtros
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < filtros.length; i++)
                            Row(
                              children: [
                                Radio(
                                  value: filtros[i],
                                  groupValue: filtroSelecionado,
                                  onChanged: (value) => setState(() {
                                    filtroSelecionado = value!;
                                  }),
                                ),
                                Text(
                                  filtros[i],
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: Fontes.fonte,
                                    color: Cores.cinza,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),

                      pesquisou
                          ? Column(children: [
                              for (int i = 0; i < datasEventos.length; i++)
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        Container(height: 15),
                                        Textos.padrao(
                                          datasEventos[i],
                                          Cores.azulEscuro,
                                        ),
                                        for (int e = 0;
                                            e < dataPesquisa.length;
                                            e++)
                                          if (datasEventos[i] ==
                                              dataPesquisa[e]['data'])
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                0,
                                                5,
                                                0,
                                                5,
                                              ),
                                              child: GestureDetector(
                                                onTap: () => modal(
                                                  dataPesquisa[e]['titulo'],
                                                  dataPesquisa[e]['desc'],
                                                  dataPesquisa[e]['local'],
                                                  dataPesquisa[e]['data'],
                                                  dataPesquisa[e]['horario'],
                                                  dataPesquisa[e]
                                                      ['participantes'],
                                                ),
                                                child: Container(
                                                  width: width,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Cores.cinza,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 1,
                                                        offset:
                                                            const Offset(1, 1),
                                                        color: Cores.cinza,
                                                      )
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                      5,
                                                      0,
                                                      5,
                                                      0,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Textos.padrao(
                                                          dataPesquisa[e]
                                                              ['desc'],
                                                          Cores.cinza,
                                                        ),
                                                        Textos.padrao(
                                                          dataPesquisa[e]
                                                              ['horario'],
                                                          Cores.cinza,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                      ],
                                    ),
                                  ],
                                ),
                            ])
                          : Column(
                              children: [
                                for (int i = 0; i < datasEventos.length; i++)
                                  Column(
                                    children: [
                                      Column(
                                        children: [
                                          Container(height: 15),
                                          Textos.padrao(
                                            datasEventos[i],
                                            Cores.azulEscuro,
                                          ),
                                          for (int e = 0; e < data.length; e++)
                                            if (datasEventos[i] ==
                                                data[e]['data'])
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                  0,
                                                  5,
                                                  0,
                                                  5,
                                                ),
                                                child: GestureDetector(
                                                  onTap: () => modal(
                                                    data[e]['titulo'],
                                                    data[e]['desc'],
                                                    data[e]['local'],
                                                    data[e]['data'],
                                                    data[e]['horario'],
                                                    data[e]['participantes'],
                                                  ),
                                                  child: Container(
                                                    width: width,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Cores.cinza,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 1,
                                                          offset: const Offset(
                                                              1, 1),
                                                          color: Cores.cinza,
                                                        )
                                                      ],
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(
                                                        5,
                                                        0,
                                                        5,
                                                        0,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Textos.padrao(
                                                            data[e]['desc'],
                                                            Cores.cinza,
                                                          ),
                                                          Textos.padrao(
                                                            data[e]['horario'],
                                                            Cores.cinza,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                        ],
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: Cores.azulEscuro,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/desejos'),
        child: const Icon(Icons.list_alt_outlined),
      ),
    );
  }
}
