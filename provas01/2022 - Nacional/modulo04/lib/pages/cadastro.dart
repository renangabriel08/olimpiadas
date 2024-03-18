import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modulo04/controller/api.dart';
import 'package:modulo04/controller/validator.dart';
import 'package:modulo04/styles/styles.dart';
import 'package:modulo04/widgets/modais.dart';
import 'package:modulo04/widgets/toast.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  String? nome;
  String? desc;
  String? preco;

  final _formKey = GlobalKey<FormState>();
  File? image;

  abrirCamera() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        image = File(photo.path);
      }
      setState(() {});
    } catch (e) {
      MyToast.gerarToast('Erro ao abrir câmera');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder(
        future: ApiCntroller.getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map user = snapshot.data as Map;

            return SingleChildScrollView(
              child: Container(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  '/produtos',
                                ),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.white,
                                      )),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                width: 140,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.person),
                                    Text(
                                      user['nome'].toString(),
                                      style: TextStyle(
                                        fontFamily: Fontes.fonte,
                                        color: Cores.cinza,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
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
                                      user['saldoWSCoins'].toString(),
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
                          Text(
                            'Cadastrar Produto',
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        width: width,
                        height: height * .8 - 30,
                        color: Colors.white,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => abrirCamera(),
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Cores.cinza,
                                    ),
                                  ),
                                  child: image == null
                                      ? Icon(
                                          Icons.add_a_photo,
                                          color: Cores.cinza,
                                          size: 50,
                                        )
                                      : Image.file(
                                          image!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Container(height: 15),
                              TextFormField(
                                onChanged: (value) => nome = value,
                                validator: (value) => Validator.validar(value),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.production_quantity_limits,
                                  ),
                                  label: Text(
                                    'Nome',
                                    style: TextStyle(
                                      fontFamily: Fontes.fonte,
                                    ),
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              Container(height: 15),
                              TextFormField(
                                onChanged: (value) => desc = value,
                                validator: (value) => Validator.validar(value),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.text_snippet_outlined,
                                  ),
                                  label: Text(
                                    'Descrição',
                                    style: TextStyle(
                                      fontFamily: Fontes.fonte,
                                    ),
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              Container(height: 15),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: (value) => preco = value,
                                validator: (value) =>
                                    Validator.validarPreco(value),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.attach_money_rounded,
                                  ),
                                  label: Text(
                                    'Valor em WsCoins',
                                    style: TextStyle(
                                      fontFamily: Fontes.fonte,
                                    ),
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              Container(height: 15),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate() &&
                                      image != null) {
                                    await ApiCntroller.cadastrarProduto(
                                      nome,
                                      desc,
                                      preco,
                                      image!,
                                      context,
                                    );
                                  } else {
                                    Modais.showMyDialogErroCadastrar(
                                      context,
                                      'Erro ao cadastrar',
                                      'Atenção! Todos os campos são obrigatórios!',
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  fixedSize: Size(width, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Cadastrar',
                                  style: TextStyle(
                                    fontFamily: Fontes.fonte,
                                    color: Cores.ciano,
                                    fontSize: 15,
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
