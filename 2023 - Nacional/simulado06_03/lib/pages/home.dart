import 'package:flutter/material.dart';
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
      MapaController.getPosition(context),
    ]).then((value) => setar(value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: bg,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) => pesquisa = value,
                  style: TextStyle(
                    fontFamily: Fonts.font,
                    fontSize: size,
                    color: t2,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Pesquisar",
                    labelStyle: TextStyle(
                      fontFamily: Fonts.font,
                      fontSize: size,
                      color: t2,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        loading = true;
                        setState(() {});
                        await ApiController.pesquisar(pesquisa);
                        loading = false;
                        setState(() {});
                      },
                      icon: Icon(Icons.search, color: t1),
                    ),
                  ),
                ),
                Container(height: 20),
                loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          for (var local in MapaController.locais)
                            GestureDetector(
                              onTap: () {
                                MapaController.idLocal = local['id_local'];
                                Navigator.pushNamed(
                                  context,
                                  '/mapa',
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: Container(
                                  width: width,
                                  height: 130,
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
                                                color: t2,
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
                                                color: t2,
                                              ),
                                            ),
                                            Text(
                                              local['tipo_local'].toString(),
                                              style: TextStyle(
                                                fontFamily: Fonts.font,
                                                fontSize: size * .8,
                                                color: t2,
                                              ),
                                            ),
                                            Text(
                                              local['distancia'].toString(),
                                              style: TextStyle(
                                                fontFamily: Fonts.font,
                                                fontSize: size,
                                                color: t2,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                for (int i = 0;
                                                    i <
                                                        double.parse(
                                                          local[
                                                              'avaliacao_local'],
                                                        ).round();
                                                    i++)
                                                  const Icon(
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
                            ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/perfil'),
        child: Icon(
          Icons.person,
          color: bg,
        ),
      ),
    );
  }
}
