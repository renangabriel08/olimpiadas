import 'dart:math';
import 'package:flutter/material.dart';
import 'package:modulo01/controllers/cache.dart';
import 'package:modulo01/controllers/home.dart';
import 'package:modulo01/styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List desafios = [];

  showModal() {
    var id = Random().nextInt(desafios.length) + 1;
    String titulo = '';
    String desc = '';

    for (var desafio in desafios) {
      if (desafio['id'] == id) {
        titulo = desafio['titulo'];
        desc = desafio['desc'];
      }
    }

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Cores.cinza1,
        content: SizedBox(
          height: 380,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Detalhes do Desafio',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          titulo,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Cores.ciano,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Cores.ciano,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.close,
                          color: Cores.cinza1,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(height: 50),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              Container(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 42),
                  backgroundColor: Cores.ciano,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  //Salvar na api
                  //Atualizar tela
                },
                child: Text(
                  'Aceitar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Cores.cinza1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Cores.ciano,
        centerTitle: true,
        title: Text(
          'INÍCIO',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Cores.cinza1,
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Cores.ciano,
        child: Column(
          children: [
            Container(height: height * .05),
            FutureBuilder(
              future: HomeController.getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map data = snapshot.data as Map;

                  String nome = data['dados_usuario']['nome'];
                  String img = data['dados_usuario']['imagem_url'].replaceAll(
                    'localhost:3000/localhost:3000',
                    'http://10.91.236.188:3000',
                  );

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: Image.network(
                            img,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(width: 20),
                      Text(
                        nome,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Cores.cinza1,
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            Container(height: height * .02),
            ListTile(
              onTap: () => Navigator.pop(context),
              leading: Icon(
                Icons.home,
                color: Cores.cinza1,
              ),
              title: Text(
                'Início',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Cores.cinza1,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/login');
                CacheController.logOut();
              },
              leading: Icon(
                Icons.logout,
                color: Cores.cinza1,
              ),
              title: Text(
                'Sair',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Cores.cinza1,
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          color: Cores.cinza1,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                Container(
                  width: width * .8,
                  height: 67,
                  decoration: BoxDecoration(
                    color: Cores.preto,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        '22 °C',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.bookmark,
                        color: Cores.ciano,
                      ),
                      Container(width: 20),
                      const Text(
                        'Desafio atual:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                FutureBuilder(
                  future: HomeController.getDesafioAtual(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List data = snapshot.data as List;

                      if (data.isEmpty) {
                        return const Text(
                          'Nada selecionado',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }

                      return Column(
                        children: [
                          for (var i in data)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                              child: Container(
                                width: width,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Cores.preto,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.more_horiz,
                                        color: Cores.azul,
                                      ),
                                      Container(width: 5),
                                      Text(
                                        i['titulo'],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.bookmark,
                        color: Cores.ciano,
                      ),
                      Container(width: 20),
                      const Text(
                        'Tarefas atuais:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                FutureBuilder(
                  future: HomeController.getTarefasAtuais(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List data = snapshot.data as List;

                      if (data.isEmpty) {
                        return const Text(
                          'Nada selecionado',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }

                      return Column(
                        children: [
                          for (var i in data)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                              child: Container(
                                width: width,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Cores.preto,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.more_horiz,
                                        color: Cores.vermelho,
                                      ),
                                      Container(width: 5),
                                      Text(
                                        i['titulo'],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: Cores.amarelo,
                      ),
                      Container(width: 20),
                      const Text(
                        'Desafios populares:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: HomeController.getDesafiosPopulares(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List data = snapshot.data as List;
                      desafios = data;

                      if (data.isEmpty) {
                        return const Text(
                          'Nada selecionado',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }

                      return Column(
                        children: [
                          for (var i in data)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                              child: Container(
                                width: width,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Cores.preto,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.more_horiz,
                                        color: Cores.amarelo,
                                      ),
                                      Container(width: 5),
                                      Text(
                                        i['titulo'],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
                Container(height: 23),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width, 42),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Cores.amarelo,
                  ),
                  onPressed: () => showModal(),
                  child: Text(
                    'Desafio aleatório',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Cores.cinza1,
                    ),
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
