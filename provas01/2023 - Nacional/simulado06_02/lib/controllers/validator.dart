class ValidatorController {
  static validarLogin(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static validarSenha(String value) {
    int lMai = 0;
    int lMin = 0;
    int nums = 0;

    if (value.isEmpty) {
      return 'Campo obrigatório';
    }

    if (value.length < 8) {
      return 'Mínimo de 8 caractéres';
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[a-z]')) &&
          !value[i].contains(RegExp(r'[A-Z]')) &&
          !value[i].contains(RegExp(r'[0-9]')) &&
          value[i] != '_' &&
          value[i] != '.') {
        return 'Contém caractéres invádos';
      }
    }

    for (int i = 0; i < value.length; i++) {
      if (value[i].contains(RegExp(r'[A-Z]'))) {
        lMai++;
      }
      if (value[i].contains(RegExp(r'[a-z]'))) {
        lMin++;
      }
      if (value[i].contains(RegExp(r'[0-9]'))) {
        nums++;
      }
    }

    if (nums < 2) {
      return 'Mínimo dois números';
    }
    if (lMin < 1) {
      return 'Mínimo uma letra minúscula';
    }
    if (lMai < 1) {
      return 'Mínimo uma letra maiúscula';
    }

    return null;
  }

  static validarCsenha(senha, cSenha) {
    if (cSenha.isEmpty) {
      return 'Campo obrigatório';
    }
    if (senha != cSenha) {
      return 'Senhas são diferentes';
    }
    return null;
  }

  static validarEmail(value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.contains(RegExp(r'[A-Z]'))) {
      return 'Apenas letras minúsculas';
    }
    return null;
  }

  static validarApelido(value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (!value[0].contains(RegExp(r'[A-Z]'))) {
      return 'Inicie com letra minúsculas';
    }

    for (int i = 0; i < value.length; i++) {
      if (value[i] == ' ') {
        if (!value[i + 1].contains(RegExp(r'[A-Z]'))) {
          return 'Inicie cada pelavra com letra minúsculas';
        }
      }
    }
    return null;
  }
}
