class Validator {
  static login(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static acesso(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[0-9]'))) {
        return 'Apenas números';
      }
    }
    return null;
  }

  static nome(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static email(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }

    if (!value.contains('@')) {
      return 'Formato inválido';
    }

    if (value[0].contains(RegExp(r'[0-9]'))) {
      return 'Formato inválido';
    }

    if (value.indexOf('@') < 6) {
      return 'Formato inválido';
    }

    if (value.substring(value.length - 7, value.length) != '.com.br' &&
        value.substring(value.length - 4, value.length) != '.com') {
      return 'Formato inválido';
    }

    if (value.substring(value.indexOf('@') + 1, value.length - 4) == '.com' &&
        value.substring(value.length - 4, value.length).length < 3) {
      return 'Formato inválido';
    }

    if (value.substring(value.indexOf('@') + 1, value.length - 7) ==
            '.com.br' &&
        value.substring(value.length - 7, value.length).length < 3) {
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

  static user(String value) {
    int n = 0;
    int mai = 0;
    int min = 0;

    if (value.isEmpty) {
      return 'Campo obrigatório';
    }

    if (value.length < 6) {
      return 'Formato inválido';
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[0-9]')) &&
          !value[i].contains(RegExp(r'[a-z]')) &&
          !value[i].contains(RegExp(r'[A-Z]')) &&
          value[i] != '_' &&
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

    if (n < 1 || mai < 1 || min < 1) {
      return 'Formato inválido';
    }

    if (value[0].contains(RegExp(r'[0-9]'))) {
      return 'Formato inválido';
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
      return 'Formato inválido';
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[0-9]')) &&
          !value[i].contains(RegExp(r'[a-z]')) &&
          !value[i].contains(RegExp(r'[A-Z]')) &&
          value[i] != '_' &&
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

    if (n < 2 || mai < 1 || min < 1) {
      return 'Formato inválido';
    }

    return null;
  }

  static csenha(String value, String senha) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }

    if (value != senha) {
      return 'Senhas diferentes';
    }
    return null;
  }
}
