class Validar {
  static validar(String value) {
    if (value.isEmpty) {
      return;
    }
    return null;
  }

  static validarTv(String value) {
    if (value.isEmpty) {
      return 'Preencha todos os campos';
    }
    return null;
  }
}
