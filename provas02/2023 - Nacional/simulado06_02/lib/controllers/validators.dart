class Validators {
  static login(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static email(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[a-z]')) &&
          !value[i].contains(RegExp(r'[0-9]')) &&
          value[i] != '_' &&
          value[i] != '@' &&
          value[i] != '.') {
        return 'Formato inválido';
      }
    }

    return null;
  }

  static senha(String value) {
    int n = 0;
    int mai = 0;
    int min = 0;

    if (value.isEmpty) {
      return 'Campo obrigatório';
    }

    if (value.length < 8) {
      return 'Mínimo 8 caracteres';
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[a-z]')) &&
          !value[i].contains(RegExp(r'[A-Z]')) &&
          !value[i].contains(RegExp(r'[0-9]')) &&
          value[i] != '_' &&
          value[i] != '.') {
        return 'Formato inválido';
      }
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[a-z]'))) {
        min++;
      }
      if (!value[i].contains(RegExp(r'[A-Z]'))) {
        mai++;
      }
      if (!value[i].contains(RegExp(r'[0-9]'))) {
        n++;
      }
    }

    if (min < 1 && mai < 1 && n < 2) {
      return 'Formato inválido';
    }

    return null;
  }

  static csenha(String value, String senha) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }

    if (value != senha) {
      return 'Senhas são diferentes';
    }
    return null;
  }

  static nomeApelido(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[a-z]')) &&
          !value[i].contains(RegExp(r'[A-Z]')) &&
          value[i] != ' ') {
        return 'Formato inválido';
      }
    }

    for (int i = 0; i < value.length; i++) {
      if (i > 0) {
        if (value[i].contains(RegExp(r'[a-z]')) && value[i - 1] == ' ') {
          return 'Formato inválido';
        }
      } else {
        if (!value[i].contains(RegExp(r'[A-Z]'))) {
          return 'Formato inválido';
        }
      }
    }

    return null;
  }
}
