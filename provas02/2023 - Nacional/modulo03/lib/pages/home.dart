import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:modulo03/controllers/login.dart';
import 'package:modulo03/styles/styles.dart';
import 'package:slide_countdown/slide_countdown.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> user = {};
  String msg = 'Bom dia';

  @override
  void initState() {
    user = JwtDecoder.decode(LoginController.token);

    if (DateTime.now().hour >= 00 && DateTime.now().hour < 12) {
      msg = 'Bom dia';
    }
    if (DateTime.now().hour >= 12 && DateTime.now().hour < 18) {
      msg = 'Boa tarde';
    } else {
      msg = 'Boa noite';
    }

    super.initState();
  }

  Future<void> modal() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Textos.subtitulo('Atenção', TextAlign.start, Cores.azulEscuro),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Textos.padrao(
                  'Seu tempo de expiração chegou ao fim! Escolha uma opção!',
                  TextAlign.start,
                  Cores.azulClaro,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Textos.padrao(
                'Fechar app',
                TextAlign.start,
                Cores.azulEscuro,
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
            TextButton(
              child: Textos.padrao(
                'Voltar ao login',
                TextAlign.start,
                Cores.azulEscuro,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print(user);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Textos.padrao('Início', TextAlign.start, Cores.verdeEscuro)
          ],
        ),
        centerTitle: true,
        title: SlideCountdownSeparated(
          duration: const Duration(hours: 1, minutes: 30),
          style: TextStyle(fontFamily: Fonts.font, color: Cores.branco),
          onDone: () => modal(),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Textos.subtitulo(
                    '$msg, ${user['name']}!',
                    TextAlign.center,
                    Cores.verdeMedio,
                  ),
                  user['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'] ==
                          'Comum'
                      ? Container()
                      : const FaIcon(FontAwesomeIcons.crown),
                ],
              ),
              Container(height: height * .05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: Image.network(user['fotoPerfil']),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Textos.subtitulo(
                        user['name'],
                        TextAlign.start,
                        Cores.azulEscuro,
                      ),
                      Textos.padrao(
                        user['email'],
                        TextAlign.start,
                        Cores.azulClaro,
                      ),
                      Textos.padrao(
                        user['dr'],
                        TextAlign.start,
                        Cores.azulClaro,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
