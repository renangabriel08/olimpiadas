class ValidatorController {
  static validarLogin(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }
}
