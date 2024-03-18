import 'package:flutter/material.dart';
import 'package:modulo04/controllers/esqSenha.dart';
import 'package:modulo04/controllers/validator.dart';
import 'package:modulo04/styles/styles.dart';
import 'package:modulo04/widgets/forca.dart';
import 'package:modulo04/widgets/toast.dart';

class EsqSenha extends StatefulWidget {
  const EsqSenha({super.key});

  @override
  State<EsqSenha> createState() => _EsqSenhaState();
}

class _EsqSenhaState extends State<EsqSenha> {
  final _formKey = GlobalKey<FormState>();

  String senha = '';
  String nSenha = '';
  String cnSenha = '';

  bool obscureText1 = true;
  bool obscureText2 = true;
  bool obscureText3 = true;

  int forca = 0;

  verificarSenha(value) {
    nSenha = value;
    forca = 0;

    if (senha.length >= 8) {
      forca++;
    }

    if (senha.contains(RegExp(r'[0-9]'))) {
      forca++;
    }

    if (senha.contains(RegExp(r'[A-Z]'))) {
      forca++;
    }

    for (int i = 0; i < senha.length; i++) {
      if (!senha[i].contains(RegExp(r'[A-Z]')) &&
          !senha[i].contains(RegExp(r'[a-z]')) &&
          !senha[i].contains(RegExp(r'[0-9]'))) {
        forca++;
      }
    }

    setState(() {});
  }

  salvar() async {
    if (_formKey.currentState!.validate()) {
      bool igual = await EsqSenhaController.getSenha(senha);

      if (igual) {
        EsqSenhaController.update(nSenha);
      } else {
        MyToast.gerarToast('Senha atual incorreta');
      }
    } else {
      MyToast.gerarToast('Preencha os campos corretamente');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Cores.verde,
        automaticallyImplyLeading: true,
        title: Textos.getText(
          'Alteração de Senha',
          14,
          FontWeight.w700,
          Cores.cinza1,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: width,
        height: height,
        color: Cores.cinza1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    obscureText: obscureText1,
                    onChanged: (value) => senha = value,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => Validator.validar(senha),
                    decoration: InputDecoration(
                      label: Textos.getText(
                        'Senha atual',
                        16,
                        FontWeight.w400,
                        Cores.branco,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () => setState(
                          () => obscureText1 = !obscureText1,
                        ),
                        icon: Icon(
                          obscureText1
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: obscureText2,
                    onChanged: (value) => verificarSenha(value),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) => Validator.validar(nSenha),
                    decoration: InputDecoration(
                      label: Textos.getText(
                        'Nova senha',
                        16,
                        FontWeight.w400,
                        Cores.branco,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () =>
                            setState(() => obscureText2 = !obscureText2),
                        icon: Icon(
                          obscureText2
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: obscureText3,
                    onChanged: (value) => cnSenha = value,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) =>
                        Validator.validarCnSenha(nSenha, cnSenha),
                    decoration: InputDecoration(
                      label: Textos.getText(
                        'Confirme a nova senha',
                        16,
                        FontWeight.w400,
                        Cores.branco,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () =>
                            setState(() => obscureText3 = !obscureText3),
                        icon: Icon(
                          obscureText3
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                  ),
                  Container(height: 50),
                  forca == 1
                      ? ForcaSenha.returnFraca(width)
                      : forca == 2
                          ? ForcaSenha.returnMedia(width)
                          : forca == 3
                              ? ForcaSenha.returnBoa(width)
                              : forca == 4
                                  ? ForcaSenha.returnForte(width)
                                  : Container(),
                  Textos.getText(
                    forca == 1
                        ? 'Senha fraca'
                        : forca == 2
                            ? 'Senha média'
                            : forca == 3
                                ? 'Senha boa'
                                : forca == 4
                                    ? 'Senha forte'
                                    : '',
                    16,
                    FontWeight.w400,
                    Cores.branco,
                  ),
                  Container(height: 50),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(width, 42),
                      backgroundColor: Cores.verde,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => salvar(),
                    icon: Icon(
                      Icons.save,
                      color: Cores.cinza1,
                    ),
                    label: Textos.getText(
                      'Alterar',
                      16,
                      FontWeight.w900,
                      Cores.cinza1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
