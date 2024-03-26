import 'package:flutter/material.dart';
import 'package:modulo09/controllers/cadastro.dart';
import 'package:modulo09/controllers/validators.dart';
import 'package:modulo09/styles/styles.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String titulo = '';
  String desc = '';
  String tipoSelecionado = 'Cobrança';

  List<String> tipos = ['Cobrança', 'Performance', 'Serviços', 'Usabilidade'];

  cadastrar() {
    if (_formKey.currentState!.validate()) {
      CadastroController.cadastrar(titulo, desc, tipoSelecionado);
    }
  }

  cancelar() {
    titulo = '';
    tituloController.text = '';

    desc = '';
    descController.text = '';

    tipoSelecionado = 'Cobrança';

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * .9,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Textos.txt2(
                          'Registro de Reclamação',
                          TextAlign.center,
                          Cores.verdeEscuro,
                        ),
                        Container(height: height * .1),
                        TextFormField(
                          controller: tituloController,
                          onChanged: (value) => titulo = value,
                          validator: (value) => Validator.validar(titulo),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Titulo',
                            labelStyle: TextStyle(fontFamily: Fonts.font),
                            prefixIcon: const Icon(Icons.edit),
                          ),
                        ),
                        Container(height: height * .02),
                        TextFormField(
                          controller: descController,
                          onChanged: (value) => desc = value,
                          validator: (value) => Validator.validar(desc),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Descrição',
                            labelStyle: TextStyle(fontFamily: Fonts.font),
                            prefixIcon: const Icon(Icons.comment),
                          ),
                        ),
                        Container(height: height * .02),
                        DropdownButtonFormField(
                          validator: (value) => Validator.validar(
                            tipoSelecionado,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Tipo',
                            labelStyle: TextStyle(fontFamily: Fonts.font),
                            prefixIcon: const Icon(Icons.comment),
                          ),
                          value: tipoSelecionado,
                          items: [
                            for (var tipo in tipos)
                              DropdownMenuItem(
                                value: tipo,
                                child: Text(
                                  tipo,
                                  style: TextStyle(fontFamily: Fonts.font),
                                ),
                              )
                          ],
                          onChanged: (value) => tipoSelecionado = value!,
                        ),
                        Container(height: height * .1),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => cadastrar(),
                          child: Textos.txt1(
                            'Cadastrar',
                            TextAlign.center,
                            Cores.verdeEscuro,
                          ),
                        ),
                        Container(height: height * .02),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => cancelar(),
                          child: Textos.txt1(
                            'Cancelar',
                            TextAlign.center,
                            Cores.verdeEscuro,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .1,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/lista'),
                      child: Container(
                        width: width * .5,
                        height: height * .1,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Cores.azulEscuro),
                        ),
                        child: Center(
                          child: Textos.txt1(
                            'Reclamações',
                            TextAlign.center,
                            Cores.azulEscuro,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => (),
                      child: Container(
                        width: width * .5,
                        height: height * .1,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Cores.azulEscuro),
                          color: Cores.azulEscuro,
                        ),
                        child: Center(
                          child: Textos.txt1(
                            'Cadastro',
                            TextAlign.center,
                            Cores.azulClaro,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
