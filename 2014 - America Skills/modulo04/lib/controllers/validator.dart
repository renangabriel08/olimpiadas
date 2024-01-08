class Validator {
  static validarDados(value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    for (int i = 0; i < value.length; i++) {
      if (!value[i].contains(RegExp(r'[0-9]'))) {
        return 'Apenas números';
      }
    }
    
    return null;
  }
}
