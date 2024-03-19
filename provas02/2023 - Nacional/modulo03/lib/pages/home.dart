import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:modulo03/controllers/login.dart';
import 'package:modulo03/styles/styles.dart';

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print(user);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Textos.padrao('Início', TextAlign.start, Cores.verdeEscuro),
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
              Textos.subtitulo(
                '$msg, ${user['name']}!',
                TextAlign.center,
                Cores.verdeMedio,
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
