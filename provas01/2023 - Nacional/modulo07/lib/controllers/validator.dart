class Validator {
  static validar(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }
}
