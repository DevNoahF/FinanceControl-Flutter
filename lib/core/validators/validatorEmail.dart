String? ValidatorEmail(String? value) {
  final email = value?.trim() ?? '';

  if (email.isEmpty) {
    return 'O e-mail é obrigatório';
  }

  if (!email.contains('@') || email.startsWith('@') || email.endsWith('@')) {
    return 'Informe um e-mail válido';
  }

  return null;
}