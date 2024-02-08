import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:modulo03/controllers/home.dart';
import 'package:modulo03/styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int slide = 0;
  String desafio = '';
  String status = '';
  String desc = '';
  List<Widget> imgs = [];
  List tarefas = [];
  List comentarios = [];
  List values = [false, false, false, false];
  bool favorito = false;
  bool progresso = true;

  setarVariaveis(value) {
    desafio = value['titulo'];
    status = value['status'];
    desc = value['desc'];
    tarefas = value['tarefas'];
    comentarios = value['comentarios'];
    favorito = value['favorito'];

    for (String img in value['imgs']) {
      imgs.add(
        Image.network(
          img,
          fit: BoxFit.fill,
        ),
      );
    }
    progresso = false;

    setState(() {});
  }

  @override
  void initState() {
    Future.wait([HomeController.getData()]).then(
      (value) => setarVariaveis(value[0]),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: !progresso
          ? AppBar(
              backgroundColor: Cores.verde,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Textos.rText(desafio, 14, FontWeight.w700, Cores.cinza1),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          status == 'Em andamento' ? Cores.amarelo : Cores.azul,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Textos.rText(
                          status, 12, FontWeight.w400, Cores.cinza1),
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() {
                      favorito = !favorito;
                    }),
                    icon: Icon(
                      Icons.favorite,
                      color: favorito ? Cores.vermelho : Cores.cinza1,
                    ),
                  ),
                ],
              ),
            )
          : AppBar(),
      body: !progresso
          ? Container(
              color: Cores.cinza1,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: Fontes.fonte,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: status == 'Em andamento'
                              ? Cores.branco
                              : const Color.fromARGB(49, 255, 255, 255),
                        ),
                      ),
                      Container(height: height * .03),
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Cores.verde,
                              width: 5,
                            ),
                          ),
                          height: height * .3,
                          child: Stack(
                            children: [
                              Center(
                                child: CarouselSlider(
                                  items: imgs,
                                  options: CarouselOptions(
                                    height: height * .2,
                                    viewportFraction: 1,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: false,
                                    enlargeCenterPage: true,
                                    enlargeFactor: 0.3,
                                    onPageChanged: (index, reason) => setState(
                                      () => slide = index,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: (width - 80) / 3,
                                child: DotsIndicator(
                                  dotsCount: 4,
                                  position: slide,
                                  decorator: DotsDecorator(
                                    activeColor: Cores.verde,
                                    color: Cores.cinza2,
                                  ),
                                ),
                              )
                            ],
                          )),
                      Container(height: height * .03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Textos.rText(
                              'Tarefas', 16, FontWeight.w700, Cores.verde)
                        ],
                      ),
                      Column(
                        children: [
                          for (int i = 0; i < tarefas.length; i++)
                            Row(
                              children: [
                                Checkbox(
                                  value: values[i],
                                  onChanged: (value) => setState(() {
                                    values[i] = value;
                                  }),
                                ),
                                values[i]
                                    ? Text(
                                        tarefas[i],
                                        style: TextStyle(
                                          fontFamily: Fontes.fonte,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Cores.cinza2,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      )
                                    : Textos.rText(
                                        tarefas[i],
                                        16,
                                        FontWeight.w400,
                                        Cores.cinza2,
                                      ),
                              ],
                            ),
                        ],
                      ),
                      Container(height: height * .03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Textos.rText(
                            'Comentários',
                            16,
                            FontWeight.w700,
                            Cores.verde,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          for (var comentario in comentarios)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Container(
                                height: height * .2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Cores.preto,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(17),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Textos.rText(
                                        comentario['comentario'],
                                        14,
                                        FontWeight.w400,
                                        Cores.cinza2,
                                      ),
                                      Row(
                                        children: [
                                          Textos.rText(
                                            comentario['user'],
                                            12,
                                            FontWeight.w700,
                                            Cores.verde,
                                          ),
                                          Textos.rText(
                                            ' às ${comentario['horario']}',
                                            12,
                                            FontWeight.w400,
                                            Cores.verde,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
