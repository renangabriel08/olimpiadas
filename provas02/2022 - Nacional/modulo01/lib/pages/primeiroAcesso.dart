import 'package:flutter/material.dart';
import 'package:modulo01/controllers/PrimeiroAcesso.dart';
import 'package:modulo01/controllers/cache.dart';
import 'package:modulo01/controllers/validator.dart';
import 'package:modulo01/styles/styles.dart';

class PrimeiroAcesso extends StatefulWidget {
  const PrimeiroAcesso({super.key});

  @override
  State<PrimeiroAcesso> createState() => _PrimeiroAcessoState();
}

class _PrimeiroAcessoState extends State<PrimeiroAcesso> {
  final _formKey = GlobalKey<FormState>();
  String data = 'Data de nascimento';
  String nascimento = '';
  String peso = '';
  String altura = '';

  double imc = 0.0;
  String imcMsg = 'Preencha os campos para calcular';

  calcularIMC() {
    if (peso != '' && altura != '') {
      int ps = int.parse(peso);
      int al = int.parse(altura);

      imc = ps / ((al / 100) * (al / 100));

      if (imc < 18.5) {
        imcMsg =
            'Seu IMC é de: ${imc.toString().substring(0, 5)}, o que indica MAGREZA!';
      }
      if (imc > 18.5 && imc < 24.9) {
        imcMsg =
            'Seu IMC é de: ${imc.toString().substring(0, 5)}, o que indica NORMAL!';
      }
      if (imc > 25 && imc < 29.9) {
        imcMsg =
            'Seu IMC é de: ${imc.toString().substring(0, 5)}, o que indica SOBREPESO!';
      }
      if (imc > 30 && imc < 39.9) {
        imcMsg =
            'Seu IMC é de: ${imc.toString().substring(0, 5)}, o que indica OBESIDADE!';
      }
      if (imc >= 40) {
        imcMsg =
            'Seu IMC é de: ${imc.toString().substring(0, 5)}, o que indica OBESIDADE GRAVE!';
      }

      setState(() {});
    }
  }

  atualizar() async {
    String token = await CacheController.getToken() ?? '';

    PrimeiroAcessoController.atualizar(
      token,
      peso,
      altura,
      nascimento,
    );
  }

  calendario() {
    showDatePicker(
      context: context,
      firstDate: DateTime(
        DateTime.now().year - 100,
        DateTime.now().month,
        DateTime.now().day,
      ),
      lastDate: DateTime(
        DateTime.now().year - 18,
        DateTime.now().month,
        DateTime.now().day,
      ),
      initialDate: DateTime(
        DateTime.now().year - 18,
        DateTime.now().month,
        DateTime.now().day,
      ),
    ).then(
      (value) => setState(() {
        data = '${value!.day}/${value.month}/${value.year}';
        nascimento = '${value.year}-${value.month}-${value.day}';
      }),
    );
  }

  horario(ex) {
    showTimePicker(context: context, initialTime: TimeOfDay.now()).then(
      (value) => setState(() => ex['hora'] = '${value!.hour}: ${value.minute}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: MyText(
          txt: 'Cadastro de perfil',
          size: 22,
          textAlign: TextAlign.center,
          cor: Cores.cinza,
        ),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  txt: 'Seja bem-vindo(a)',
                  size: 28,
                  textAlign: TextAlign.center,
                  cor: Cores.ciano,
                ),
                MyText(
                  txt:
                      'Como esse é seu primeiro acesso, precisamos de mais algumas informações para continuar',
                  size: 16,
                  textAlign: TextAlign.center,
                  cor: Cores.cinza,
                ),
                Container(height: height * .03),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Cores.cinza),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                txt: data,
                                size: 16,
                                textAlign: TextAlign.start,
                                cor: Cores.cinza,
                              ),
                              IconButton(
                                onPressed: () => calendario(),
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        onChanged: (value) {
                          peso = value;
                          calcularIMC();
                        },
                        validator: (value) => Validator.acesso(peso),
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontFamily: Fonts.font),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Peso (Kg)',
                          labelStyle: TextStyle(fontFamily: Fonts.font),
                          prefixIcon: const Icon(Icons.balance),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        onChanged: (value) {
                          altura = value;
                          calcularIMC();
                        },
                        validator: (value) => Validator.acesso(altura),
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontFamily: Fonts.font),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Altura (cm)',
                          labelStyle: TextStyle(fontFamily: Fonts.font),
                          prefixIcon: const Icon(Icons.accessibility),
                        ),
                      ),
                      MyText(
                        txt: 'IMC: $imcMsg',
                        size: 16,
                        textAlign: TextAlign.start,
                        cor: Cores.cinza,
                      ),
                      Container(height: height * .03),
                      MyText(
                        txt: 'Treino semanal',
                        size: 28,
                        textAlign: TextAlign.center,
                        cor: Cores.ciano,
                      ),
                      Column(
                        children: [
                          for (var ex in PrimeiroAcessoController.data)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: ex['value'],
                                          onChanged: (value) => setState(() {
                                            ex['value'] = value;
                                          }),
                                        ),
                                        MyText(
                                          txt: ex['exercicio'],
                                          size: 12,
                                          textAlign: TextAlign.center,
                                          cor: Cores.cinza,
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () => ex['value'] == true
                                          ? horario(ex)
                                          : null,
                                      child: Container(
                                        width: 100,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Cores.cinza),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            MyText(
                                              txt: ex['hora'],
                                              size: 12,
                                              textAlign: TextAlign.center,
                                              cor: Cores.cinza,
                                            ),
                                            const Icon(Icons.timer_outlined)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    for (var dias in ex['dias'])
                                      Column(
                                        children: [
                                          Checkbox(
                                              value: dias['value'],
                                              onChanged: (value) {
                                                if (ex['value'] == true) {
                                                  setState(() {
                                                    dias['value'] = value;
                                                  });
                                                }
                                              }),
                                          MyText(
                                            txt: dias['dia'],
                                            size: 16,
                                            textAlign: TextAlign.center,
                                            cor: Cores.cinza,
                                          ),
                                        ],
                                      )
                                  ],
                                )
                              ],
                            )
                        ],
                      ),
                      Container(height: height * .07),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => atualizar(),
                        child: MyText(
                          txt: 'Salvar',
                          size: 16,
                          textAlign: TextAlign.center,
                          cor: Cores.ciano,
                        ),
                      ),
                    ],
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
