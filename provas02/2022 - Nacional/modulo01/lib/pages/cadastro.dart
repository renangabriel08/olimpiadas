import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modulo01/controllers/cadastro.dart';
import 'package:modulo01/controllers/validator.dart';
import 'package:modulo01/styles/styles.dart';
import 'package:modulo01/widgets/toast.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  File? img;
  String nome = '';
  String email = '';
  String celular = '';
  String user = '';
  String senha = '';
  String csenha = '';
  bool obscureText1 = true;
  bool obscureText2 = true;

  tirarFoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        img = File(image.path);
      }

      setState(() {});
    } catch (e) {
      MyToast.get('Erro ao abrir câmera');
    }
  }

  cadastrar() async {
    if (_formKey.currentState!.validate() && img != null) {
      await CadastroController.cadastrar(
        img!,
        email,
        celular,
        user,
        senha,
        nome,
      );
    } else {
      MyToast.get('Preencha todos os campos');
    }

    setState(() {});
  }

  esconderSenha1() {
    setState(() {
      obscureText1 = !obscureText1;
    });
  }

  esconderSenha2() {
    setState(() {
      obscureText2 = !obscureText2;
    });
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/login'),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(width: 1, color: Cores.cinza),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back,
                          ),
                        ),
                      ),
                    ),
                    MyText(
                      txt: 'Cadastro de Usuário',
                      size: 28,
                      textAlign: TextAlign.center,
                      cor: Cores.ciano,
                    ),
                  ],
                ),
                Container(height: height * .07),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => tirarFoto(),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: Cores.cinza),
                            color: Cores.branco,
                          ),
                          child: img != null
                              ? ClipRRect(
                                  child: Image.file(
                                    img!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Center(
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 50,
                                    color: Cores.cinza,
                                  ),
                                ),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        onChanged: (value) => nome = value,
                        validator: (value) => Validator.nome(nome),
                        keyboardType: TextInputType.name,
                        style: TextStyle(fontFamily: Fonts.font),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Nome',
                          labelStyle: TextStyle(fontFamily: Fonts.font),
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        onChanged: (value) => email = value,
                        validator: (value) => Validator.email(email),
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontFamily: Fonts.font),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(fontFamily: Fonts.font),
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        onChanged: (value) => celular = value,
                        validator: (value) => Validator.login(celular),
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontFamily: Fonts.font),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Celular',
                          labelStyle: TextStyle(fontFamily: Fonts.font),
                          prefixIcon: const Icon(Icons.call_outlined),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        onChanged: (value) => user = value,
                        validator: (value) => Validator.user(user),
                        keyboardType: TextInputType.name,
                        style: TextStyle(fontFamily: Fonts.font),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Usuário',
                          labelStyle: TextStyle(fontFamily: Fonts.font),
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        obscureText: obscureText1,
                        onChanged: (value) => senha = value,
                        validator: (value) => Validator.senha(senha),
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(fontFamily: Fonts.font),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Senha',
                          labelStyle: TextStyle(fontFamily: Fonts.font),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () => esconderSenha1(),
                            icon: Icon(
                              obscureText1
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        obscureText: obscureText2,
                        onChanged: (value) => csenha = value,
                        validator: (value) => Validator.csenha(csenha, senha),
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(fontFamily: Fonts.font),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Confirmar senha',
                          labelStyle: TextStyle(fontFamily: Fonts.font),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () => esconderSenha2(),
                            icon: Icon(
                              obscureText2
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                      ),
                      Container(height: height * .07),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => cadastrar(),
                        child: MyText(
                          txt: 'Cadastrar',
                          size: 16,
                          textAlign: TextAlign.center,
                          cor: Cores.ciano,
                        ),
                      ),
                      Container(height: 10),
                      OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => Navigator.pushNamed(context, '/login'),
                        child: MyText(
                          txt: 'Cancelar',
                          size: 16,
                          textAlign: TextAlign.center,
                          cor: Cores.cinza,
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
