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
    loading = false;
  }

  Future<void> modal() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
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
                children: [
                  Image.network(img),
                  Column(
                    children: [
                      MyText(
                        txt: nome,
                        size: 20,
                        textAlign: TextAlign.start,
                        cor: Cores.ciano,
                      ),
                      MyText(
                        txt: email,
                        size: 20,
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
              leading: const Icon(Icons.home),
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              MyText(
                txt: 'VitaHealth',
                size: 24,
                textAlign: TextAlign.center,
                cor: Cores.ciano,
              ),
              MyText(
                txt: 'VitaHealth',
                size: 16,
                textAlign: TextAlign.center,
                cor: Cores.cinza,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
