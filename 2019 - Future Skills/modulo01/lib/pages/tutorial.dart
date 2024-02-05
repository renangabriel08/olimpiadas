import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:modulo01/pages/slide.dart';

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
    return Scaffold(
      body: Container(
        child: CarouselSlider(
          carouselController: _controller,
          items: items,
          options: CarouselOptions(
            height: 400,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (index, reason) => setState(() => pg = index),
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    );
  }
}
