class Validator {
  static validarLogin(String value) {
    if (value.isEmpty) {
      return 'Campo Obrigatório';
    }
    return null;
  }

  static validarNome(String value) {
    if (value.isEmpty) {
      return 'Campo Obrigatório';
    }
    if (!value.contains(' ') ||
        value[0] == ' ' ||
        value[value.length - 1] == ' ') {
      return 'Formato inválido';
    }
    return null;
  }

  static validarEmail(String value) {
    if (value.isEmpty) {
      return 'Campo Obrigatório';
    }

    if (value[0].contains(RegExp(r'[0-9]'))) {
      return 'Campo Obrigatório';
    }

    if (value.indexOf('@') < 6) {
      return 'Formato inválido';
    }

    if (value.substring(value.length - 4, value.length) != '.com' &&
        value.substring(value.length - 7, value.length) != '.com.br') {
      return 'Formato inválido';
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[0-9]')) &&
          !value[i].contains(RegExp(r'[a-z]')) &&
          !value[i].contains(RegExp(r'[A-Z]')) &&
          value[i] != '_' &&
          value[i] != '.' &&
          value[i] != '@') {
        return 'Formato inválido';
      }
    }

    return null;
  }

  static validarSenha(String value) {
    int mai = 0;
    int n = 0;
    int min = 0;

    if (value.isEmpty) {
      return 'Campo Obrigatório';
    }
    if (value.length < 8) {
      return 'Formato inválido';
    }

    for (int i = 0; i < value.length; i++) {
      if (value[i].contains(RegExp(r'[0-9]'))) {
        n++;
      }
      if (value[i].contains(RegExp(r'[a-z]'))) {
        min++;
      }
      if (value[i].contains(RegExp(r'[A-Z]'))) {
        mai++;
      }
    }

    if (n < 2 || min < 1 || mai < 1) {
      return 'Formato inválido';
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[0-9]')) &&
          !value[i].contains(RegExp(r'[a-z]')) &&
          !value[i].contains(RegExp(r'[A-Z]')) &&
          value[i] != '_' &&
          value[i] != '.' &&
          value[i] != '@') {
        return 'Formato inválido';
      }
    }

    return null;
  }

  static validarCsenha(String value, senha) {
    if (value.isEmpty) {
      return 'Campo Obrigatório';
    }
    if (value != senha) {
      return 'Senhas diferentes';
    }
    return null;
  }
}
