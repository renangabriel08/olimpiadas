import 'package:flutter/material.dart';
import 'package:modulo01/controllers/cache.dart';
import 'package:modulo01/controllers/notificacao.dart';
import 'package:modulo01/styles/styles.dart';
import 'package:table_calendar/table_calendar.dart';

class Desejos extends StatefulWidget {
  const Desejos({super.key});

  @override
  State<Desejos> createState() => _DesejosState();
}

class _DesejosState extends State<Desejos> {
  DateTime? _selectedDay = DateTime.now();

  String dia = DateTime.now().day < 10
      ? '0${DateTime.now().day}'
      : DateTime.now().day.toString();
  String mes = DateTime.now().month < 10
      ? '0${DateTime.now().month}'
      : DateTime.now().month.toString();
  String? ano;

  String? diaAtual;

  void formatarDia() {
    _selectedDay!.day < 10
        ? dia = '0${_selectedDay!.day}'
        : dia = _selectedDay!.day.toString();

    _selectedDay!.month < 10
        ? mes = '0${_selectedDay!.month}'
        : mes = _selectedDay!.month.toString();

    ano = _selectedDay!.year.toString();

    diaAtual = '$dia/$mes/$ano';
  }

  modal(titulo, desc, local, data, hora, participantes) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Textos.titulo(titulo, Cores.azulMedio),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: Cores.cinza),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Cores.cinza,
                  ),
                ),
              ),
            ),
          ],
        ),
        content: SizedBox(
          height: 115,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Textos.padrao('Descrição: $desc', Cores.cinza),
              Textos.padrao('Local: $local', Cores.cinza),
              Textos.padrao('Data: $data', Cores.cinza),
              Textos.padrao('Horário: $hora', Cores.cinza),
              Textos.padrao('Participantes: $participantes', Cores.cinza),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    formatarDia();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: FutureBuilder(
          future: Cache.getEventos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data as List;

              List eventosNoDia = [];

              for (int i = 0; i < data.length; i++) {
                if (data[i]['data'] == diaAtual) {
                  eventosNoDia.add(data[i]);
                }
              }

              for (int i = 0; i < eventosNoDia.length; i++) {
                eventosNoDia.sort(
                  (a, b) => a['horario'].compareTo(b['horario']),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    //Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/home'),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Cores.cinza),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Icon(Icons.arrow_back),
                              ),
                            ),
                          ),
                          Container(width: width * .13),
                          Textos.titulo('Lista de desejos', Cores.azulEscuro),
                        ],
                      ),
                    ),

                    //Calendário
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: TableCalendar(
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: DateTime.now(),
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;

                            formatarDia();
                          });
                        },
                      ),
                    ),

                    //Eventos
                    eventosNoDia.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Center(
                              child: Textos.padrao(
                                "Não há eventos para este dia.",
                                Cores.azulEscuro,
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  0,
                                  30,
                                  0,
                                  10,
                                ),
                                child: Center(
                                  child: Textos.padrao(
                                    "Seus eventos neste dia",
                                    Cores.azulEscuro,
                                  ),
                                ),
                              ),
                              Container(
                                height: height * .35,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (int i = 0;
                                          i < eventosNoDia.length;
                                          i++)
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            0,
                                            5,
                                            0,
                                            5,
                                          ),
                                          child: GestureDetector(
                                            onTap: () => modal(
                                              eventosNoDia[i]['titulo'],
                                              eventosNoDia[i]['desc'],
                                              eventosNoDia[i]['local'],
                                              eventosNoDia[i]['data'],
                                              eventosNoDia[i]['horario'],
                                              eventosNoDia[i]['participantes'],
                                            ),
                                            child: Container(
                                              width: width,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Cores.cinza,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 1,
                                                    offset: const Offset(1, 1),
                                                    color: Cores.cinza,
                                                  )
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                  5,
                                                  0,
                                                  5,
                                                  0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Textos.padrao(
                                                      '${eventosNoDia[i]['desc']} - ${eventosNoDia[i]['horario']}',
                                                      Cores.cinza,
                                                    ),
                                                    IconButton(
                                                      onPressed: () async {
                                                        Notificar
                                                            .showNotification(
                                                          eventosNoDia[i]
                                                              ['titulo'],
                                                          'Evento removido dos desejos',
                                                        );
                                                        await Cache
                                                            .deletarEventos(
                                                          eventosNoDia[i],
                                                        );
                                                        setState(() {});
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete_forever,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              print('erro');
              return SingleChildScrollView();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
