// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:modulo8/controllers/cache.dart';
import 'package:modulo8/controllers/json.dart';
import 'package:modulo8/controllers/mapa.dart';
import 'package:modulo8/pages/lista.dart';
import 'package:modulo8/styles/styles.dart';

class Ofertas extends StatefulWidget {
  const Ofertas({super.key});

  @override
  State<Ofertas> createState() => _OfertasState();
}

class _OfertasState extends State<Ofertas> {
  String precoSelecionado = '500';
  List precos = ['500', '300', '200', '100'];
  int img = 0;

  List estados = CidadesEstados.json['estados'];
  String estadoSelecionado = 'Acre';

  List cidades = CidadesEstados.json['estados'][0]['cidades'];
  String cidadeSelecionada = 'Acrelândia';

  int idEstado = 0;

  @override
  void initState() {
    MapaController.getPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => (),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Textos.txt2('Ofertas', Cores.azul1),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CarouselSlider(
                items: [
                  Image.network(
                    'https://assets.goal.com/v3/assets/bltcc7a7ffd2fbf71f5/blt7507270b526494f3/638c961f66367a1c91d3f179/NEEEY.jpg?auto=webp&format=pjpg',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://assets.goal.com/v3/assets/bltcc7a7ffd2fbf71f5/blt7507270b526494f3/638c961f66367a1c91d3f179/NEEEY.jpg?auto=webp&format=pjpg',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://assets.goal.com/v3/assets/bltcc7a7ffd2fbf71f5/blt7507270b526494f3/638c961f66367a1c91d3f179/NEEEY.jpg?auto=webp&format=pjpg',
                    fit: BoxFit.cover,
                  ),
                ],
                options: CarouselOptions(
                  height: height * .2,
                  aspectRatio: 1,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) => setState(
                    () => img = index,
                  ),
                  scrollDirection: Axis.horizontal,
                ),
              ),
              DotsIndicator(
                dotsCount: 3,
                position: img,
                decorator: DotsDecorator(
                  color: Cores.azul2,
                  activeColor: Cores.azul1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/mapa'),
                    child: Textos.txt1(
                      'Ver todas ofertas do mapa >',
                      Cores.azul1,
                    ),
                  ),
                ],
              ),
              Container(height: height * .03),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Textos.txt1('Ou selecione um estado', Cores.azul1),
                ],
              ),
              DropdownButtonFormField(
                  value: estadoSelecionado,
                  items: [
                    for (int i = 0; i < estados.length; i++)
                      DropdownMenuItem(
                        value: estados[i]['nome'],
                        child: Textos.txt1(estados[i]['nome'], Cores.azul1),
                      ),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    estadoSelecionado = value.toString();
                    for (int i = 0; i < estados.length; i++) {
                      if (estados[i]['nome'] == estadoSelecionado) {
                        idEstado = i;
                        cidades = CidadesEstados.json['estados'][i]['cidades'];
                        cidadeSelecionada = cidades[0]['cidade'];
                      }
                    }
                    setState(() {});
                  }),
              Container(height: height * .03),
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
                onChanged: (value) {
                  cidadeSelecionada = value.toString();
                },
              ),
              Container(height: height * .03),
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
                onChanged: (value) {
                  precoSelecionado = value.toString();
                },
              ),
              Container(height: height * .03),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(width, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await CacheController.salvarCidade(cidadeSelecionada);
                  await CacheController.salvarPreco(precoSelecionado);
                  Navigator.pushNamed(
                    context,
                    Lista.routeName,
                    arguments: ScreenArguments(
                      cidades,
                      precoSelecionado,
                    ),
                  );
                },
                child: Textos.txt1('Buscar', Cores.azul1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
