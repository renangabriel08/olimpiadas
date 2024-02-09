import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modulo04/controllers/perfil.dart';
import 'package:modulo04/controllers/tarefa.dart';
import 'package:modulo04/styles/styles.dart';
import 'package:modulo04/widgets/toast.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Tarefa extends StatefulWidget {
  const Tarefa({super.key});

  @override
  State<Tarefa> createState() => _TarefaState();
}

class _TarefaState extends State<Tarefa> {
  File? image;
  bool started = false;
  int passos = 0;
  int meta = 100;

  double events = 0;

  start() {
    started = true;
    setState(() {});
    accelerometerEvents.listen(
      (AccelerometerEvent event) {
        if (started) {
          if (passos == meta) {
            started = false;
            setState(() {});
          }
          if (event.x + event.y + event.z > 12 &&
              event.x + event.y + event.z != events) {
            events = event.x + event.y + event.z;
            passos++;
            setState(() {});
          }
        }
      },
      onError: (error) {},
      cancelOnError: true,
    );
  }

  pause() {
    started = false;
    setState(() {});
  }

  enviar() {
    TarefaController.update(passos);
  }

  setarVariaveis(value) {
    image = File(value['imagem']);

    setState(() {});
  }

  @override
  void initState() {
    Future.wait([PerfilController.getData()]).then(
      (value) => setarVariaveis(value[0]),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Cores.verde,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Textos.getText(
              'Detalhes da Tarefa',
              14,
              FontWeight.w700,
              Cores.cinza1,
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/perfil'),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Cores.preto),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: image == null
                    ? Center(
                        child: Icon(
                          Icons.person,
                          size: 10,
                          color: Cores.verde,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        width: width,
        height: height,
        color: Cores.cinza1,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Cores.cinza1,
                  border: Border.all(
                    width: 12,
                    color: Cores.preto,
                  ),
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 13,
                      spreadRadius: 9,
                      color: Cores.preto,
                    )
                  ],
                ),
                child: CircularPercentIndicator(
                  radius: 140,
                  lineWidth: 12,
                  percent: passos / meta,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Textos.getText(
                        'Total de Passos',
                        20,
                        FontWeight.w700,
                        Cores.vermelho,
                      ),
                      Textos.getText(
                        '$passos/$meta',
                        40,
                        FontWeight.w700,
                        Cores.vermelho,
                      ),
                    ],
                  ),
                  progressColor: passos / meta > 0.8
                      ? Cores.verde
                      : passos / meta > 0.6
                          ? Cores.azul
                          : passos / meta > 0.4
                              ? Cores.amarelo
                              : passos / meta > 0.2
                                  ? Cores.vermelho
                                  : Cores.cinza2,
                ),
              ),
              Container(height: height * .1),
              started
                  ? ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, 42),
                        backgroundColor: Cores.amarelo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => pause(),
                      icon: Icon(
                        Icons.pause,
                        color: Cores.cinza1,
                      ),
                      label: Textos.getText(
                        'Pausar contagem',
                        16,
                        FontWeight.w900,
                        Cores.cinza1,
                      ),
                    )
                  : ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, 42),
                        backgroundColor: Cores.amarelo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => meta != passos
                          ? start()
                          : MyToast.gerarToast('Você já completou a meta'),
                      icon: Icon(
                        Icons.play_arrow,
                        color: Cores.cinza1,
                      ),
                      label: Textos.getText(
                        'Iniciar',
                        16,
                        FontWeight.w900,
                        Cores.cinza1,
                      ),
                    ),
              Container(height: height * .02),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(width, 42),
                  backgroundColor: Cores.verde,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => started ? null : enviar(),
                icon: Icon(
                  Icons.cloud_upload_rounded,
                  color: Cores.cinza1,
                ),
                label: Textos.getText(
                  'Enviar',
                  16,
                  FontWeight.w900,
                  Cores.cinza1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
