class Validator {
  static validar(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static validarCnSenha(String nSenha, String cnSenha) {
    if (cnSenha.isEmpty) {
      return 'Campo obrigatório';
    }
    if (nSenha != cnSenha) {
      return 'Senhas são diferentes';
    }
    return null;
  }
}
