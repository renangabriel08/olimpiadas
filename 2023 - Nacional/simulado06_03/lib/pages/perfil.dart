import 'package:flutter/material.dart';
import 'package:simulado06_03/controllers/api.dart';
import 'package:simulado06_03/controllers/cache.dart';
import 'package:simulado06_03/styles/styles.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String img = '';

  bool loading = true;

  Map user = {};

  double size = 16;
  double sliderValue = 0;

  Color t1 = const Color(0xFF00E1C2);
  Color t2 = const Color(0xFF2C2C2D);
  Color t3 = const Color(0xFFE10051);
  Color bg = const Color(0xFFFFFFFF);

  setar(value) {
    user = value[0][0] as Map;
    emailController.text = user['email_user'];
    nomeController.text = user['nome_user'];
    img = user['foto_user'];

    if (value[1] == 'P') {
      size = 14;
      sliderValue = 0;
    } else if (value[1] == 'M') {
      size = 16;
      sliderValue = 1.5;
    } else {
      size = 18;
      sliderValue = 3;
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
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : FutureBuilder(
                future: Future.wait([
                  CacheController.getTamanho(),
                  CacheController.getTema(),
                ]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List data = snapshot.data as List;
                    if (data[0] == 'P') {
                      size = 14;
                      sliderValue = 0;
                    } else if (data[0] == 'M') {
                      size = 16;
                      sliderValue = 1.5;
                    } else {
                      size = 18;
                      sliderValue = 3;
                    }

                    if (data[1] == 'C') {
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

                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              border:
                                  Border.all(width: 2, color: CoresClaro.t1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(999),
                              child: Image.network(
                                img,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(height: 40),
                          TextFormField(
                            controller: nomeController,
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: size,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Nome",
                              labelStyle: TextStyle(
                                fontFamily: Fonts.font,
                                fontSize: size,
                              ),
                              prefixIcon: Icon(Icons.person, color: t1),
                            ),
                          ),
                          Container(height: 20),
                          TextFormField(
                            controller: emailController,
                            style: TextStyle(
                              fontFamily: Fonts.font,
                              fontSize: size,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Email",
                              labelStyle: TextStyle(
                                fontFamily: Fonts.font,
                                fontSize: size,
                              ),
                              prefixIcon: Icon(Icons.person, color: t1),
                            ),
                          ),
                          Container(height: 40),
                          Row(
                            children: [
                              Text(
                                'Tamanho do texto',
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size * 1.3,
                                ),
                              ),
                            ],
                          ),
                          Slider(
                              max: 3,
                              divisions: 2,
                              value: sliderValue,
                              onChanged: (value) async {
                                sliderValue = value;
                                await CacheController.salvarTamanho(
                                    sliderValue == 0
                                        ? 'P'
                                        : sliderValue == 1.5
                                            ? 'M'
                                            : 'G');
                                setState(() {});
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pequeno',
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size,
                                ),
                              ),
                              Text(
                                'Medio',
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size,
                                ),
                              ),
                              Text(
                                'Grande',
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size,
                                ),
                              ),
                            ],
                          ),
                          Container(height: 40),
                          Row(
                            children: [
                              Text(
                                'Modo escuro',
                                style: TextStyle(
                                  fontFamily: Fonts.font,
                                  fontSize: size * 1.3,
                                ),
                              ),
                            ],
                          ),
                        ],
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
