class Validator {
  static validar(value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static validarPreco(value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[0-9]')) && !value[i].contains('.')) {
        return 'Apenas números e ponto';
      }
    }

    return null;
  }
}
