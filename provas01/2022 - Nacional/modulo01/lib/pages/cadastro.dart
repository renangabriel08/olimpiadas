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
  String? nome;
  String? email;
  String? usuario;
  String? celular;
  String? senha;
  String? confirmarSenha;
  File? imagem;
  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;

  abrirCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      imagem = File(photo!.path);
    } catch (e) {
      MyToast.gerarToast('Erro ao abrir câmera');
    }
  }

  gerarModal() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Cancelar cadastro',
          style: TextStyle(
            fontFamily: Fontes.fonte,
            color: Cores.cinza,
          ),
        ),
        content: Text(
          'Deseja realmente cancelar seu cadastro no app?',
          style: TextStyle(
            fontFamily: Fontes.fonte,
            color: Cores.cinza,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Não'),
            child: Text(
              'Não',
              style: TextStyle(
                fontFamily: Fontes.fonte,
                color: Cores.cinza,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: Text(
              'Sim',
              style: TextStyle(
                fontFamily: Fontes.fonte,
                color: Cores.cinza,
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: Cores.cinza),
                    ),
                    child: imagem == null
                        ? Center(
                            child: Icon(Icons.person,
                                size: 50, color: Cores.cinza),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: Image.file(
                              imagem!,
                              height: 100,
                            ),
                          ),
                  ),
                  onTap: () async {
                    await abrirCamera();
                    setState(() {});
                  },
                ),
                Container(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        onChanged: (value) => nome = value,
                        validator: (value) =>
                            ValidarDadosCadastro.validarNome(value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                          label: Text(
                            'Nome',
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              color: Cores.cinza,
                            ),
                          ),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => email = value,
                        validator: (value) =>
                            ValidarDadosCadastro.validarEmail(value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                          label: Text(
                            'Email',
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              color: Cores.cinza,
                            ),
                          ),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        onChanged: (value) => celular = value,
                        validator: (value) =>
                            ValidarDadosCadastro.validarCelular(value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                          label: Text(
                            'Celular',
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              color: Cores.cinza,
                            ),
                          ),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        onChanged: (value) => usuario = value,
                        validator: (value) =>
                            ValidarDadosCadastro.validarUsuario(value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                          label: Text(
                            'Usuário',
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              color: Cores.cinza,
                            ),
                          ),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText,
                        validator: (value) =>
                            ValidarDadosCadastro.validarSenha(value),
                        onChanged: (value) => senha = value,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              obscureText = !obscureText;
                            }),
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          border: const OutlineInputBorder(),
                          label: Text(
                            'Senha',
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              color: Cores.cinza,
                            ),
                          ),
                        ),
                      ),
                      Container(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText,
                        onChanged: (value) => confirmarSenha = value,
                        validator: (value) =>
                            ValidarDadosCadastro.validarConfirmarSenha(
                          senha,
                          confirmarSenha,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              obscureText = !obscureText;
                            }),
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          border: const OutlineInputBorder(),
                          label: Text(
                            'Confirmar senha',
                            style: TextStyle(
                              fontFamily: Fontes.fonte,
                              color: Cores.cinza,
                            ),
                          ),
                        ),
                      ),
                      Container(height: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                CadastroController.logar(
                                  email!,
                                  senha!,
                                  nome!,
                                  usuario!,
                                  celular!,
                                  imagem!,
                                  context,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Cadastrar',
                              style: TextStyle(
                                fontFamily: Fontes.fonte,
                                color: Cores.ciano,
                              ),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () => gerarModal(),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Cancelar',
                              style: TextStyle(
                                fontFamily: Fontes.fonte,
                                color: Cores.ciano,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Já possui conta?',
                                style: TextStyle(
                                  fontFamily: Fontes.fonte,
                                  color: Cores.cinza,
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  '/login',
                                ),
                                child: Text(
                                  'Entre',
                                  style: TextStyle(
                                    fontFamily: Fontes.fonte,
                                    color: Cores.ciano,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
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
