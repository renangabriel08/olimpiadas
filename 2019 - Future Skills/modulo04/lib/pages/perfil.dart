import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modulo04/controllers/perfil.dart';
import 'package:modulo04/controllers/validator.dart';
import 'package:modulo04/styles/styles.dart';
import 'package:modulo04/widgets/toast.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final _formKey = GlobalKey<FormState>();

  File? image;
  String cidade = '';
  String email = '';
  String apelido = '';
  String sobrenome = '';
  String nome = '';
  bool edit = false;
  bool sucessoAoEditar = false;

  TextEditingController cidadeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController apelidoController = TextEditingController();
  TextEditingController sobrenomeController = TextEditingController();
  TextEditingController nomeController = TextEditingController();

  abrirCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        image = File(photo.path);
      }
      setState(() {});
    } catch (e) {
      MyToast.gerarToast('Erro ao carregar câmera');
    }
  }

  salvar() async {
    if (_formKey.currentState!.validate() && image != null) {
      sucessoAoEditar = await PerfilController.criar(
        nome,
        apelido,
        cidade,
        sobrenome,
        image!.path,
        email,
      );

      if (sucessoAoEditar) {
        edit = false;
        MyToast.gerarToast('Dados atualizados com sucesso');
      } else {
        edit = true;
        MyToast.gerarToast('Erro ao atualizar dados');
      }

      setState(() {});
    } else {
      MyToast.gerarToast('Preencha todos os dados');
    }
  }

  setarVariaveis(value) {
    image = File(value['imagem']);
    cidade = value['cidade'];
    email = value['email'];
    apelido = value['apelido'];
    sobrenome = value['sobrenome'];
    nome = value['nome'];

    nomeController.text = nome;
    cidadeController.text = cidade;
    emailController.text = email;
    apelidoController.text = apelido;
    sobrenomeController.text = sobrenome;

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
        title: Textos.getText('Perfil', 14, FontWeight.w700, Cores.cinza1),
        centerTitle: true,
      ),
      body: Container(
        width: width,
        height: height,
        color: Cores.cinza1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                Container(
                  width: 151,
                  height: 151,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4, color: Cores.verde),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: image == null
                      ? Center(
                          child: Icon(
                            Icons.person,
                            size: 80,
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
                IconButton(
                  onPressed: () => abrirCamera(),
                  icon: Icon(
                    Icons.camera_alt,
                    color: Cores.verde,
                    size: 36,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: cidadeController,
                        enabled: edit,
                        onChanged: (value) => cidade = value,
                        keyboardType: TextInputType.text,
                        validator: (value) => Validator.validar(cidade),
                        decoration: InputDecoration(
                          label: Textos.getText(
                            'Cidade',
                            16,
                            FontWeight.w400,
                            Cores.branco,
                          ),
                        ),
                      ),
                      TextFormField(
                        enabled: edit,
                        controller: emailController,
                        onChanged: (value) => email = value,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => Validator.validar(email),
                        decoration: InputDecoration(
                          label: Textos.getText(
                            'Email',
                            16,
                            FontWeight.w400,
                            Cores.branco,
                          ),
                        ),
                      ),
                      TextFormField(
                        enabled: edit,
                        controller: nomeController,
                        onChanged: (value) => nome = value,
                        keyboardType: TextInputType.name,
                        validator: (value) => Validator.validar(nome),
                        decoration: InputDecoration(
                          label: Textos.getText(
                            'Nome',
                            16,
                            FontWeight.w400,
                            Cores.branco,
                          ),
                        ),
                      ),
                      TextFormField(
                        enabled: edit,
                        controller: sobrenomeController,
                        onChanged: (value) => sobrenome = value,
                        keyboardType: TextInputType.name,
                        validator: (value) => Validator.validar(sobrenome),
                        decoration: InputDecoration(
                          label: Textos.getText(
                            'Sobrenome',
                            16,
                            FontWeight.w400,
                            Cores.branco,
                          ),
                        ),
                      ),
                      TextFormField(
                        enabled: edit,
                        controller: apelidoController,
                        onChanged: (value) => apelido = value,
                        keyboardType: TextInputType.name,
                        validator: (value) => Validator.validar(apelido),
                        decoration: InputDecoration(
                          label: Textos.getText(
                            'Apelido',
                            16,
                            FontWeight.w400,
                            Cores.branco,
                          ),
                        ),
                      ),
                      Container(height: 50),
                      !edit
                          ? ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(width, 42),
                                backgroundColor: Cores.verde,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () => setState(() {
                                edit = true;
                              }),
                              icon: const Icon(Icons.edit_square),
                              label: Textos.getText(
                                'Editar',
                                16,
                                FontWeight.w900,
                                Cores.cinza1,
                              ),
                            )
                          : ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(width, 42),
                                backgroundColor: Cores.verde,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () => salvar(),
                              icon: const Icon(Icons.save),
                              label: Textos.getText(
                                'Salvar',
                                16,
                                FontWeight.w900,
                                Cores.cinza1,
                              ),
                            ),
                      Container(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width, 42),
                          backgroundColor: Cores.verde,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          '/esqSenha',
                        ),
                        child: Textos.getText(
                          'Redefinir Senha',
                          16,
                          FontWeight.w900,
                          Cores.cinza1,
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
