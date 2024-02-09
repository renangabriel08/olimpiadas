import 'package:flutter/material.dart';
import 'package:modulo03/styles/styles.dart';
import 'package:modulo03/widgets/toast.dart';

class Feedbacks extends StatefulWidget {
  const Feedbacks({super.key});
  static const routeName = '/feedbacks';

  @override
  State<Feedbacks> createState() => _FeedbacksState();
}

class ScreenArguments {
  final String title;
  final String status;
  final bool favorito;

  ScreenArguments(this.title, this.status, this.favorito);
}

class _FeedbacksState extends State<Feedbacks> {
  List estrelas = [
    Icon(Icons.star, color: Cores.cinza2, size: 45),
    Icon(Icons.star, color: Cores.cinza2, size: 45),
    Icon(Icons.star, color: Cores.cinza2, size: 45),
    Icon(Icons.star, color: Cores.cinza2, size: 45),
    Icon(Icons.star, color: Cores.cinza2, size: 45),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Cores.verde,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Textos.rText(args.title, 14, FontWeight.w700, Cores.cinza1),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:
                    args.status == 'Em andamento' ? Cores.amarelo : Cores.azul,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Textos.rText(
                    args.status, 12, FontWeight.w400, Cores.cinza1),
              ),
            ),
            Icon(
              Icons.favorite,
              color: args.favorito ? Cores.vermelho : Cores.cinza1,
            ),
          ],
        ),
      ),
      body: Container(
        height: height,
        color: Cores.cinza1,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: Fontes.fonte,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(49, 255, 255, 255),
                  ),
                ),
                Container(height: height * .03),
                Textos.rText(
                  'Feedback do Desafio',
                  20,
                  FontWeight.w700,
                  Cores.verde,
                ),
                Container(height: height * .03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < estrelas.length; i++)
                      IconButton(
                        onPressed: () {
                          estrelas.clear();

                          for (int e = 0; e <= i; e++) {
                            estrelas.add(
                              Icon(Icons.star, color: Cores.amarelo, size: 45),
                            );
                          }

                          if (estrelas.length < 5) {
                            for (int a = estrelas.length; a < 5; a++) {
                              estrelas.add(
                                Icon(
                                  Icons.star,
                                  color: Cores.cinza2,
                                  size: 45,
                                ),
                              );
                            }
                          }
                          setState(() {});
                        },
                        icon: estrelas[i],
                      ),
                  ],
                ),
                Container(height: height * .03),
                Container(
                  decoration: BoxDecoration(
                    color: Cores.branco,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Escreva seu comentário',
                    ),
                  ),
                ),
                Container(height: height * .03),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Cores.verde,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(width, 42),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                    MyToast.gerarToast('Comentário feito com sucesso!');
                  },
                  child: Textos.rText(
                    'Enviar',
                    16,
                    FontWeight.w700,
                    Cores.cinza1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
