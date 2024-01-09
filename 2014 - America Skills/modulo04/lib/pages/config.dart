import 'package:flutter/material.dart';
import 'package:modulo04/controllers/cache.dart';
import 'package:modulo04/controllers/validator.dart';
import 'package:modulo04/styles/styles.dart';
import 'package:modulo04/widgets/toast.dart';

class Config extends StatefulWidget {
  const Config({super.key});

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  final _formKey = GlobalKey<FormState>();

  String? tempoPartida;
  String? tempoPalavra;
  String? tipoPartida;
  bool? personalizado;
  List<Map>? todasCores;

  void setarVariaveis(Map<String, dynamic> result) {
    tempoPartida = result['tempoPartida'];
    tempoPalavra = result['tempoPalavra'];
    tipoPartida = result['tipoPartida'];
    todasCores = result['cores'];

    result == Cache.configPadrao ? personalizado = false : personalizado = true;
  }

  @override
  void initState() {
    Future.wait([Cache.getConfigs()]).then((value) {
      setarVariaveis(value[0]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<String> tiposPartida = ['Por tempo', 'Por palavra'];

    return Scaffold(
      body: FutureBuilder(
        future: Cache.getConfigs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                width: width,
                height: height,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: width,
                    height: height,
                    color: Colors.white,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/home'),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Cores.cinza),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                      child: Icon(Icons.arrow_back)),
                                ),
                              ),
                              Text(
                                'Configurações de Partida',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  fontSize: 23,
                                  color: Cores.vermelho,
                                ),
                              ),
                            ],
                          ),
                          Container(height: 40),
                          Text(
                            'Duração da partida',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              fontSize: 20,
                              color: Cores.azul,
                            ),
                          ),
                          Container(
                            width: width,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: DropdownButton(
                              value: tipoPartida,
                              items: [
                                for (int i = 0; i < tiposPartida.length; i++)
                                  DropdownMenuItem(
                                    value: tiposPartida[i],
                                    child: Text(tiposPartida[i]),
                                  ),
                              ],
                              onChanged: (value) => setState(() {
                                tipoPartida = value!;
                              }),
                              borderRadius: BorderRadius.circular(10),
                              style: TextStyle(
                                fontFamily: Fontes.fonte,
                                color: Cores.cinza,
                              ),
                            ),
                          ),
                          Container(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) => tempoPartida = value,
                            validator: (value) => Validator.validarDados(value),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.timer,
                              ),
                              label: Text(
                                'Tempo',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                ),
                              ),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          Container(height: 20),
                          Text(
                            'Exibição da palavra (em ms)',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              fontSize: 20,
                              color: Cores.azul,
                            ),
                          ),
                          TextFormField(
                            onChanged: (value) => tempoPalavra = value,
                            validator: (value) => Validator.validarDados(value),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.timer,
                              ),
                              label: Text(
                                'Tempo',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                ),
                              ),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          Container(height: 20),
                          Text(
                            'Cores disponibilizadas',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              fontSize: 20,
                              color: Cores.azul,
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int col1 = 0; col1 < 4; col1++)
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: todasCores![col1]['check'],
                                          onChanged: (value) => setState(() {
                                            todasCores![col1]['check'] =
                                                !todasCores![col1]['check'];
                                          }),
                                        ),
                                        Text(
                                          todasCores![col1]['cor'],
                                          style: TextStyle(
                                            fontFamily: Fontes.fonte,
                                            fontSize: 20,
                                            color: Cores.cinza,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int col2 = 4; col2 < 7; col2++)
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: todasCores![col2]['check'],
                                          onChanged: (value) => setState(() {
                                            todasCores![col2]['check'] =
                                                !todasCores![col2]['check'];
                                          }),
                                        ),
                                        Text(
                                          todasCores![col2]['cor'],
                                          style: TextStyle(
                                            fontFamily: Fontes.fonte,
                                            fontSize: 20,
                                            color: Cores.cinza,
                                          ),
                                        ),
                                      ],
                                    ),
                                  Container(height: 48),
                                ],
                              )
                            ],
                          ),
                          Container(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                int verdadeiros = 0;
                                List a = [];
                                for (int i = 0; i < todasCores!.length; i++) {
                                  a.add(todasCores![i]['check']);
                                }
                                for (int e = 0; e < a.length; e++) {
                                  if (a[e]) {
                                    verdadeiros++;
                                  }
                                }

                                if (verdadeiros < 2) {
                                  MyToast.gerarToast(
                                    'Selecione no mínimo duas cores',
                                  );
                                } else {
                                  await Cache.salvarConfigs(
                                    tipoPartida!,
                                    tempoPartida!,
                                    tempoPalavra!,
                                    todasCores!,
                                  );
                                  MyToast.gerarToast(
                                      'Dados salvos com sucesso!');
                                  Navigator.pushNamed(context, '/home');
                                }
                              } else {
                                MyToast.gerarToast('Preencha todos os campos');
                              }
                            },
                            child: Text(
                              'Salvar',
                              style: TextStyle(
                                fontFamily: Fontes.fonte,
                                fontSize: 20,
                                color: Cores.azul,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Ocorreu um erro",
                style: TextStyle(
                  fontFamily: Fontes.fonte,
                  fontSize: 25,
                  color: Cores.vermelho,
                ),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
