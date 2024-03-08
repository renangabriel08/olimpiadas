class Validator {
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
    if (!value.contains('@')) {
      return 'Formato inválido';
    }
    if (value.indexOf('@') < 7) {
      return 'Formato inválido';
    }
    return null;
  }
}
