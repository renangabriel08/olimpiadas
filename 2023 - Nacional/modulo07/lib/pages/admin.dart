import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modulo07/controllers/firebase.dart';
import 'package:modulo07/styles/styles.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});
  static const routeName = '/admin';

  @override
  State<Admin> createState() => _AdminState();
}

class ScreenArguments {
  final String id;
  final String user;
  final String local;
  final String cidade;
  final String comentario;
  final int estrelas;
  final String image;
  final String data;
  final String status;

  ScreenArguments(
    this.id,
    this.user,
    this.local,
    this.cidade,
    this.comentario,
    this.estrelas,
    this.image,
    this.data,
    this.status,
  );
}

class _AdminState extends State<Admin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _localController = TextEditingController();
  final TextEditingController _comentarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    _cidadeController.text = args.cidade;
    _nomeController.text = args.user;
    _localController.text = args.local;
    _comentarioController.text = args.comentario;

    aprovarErejeitar(status) {
      FirebaseController.atualizarAvaliacao(
        args.id,
        args.user,
        args.local,
        args.cidade,
        args.comentario,
        args.estrelas,
        args.image,
        args.data,
        status,
        context,
      );
    }

    List estrelas = [];

    for (int e = 0; e < args.estrelas; e++) {
      estrelas.add(
        const Icon(
          Icons.star,
          color: Colors.yellow,
        ),
      );
    }

    if (estrelas.length < 5) {
      for (int a = estrelas.length; a < 5; a++) {
        estrelas.add(
          const Icon(Icons.star_border),
        );
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: width * .43,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Cores.azulEscuro),
                          color: Cores.azulEscuro,
                        ),
                        child: Center(
                          child: Textos.padrao('Admin', Cores.verdeEscuro),
                        ),
                      ),
                      Container(
                        width: width * .43,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Cores.azulEscuro),
                        ),
                        child: Center(
                          child: Textos.padrao(
                            'Lista de avaliações',
                            Cores.verdeEscuro,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Textos.titulo(
                    'Admin',
                    Cores.azulEscuro,
                  ),
                  Container(height: height * .05),
                  SizedBox(
                    width: width * .5,
                    height: width * .50,
                    child: ClipRRect(
                      borderRadius: BorderRadiusDirectional.circular(8),
                      child: Image.file(
                        File(args.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(height: height * .05),
                  //
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _localController,
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Textos.padrao('Local', Cores.azulEscuro),
                      prefixIcon: const Icon(Icons.pin_drop_outlined),
                    ),
                  ),
                  Container(height: height * .02),
                  //
                  TextFormField(
                    controller: _cidadeController,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Textos.padrao('Cidade', Cores.azulEscuro),
                      prefixIcon: const Icon(Icons.map),
                    ),
                  ),
                  Container(height: height * .02),
                  //
                  TextFormField(
                    controller: _nomeController,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Textos.padrao('Usuário', Cores.azulEscuro),
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  Container(height: height * .02),
                  //
                  TextFormField(
                    controller: _comentarioController,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    maxLines: 7,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Container(height: height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          for (int i = 0; i < estrelas.length; i++) estrelas[i]
                        ],
                      ),
                      Container(
                        width: width * .35,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Cores.azulEscuro),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Textos.padrao(args.data, Cores.verdeEscuro),
                            const Icon(Icons.calendar_month)
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(height: height * .02),
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () => aprovarErejeitar('Rejeitada'),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width * .4, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Textos.padrao('Rejeitar', Cores.azulEscuro),
                      ),
                      ElevatedButton(
                        onPressed: () => aprovarErejeitar('Aprovada'),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width * .4, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Textos.padrao('Aprovar', Cores.azulEscuro),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
