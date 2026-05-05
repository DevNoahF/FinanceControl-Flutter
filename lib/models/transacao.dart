class Transacao {
  final String titulo;
  final String descricao;
  final double valor;
  final bool isEntrada;

  Transacao({
    required this.titulo,
    required this.descricao,
    required this.valor,
    required this.isEntrada,
  });

  Transacao copyWith({
    String? titulo,
    String? descricao,
    double? valor,
    bool? isEntrada,
  }) {
    return Transacao(
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      valor: valor ?? this.valor,
      isEntrada: isEntrada ?? this.isEntrada,
    );
  }
}