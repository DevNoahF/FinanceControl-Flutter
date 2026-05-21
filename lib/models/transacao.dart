class Transacao {
  final int id;
  final int userId;
  final String titulo;
  final String descricao;
  final DateTime data;
  final String tipo;
  final double valor;

  Transacao({
    this.id = 0,
    this.userId = 0,
    required this.titulo,
    required this.descricao,
    DateTime? data,
    String? tipo,
    required this.valor,
    bool? isEntrada,
  })  : data = data ?? DateTime.now(),
        tipo = tipo ?? (isEntrada == null ? 'entrada' : (isEntrada ? 'entrada' : 'saida'));

  bool get isEntrada => tipo.toLowerCase() == 'entrada';

  factory Transacao.fromMap(Map<String, dynamic> map) {
    return Transacao(
      id: map['id'] as int? ?? 0,
      userId: map['user_id'] as int? ?? 0,
      titulo: map['titulo'] as String,
      descricao: map['descricao'] as String,
      data: _parseDate(map['data']) ?? DateTime.now(),
      tipo: map['tipo'] as String? ?? 'entrada',
      valor: (map['valor'] as num).toDouble(),
    );
  }

  factory Transacao.fromJson(Map<String, dynamic> json) => Transacao.fromMap(json);

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'titulo': titulo,
      'descricao': descricao,
      'data': data.toIso8601String(),
      'tipo': tipo,
      'valor': valor,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  Transacao copyWith({
    int? id,
    int? userId,
    String? titulo,
    String? descricao,
    DateTime? data,
    String? tipo,
    double? valor,
    bool? isEntrada,
  }) {
    return Transacao(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      data: data ?? this.data,
      tipo: tipo ?? (isEntrada == null ? this.tipo : (isEntrada ? 'entrada' : 'saida')),
      valor: valor ?? this.valor,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.parse(value as String);
  }
}