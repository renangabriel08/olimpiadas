class Validar {
  static validarLogin(String value) {
    if (value.isEmpty) {
      return 'Este campo não pode ser vazio';
    }
    return null;
  }
}
