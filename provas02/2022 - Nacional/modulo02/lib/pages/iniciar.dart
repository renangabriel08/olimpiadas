import 'package:flutter/material.dart';
import 'package:modulo02/controllers/mapa.dart';
import 'package:modulo02/styles/styles.dart';

class Iniciar extends StatefulWidget {
  const Iniciar({super.key});
  static const routeName = '/iniciar';

  @override
  State<Iniciar> createState() => _IniciarState();
}

class IniciarArguments {
  final String tipo;

  IniciarArguments(this.tipo);
}

class _IniciarState extends State<Iniciar> {
  bool loading = true;

  set() {
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([MapaController.getPosition()]).then((value) => set());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final args = ModalRoute.of(context)!.settings.arguments as IniciarArguments;

    return Scaffold(
      appBar: AppBar(
        title: Texto(
          txt: args.tipo,
          textAlign: TextAlign.center,
          size: 16,
          weight: FontWeight.bold,
          cor: Cores.cinza,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: !loading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width,
                    height: height * .65,
                  ),
                  Container(
                    width: width * .3,
                    height: width * .3,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Cores.cinza),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Center(
                      child: Texto(
                        txt: 'INICIAR',
                        textAlign: TextAlign.center,
                        size: 16,
                        weight: FontWeight.normal,
                        cor: Cores.cinza,
                      ),
                    ),
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(color: Cores.ciano),
              ),
      ),
    );
  }
}
