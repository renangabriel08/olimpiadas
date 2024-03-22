import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modulo01/controllers/home.dart';
import 'package:modulo01/styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = true;
  String img = '';
  String nome = '';
  String email = '';

  setar(user) {
    nome = user['nome'];
    email = user['email'];
    img = user['img'].toString().replaceFirst(
          'localhost:3000/localhost:3000',
          'http://10.91.236.150:3000',
        );

    loading = false;

    setState(() {});
  }

  Future<void> modal() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: MyText(
            txt: 'VitaHealth - V1.0',
            size: 20,
            textAlign: TextAlign.start,
            cor: Cores.ciano,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MyText(
                  txt: 'Renan Coelho - Senai928',
                  size: 20,
                  textAlign: TextAlign.start,
                  cor: Cores.cinza,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    Future.wait([HomeController.getUser()]).then((value) => setar(value[0]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => modal(),
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(width: 2, color: Cores.cinza),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: Image.network(img, fit: BoxFit.cover),
                    ),
                  ),
                  Container(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        txt: nome,
                        size: 16,
                        textAlign: TextAlign.start,
                        cor: Cores.ciano,
                      ),
                      MyText(
                        txt: email,
                        size: 16,
                        textAlign: TextAlign.start,
                        cor: Cores.ciano,
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: MyText(
                txt: 'Home',
                size: 16,
                textAlign: TextAlign.start,
                cor: Cores.vermelho,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.accessibility),
              title: MyText(
                txt: 'Exercícios',
                size: 16,
                textAlign: TextAlign.start,
                cor: Cores.vermelho,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.currency_bitcoin),
              title: MyText(
                txt: 'WS coin',
                size: 16,
                textAlign: TextAlign.start,
                cor: Cores.vermelho,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart_sharp),
              title: MyText(
                txt: 'Loja',
                size: 16,
                textAlign: TextAlign.start,
                cor: Cores.vermelho,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: MyText(
                txt: 'Configurações',
                size: 16,
                textAlign: TextAlign.start,
                cor: Cores.vermelho,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: MyText(
                txt: 'Sair',
                size: 16,
                textAlign: TextAlign.start,
                cor: Cores.vermelho,
              ),
              onTap: () => Navigator.pushNamed(context, '/login'),
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: !loading
            ? Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    MyText(
                      txt: 'VitaHealth',
                      size: 24,
                      textAlign: TextAlign.center,
                      cor: Cores.ciano,
                    ),
                    Container(height: 20),
                    MyText(
                      txt:
                          'Para melhorar o bem-estar e manter o corpo das pessoas mais saudáveis, a startup IANES desenvolveu o aplicativo VitaHealth que permite seus usuários obter e monitorar as informações corporais, como também planejar, definir metas e receber notificações sobre as atividades físicas. Para garantir a acessibilidade do seu aplicativo, a startup IANES decidiu criar um projeto para melhorar a usabilidade do aplicativo para todos os seus usuários, incluindo aqueles com restrições de visão, daltonismo, dificuldades auditivas, comprometimento da coordenação motora, deficiências cognitivas e muitas outras deficiências.',
                      size: 16,
                      textAlign: TextAlign.center,
                      cor: Cores.cinza,
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(color: Cores.ciano),
              ),
      ),
    );
  }
}
