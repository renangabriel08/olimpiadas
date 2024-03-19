class Validator {
  static validarLogin(String value) {
    if (value.isEmpty) {
      return 'Campo Obrigatório';
    }
    return null;
  }
}
