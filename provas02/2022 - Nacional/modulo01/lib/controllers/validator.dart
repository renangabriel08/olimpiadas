class Validator {
  static login(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }
}
