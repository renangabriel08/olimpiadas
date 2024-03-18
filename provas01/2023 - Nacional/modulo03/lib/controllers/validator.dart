class Validator {
  static login(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static nome(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (!value.contains(' ')) {
      return 'Formato inválido';
    }
    if (value.indexOf(' ') == 0 || value.indexOf(' ') == value.length - 1) {
      return 'Formato inválido';
    }
    return null;
  }

  static email(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value[0].contains(RegExp(r'[0-9]'))) {
      return 'Formato inválido';
    }
    if (!value.contains('@')) {
      return 'Formato inválido';
    }
    if (value.indexOf('@') < 6) {
      return 'Formato inválido';
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[0-9]')) ||
          !value[i].contains(RegExp(r'[a-z]')) ||
          value[i] != '_' ||
          value[i] != '.') {
        return 'Formato inválido';
      }
    }
    return null;
  }

  static senha(String value) {
    int n = 0;
    int min = 0;
    int mai = 0;

    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length < 8) {
      return 'Formato inválido';
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[0-9]')) ||
          !value[i].contains(RegExp(r'[a-z]')) ||
          !value[i].contains(RegExp(r'[A-Z]')) ||
          value[i] != '_' ||
          value[i] != '.') {
        return 'Formato inválido';
      }
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

    if (mai < 1 || min < 1 || n < 2) {
      return 'Formato inválido';
    }
    return null;
  }

  static cSenha(String value, String senha) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value != senha) {
      return 'Senhas diferentes';
    }
    return null;
  }
}
