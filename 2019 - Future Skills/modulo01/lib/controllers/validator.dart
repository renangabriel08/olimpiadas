class Validar {
  static validarLogin(String value) {
    if (value.isEmpty) {
      return 'Este campo não pode ser vazio';
    }
    return null;
  }

  static validarCsenha(String senha, String cSenha) {
    if (cSenha.isEmpty) {
      return 'Este campo não pode ser vazio';
    }
    if (senha != cSenha) {
      return 'As senhas não podem ser diferentes';
    }
    return null;
  }

  static validarEmail(String value) {
    if (value.isEmpty) {
      return 'Este campo não pode ser vazio';
    }
    if (!value.contains('@')) {
      return 'Email precisa de @';
    }
    if (value.substring(value.length - 4, value.length) != '.com' &&
        value.substring(value.length - 6, value.length) != '.com.br') {
      return 'Email precisa terminar com ".com" ou ".com.br"';
    }

    return null;
  }

  static validarTelefone(String value) {
    if (value.isEmpty) {
      return 'Este campo não pode ser vazio';
    }
    if (value.length < 15) {
      return 'Formato de telefone inválido';
    }
    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[0-9]')) &&
          value[i] != '(' &&
          value[i] != ')' &&
          value[i] != ' ' &&
          value[i] != '-') {
        return 'Contém caractéres inválidos';
      }
    }
    if (value[0] != '(' &&
        value[3] != ')' &&
        value[4] != ' ' &&
        value[10] != '-') {
      return 'Formato de telefone inválido';
    }

    for (int i = 0; i < value.length; i++) {
      if (i != 0 && i != 3 && i != 4 && i != 10) {
        if (!value[i].contains(RegExp(r'[0-9]'))) {
          return 'Formato de telefone inválido';
        }
      }
    }

    return null;
  }
}
