import 'package:flutter/material.dart';
import 'package:modulo03/controllers/api.dart';
import 'package:modulo03/styles/styles.dart';

class Troca extends StatefulWidget {
  const Troca({super.key});

  @override
  State<Troca> createState() => _TrocaState();
}

class _TrocaState extends State<Troca> {
  bool corrida = false;
  bool caminhada = true;

  var caminhadaSelecionada;
  var corridaSelecionada;

  int minutosCaminhada = 20;
  int minutosCorrida = 10;

  int valor = 0;
  int coins = 0;

  gerarModalConfirm(int valor, int coins, String msg) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Confirmar troca',
          style: TextStyle(
            fontFamily: Fontes.fonte,
            fontSize: 20,
            color: Cores.ciano,
          ),
        ),
        content: Text(
          '$msg?',
          style: TextStyle(
            fontFamily: Fontes.fonte,
            color: Cores.cinza,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontFamily: Fontes.fonte,
                color: Cores.cinza,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              //Atualizo coins
              await PutCoins.atualizar(
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3RlQGdtYWlsLmNvbSIsImlkX3VzdWFyaW8iOjEsIm5vbWUiOiJ0ZXN0ZSIsImlhdCI6MTcwNDM5MTk3NH0.yop5RbAMWFb9CfgjvX0GB5c87Bx66OrcaNKBSe3yq8Q',
                coins,
              );

              //Desconto minutos
              if (caminhada) {
                minutosCaminhada = minutosCaminhada - valor;
              } else {
                minutosCorrida = minutosCorrida - valor;
              }

              //Feedback
              Navigator.pushNamed(context, '/home');
            },
            child: Text(
              'OK',
              style: TextStyle(
                fontFamily: Fontes.fonte,
                color: Cores.ciano,
              ),
            ),
          ),
        ],
      ),
    );
  }

  gerarModalErro(String titulo, String txt) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          titulo,
          style: TextStyle(
            fontFamily: Fontes.fonte,
            fontSize: 20,
            color: Cores.vermelho,
          ),
        ),
        content: Text(
          txt,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: Fontes.fonte,
            color: Cores.cinza,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text(
              'OK',
              style: TextStyle(
                fontFamily: Fontes.fonte,
                color: Cores.vermelho,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: GetUser.getUser(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3RlQGdtYWlsLmNvbSIsImlkX3VzdWFyaW8iOjEsIm5vbWUiOiJ0ZXN0ZSIsImlhdCI6MTcwNDM5MTk3NH0.yop5RbAMWFb9CfgjvX0GB5c87Bx66OrcaNKBSe3yq8Q',
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //Variaveis
          var dataUser = snapshot.data as Map;

          List<String> opCaminhada = [
            'Trocar 10 minutos por 1 WsCoins.',
            'Trocar 20 minutos por 3 WsCoins.',
            'Trocar 30 minutos por 5 WsCoins.'
          ];
          List<int> opCaminhadaInt = [10, 20, 30];
          List<int> coinCaminhadaInt = [1, 3, 5];

          List<String> opCorrida = [
            'Trocar 10 minutos por 2 WsCoins.',
            'Trocar 20 minutos por 4 WsCoins.',
            'Trocar 30 minutos por 6 WsCoins.'
          ];
          List<int> opCorridaInt = [10, 20, 30];
          List<int> coinCorridaInt = [2, 4, 6];

          return Scaffold(
            body: SizedBox(
              width: width,
              height: height,
              child: Column(
                children: [
                  //Cabeçalho
                  Container(
                    height: height * .35,
                    decoration: BoxDecoration(
                      color: Cores.ciano,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/home'),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(width: 5),
                                Text(
                                  dataUser['usuario'],
                                  style: TextStyle(
                                    fontFamily: Fontes.fonte,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.monetization_on_outlined,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                Container(width: 5),
                                Text(
                                  '${dataUser['wscoins']}',
                                  style: TextStyle(
                                    fontFamily: Fontes.fonte,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        caminhada
                            ? Column(
                                children: [
                                  Text(
                                    'Você possui um saldo de',
                                    style: TextStyle(
                                      fontFamily: Fontes.fonte,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '$minutosCaminhada minutos',
                                    style: TextStyle(
                                      fontFamily: Fontes.fonte,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    'Você possui um saldo de',
                                    style: TextStyle(
                                      fontFamily: Fontes.fonte,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '$minutosCorrida minutos',
                                    style: TextStyle(
                                      fontFamily: Fontes.fonte,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),

                  //Caminhada
                  caminhada
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: SizedBox(
                            height: height * .65,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Desejo trocar meu saldo de',
                                      style: TextStyle(
                                        fontFamily: Fontes.fonte,
                                        fontSize: 15,
                                        color: Cores.cinza,
                                      ),
                                    ),
                                    Container(width: 5),
                                    DropdownButton(
                                      value: corrida ? 'Corrida' : 'Caminhada',
                                      items: [
                                        DropdownMenuItem(
                                          value: 'Corrida',
                                          child: Text(
                                            'Corrida',
                                            style: TextStyle(
                                              fontFamily: Fontes.fonte,
                                              fontSize: 15,
                                              color: Cores.cinza,
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Caminhada',
                                          child: Text(
                                            'Caminhada',
                                            style: TextStyle(
                                              fontFamily: Fontes.fonte,
                                              fontSize: 15,
                                              color: Cores.cinza,
                                            ),
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) => setState(() {
                                        corrida = !corrida;
                                        caminhada = !caminhada;
                                      }),
                                    ),
                                  ],
                                ),
                                for (int i = 0; i < opCaminhada.length; i++)
                                  Row(
                                    children: [
                                      Radio(
                                        value: opCaminhada[i],
                                        groupValue: caminhadaSelecionada,
                                        onChanged: (value) => setState(() {
                                          caminhadaSelecionada = value;
                                          valor = opCaminhadaInt[i];
                                          coins = coinCaminhadaInt[i];
                                        }),
                                      ),
                                      Text(
                                        opCaminhada[i],
                                        style: TextStyle(
                                          fontFamily: Fontes.fonte,
                                          fontSize: 15,
                                          color: Cores.cinza,
                                        ),
                                      ),
                                    ],
                                  ),
                                Container(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    if (caminhadaSelecionada == null) {
                                      gerarModalErro(
                                        'Selecione uma opção',
                                        'Nenhuma opção foi selecionada para troca',
                                      );
                                    } else if (valor > minutosCaminhada) {
                                      gerarModalErro(
                                        'Saldo insuficiente',
                                        'Minutos insuficientes para realizar troca',
                                      );
                                    } else {
                                      gerarModalConfirm(
                                        valor,
                                        coins,
                                        caminhadaSelecionada,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(width * .9, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Confirmar',
                                    style: TextStyle(
                                      fontFamily: Fontes.fonte,
                                      fontSize: 15,
                                      color: Cores.cinza,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )

                      //Corrida
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: SizedBox(
                            height: height * .65,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Desejo trocar meu saldo de',
                                      style: TextStyle(
                                        fontFamily: Fontes.fonte,
                                        fontSize: 15,
                                        color: Cores.cinza,
                                      ),
                                    ),
                                    Container(width: 5),
                                    DropdownButton(
                                      value: corrida ? 'Corrida' : 'Caminhada',
                                      items: [
                                        DropdownMenuItem(
                                          value: 'Corrida',
                                          child: Text(
                                            'Corrida',
                                            style: TextStyle(
                                              fontFamily: Fontes.fonte,
                                              fontSize: 15,
                                              color: Cores.cinza,
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Caminhada',
                                          child: Text(
                                            'Caminhada',
                                            style: TextStyle(
                                              fontFamily: Fontes.fonte,
                                              fontSize: 15,
                                              color: Cores.cinza,
                                            ),
                                          ),
                                        ),
                                      ],
                                      onChanged: (value) => setState(() {
                                        corrida = !corrida;
                                        caminhada = !caminhada;
                                      }),
                                    ),
                                  ],
                                ),
                                for (int i = 0; i < opCorrida.length; i++)
                                  Row(
                                    children: [
                                      Radio(
                                        value: opCorrida[i],
                                        groupValue: corridaSelecionada,
                                        onChanged: (value) => setState(() {
                                          corridaSelecionada = value;
                                          valor = opCorridaInt[i];
                                          coins = coinCorridaInt[i];
                                        }),
                                      ),
                                      Text(
                                        opCorrida[i],
                                        style: TextStyle(
                                          fontFamily: Fontes.fonte,
                                          fontSize: 15,
                                          color: Cores.cinza,
                                        ),
                                      ),
                                    ],
                                  ),
                                Container(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    if (corridaSelecionada == null) {
                                      gerarModalErro(
                                        'Selecione uma opção',
                                        'Nenhuma opção foi selecionada para troca',
                                      );
                                    } else if (valor > minutosCorrida) {
                                      gerarModalErro(
                                        'Saldo insuficiente',
                                        'Minutos insuficientes para realizar troca',
                                      );
                                    } else {
                                      gerarModalConfirm(
                                        valor,
                                        coins,
                                        corridaSelecionada,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(width * .9, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Confirmar',
                                    style: TextStyle(
                                      fontFamily: Fontes.fonte,
                                      fontSize: 15,
                                      color: Cores.cinza,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
