import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:modulo02/controllers/home.dart';
import 'package:modulo02/pages/comentarios.dart';
import 'package:modulo02/styles/styles.dart';
import 'package:modulo02/widgets/card_slide.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pg = 0;
  int userId = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: width,
              height: 60,
              color: Cores.verde,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/bussola'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.explore,
                          color: Cores.cinza1,
                        ),
                        Text(
                          'Bússola',
                          style: TextStyle(
                            color: Cores.cinza1,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: Fontes.fonte,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/lista'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.checklist,
                          color: Cores.cinza1,
                        ),
                        Text(
                          'Desafios',
                          style: TextStyle(
                            color: Cores.cinza1,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: Fontes.fonte,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      Comentarios.routeName,
                      arguments: ScreenArguments(userId),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.insert_comment_outlined,
                          color: Cores.cinza1,
                        ),
                        Text(
                          'Comentários',
                          style: TextStyle(
                            color: Cores.cinza1,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: Fontes.fonte,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: height - 60,
              width: width,
              color: Cores.cinza1,
              child: Padding(
                padding: const EdgeInsets.all(42),
                child: FutureBuilder(
                  future: HomeController.returnHome(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List data = snapshot.data as List;
                      List desafios = data[0]['desafios_concluidos'];
                      userId = data[0]['id'];

                      List<Widget>? slide = [];

                      for (var desafio in desafios) {
                        slide.add(
                          CardSlide(
                            txt: desafio['titulo'],
                            icone: desafio['status'] == 'Pendente'
                                ? Icons.pending_rounded
                                : Icons.check_circle,
                            cor: desafio['status'] == 'Pendente'
                                ? Cores.amarelo
                                : Cores.verde,
                            width: 99,
                            height: 136,
                          ),
                        );
                      }

                      return Column(
                        children: [
                          Container(height: height * .1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  border: Border.all(
                                    color: Cores.verde,
                                    width: 4,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(999),
                                  child: Image.network(data[0]['avatar']),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    data[0]['nome'],
                                    style: TextStyle(
                                      color: Cores.cinza2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: Fontes.fonte,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Nível ',
                                        style: TextStyle(
                                          color: Cores.cinza2,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: Fontes.fonte,
                                        ),
                                      ),
                                      Text(
                                        data[0]['nivel'],
                                        style: TextStyle(
                                          color: Cores.cinza2,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: Fontes.fonte,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(height: height * .08),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[1]['temperatura'],
                                    style: TextStyle(
                                      color: Cores.verde,
                                      fontSize: 64,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: Fontes.fonte,
                                    ),
                                  ),
                                  Text(
                                    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                                    style: TextStyle(
                                      color: Cores.verde,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: Fontes.fonte,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.cloud,
                                    size: 24,
                                    color: Cores.verde,
                                  ),
                                  Text(
                                    data[1]['clima'],
                                    style: TextStyle(
                                      color: Cores.verde,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: Fontes.fonte,
                                    ),
                                  ),
                                  Text(
                                    '${DateTime.now().hour}:${DateTime.now().minute}',
                                    style: TextStyle(
                                      color: Cores.verde,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: Fontes.fonte,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(height: height * .1),
                          CarouselSlider(
                            items: slide,
                            options: CarouselOptions(
                              height: 136,
                              aspectRatio: 1,
                              viewportFraction: 0.3,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration: const Duration(
                                milliseconds: 800,
                              ),
                              autoPlayCurve: Curves.ease,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              onPageChanged: (index, reason) => setState(
                                () => pg = index,
                              ),
                              scrollDirection: Axis.horizontal,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
