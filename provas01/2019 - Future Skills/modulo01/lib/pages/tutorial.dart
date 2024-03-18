import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:modulo01/pages/slide.dart';
import 'package:modulo01/styles/styles.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({super.key});

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  int pg = 0;
  var _controller = CarouselController();

  List<Widget>? items = [
    const Slide(
      txt:
          '"Apresentando o melhor companheiro de condicionamento físico e saúde, nosso novo aplicativo móvel que desafia você a ultrapassar seus limites e atingir suas metas de condicionamento físico! Com uma ampla variedade de tarefas de exercícios e desafios diários, nosso aplicativo ajuda você a permanecer no caminho certo e motivado para liderar uma vida saudável e estilo de vida ativo."',
      img: 'assets/logo2.png',
    ),
    const Slide(
      txt:
          '"Cansado de se sentir desmotivado para se exercitar? Nosso aplicativo móvel oferece uma maneira divertida e envolvente de se manter ativo e atingir suas metas de condicionamento físico, com uma variedade de desafios, recompensas e recursos sociais que tornam o treino divertido e emocionante."',
      img: 'assets/frame.png',
    ),
    const Slide(
      txt:
          '"Transforme seu corpo e sua mente com nosso novo aplicativo inovador. Com uma ampla variedade de exercícios, desde cardio e treinamento de força até ioga e meditação, nosso aplicativo oferece desafios diários e programas personalizados que ajudarão você a atingir suas metas de condicionamento físico."',
      img: 'assets/frame.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Cores.ciano,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CarouselSlider(
                carouselController: _controller,
                items: items,
                options: CarouselOptions(
                  height: height * .85,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) => setState(() => pg = index),
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DotsIndicator(
                    dotsCount: 3,
                    position: pg,
                    decorator: DotsDecorator(
                      activeColor: Cores.cinza1,
                      color: Cores.cinza2,
                      size: const Size(15, 15),
                      activeSize: const Size(15, 15),
                    ),
                  ),
                  pg != 2
                      ? Row(
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                '/login',
                              ),
                              child: Text(
                                'Pular',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Cores.cinza1,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Cores.cinza1,
                              ),
                              onPressed: () => setState(() {
                                _controller.nextPage();
                                pg++;
                              }),
                              child: const Text(
                                'Próximo',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Cores.cinza1,
                              ),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                '/login',
                              ),
                              child: const Text(
                                'Acessar',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
