import 'package:flutter/material.dart';
import 'package:modulo04/controller/api.dart';
import 'package:modulo04/styles/styles.dart';

class Produtos extends StatefulWidget {
  const Produtos({super.key});

  @override
  State<Produtos> createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder(
        future:
            Future.wait([ApiCntroller.getUser(), ApiCntroller.getProdutos()]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List response = snapshot.data as List;

            Map dataUser = response[0];
            List dataProdutos = response[1]['resultado'];

            var idUser = dataUser['id_usuario'];

            return Scaffold(
              body: Container(
                width: width,
                height: height,
                color: Colors.white,
                child: Column(
                  children: [
                    //Header
                    Container(
                      width: width,
                      height: height * .2,
                      decoration: BoxDecoration(
                        color: Cores.ciano,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Loja de Produtos',
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.attach_money_rounded),
                                Text(
                                  dataUser['saldoWSCoins'].toString(),
                                  style: TextStyle(
                                    fontFamily: Fontes.fonte,
                                    color: Cores.cinza,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Produtos
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: width,
                        height: height * .8 - 16,
                        color: Colors.white,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (int i = 0; i < dataProdutos.length; i++)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: width * .9,
                                    height: 500,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 1,
                                          offset: const Offset(1, 1),
                                          color: Cores.cinza,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: 90,
                                              height: 90,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Cores.cinza),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10,
                                                  ),
                                                  child: Image.network(
                                                    dataProdutos[i]['img_url']
                                                        .replaceRange(
                                                      0,
                                                      21,
                                                      'http://192.168.86.103:3000/assets/',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 200,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    dataProdutos[i]['nome']
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontFamily: Fontes.fonte,
                                                      color: Cores.cinza,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Text(
                                                    'POR APENAS ${dataProdutos[i]['preco'].toString()},00',
                                                    style: TextStyle(
                                                      fontFamily: Fontes.fonte,
                                                      color: Cores.ciano,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: width * .8,
                                          child: Text(
                                            dataProdutos[i]['descricao']
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: Fontes.fonte,
                                              color: Cores.cinza,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        idUser !=
                                                dataProdutos[i]
                                                    ['id_usuario_created']
                                            ? ElevatedButton.icon(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.shopping_cart,
                                                  color: Cores.ciano,
                                                ),
                                                label: Text(
                                                  'Comprar',
                                                  style: TextStyle(
                                                    fontFamily: Fontes.fonte,
                                                    color: Cores.ciano,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  fixedSize:
                                                      Size(width * .8, 30),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : ElevatedButton.icon(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Cores.ciano,
                                                ),
                                                label: Text(
                                                  'Excluir',
                                                  style: TextStyle(
                                                    fontFamily: Fontes.fonte,
                                                    color: Cores.ciano,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  fixedSize:
                                                      Size(width * .8, 30),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
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
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Cores.ciano,
                child: const Icon(
                  Icons.add,
                  size: 35,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
