import 'enums.dart';

class Transacao {
  final int id;
  final int categoriaId;
  final String descricao;
  final Banco banco;
  final DateTime data;
  final TransactionType tipo;
  final double valor;

  const Transacao({
    required this.id,
    required this.categoriaId,
    required this.descricao,
    required this.banco,
    required this.data,
    required this.tipo,
    required this.valor,
  });

  factory Transacao.fromJson(Map<String, dynamic> json) {
    return Transacao(
      id: json['id'] as int,
      categoriaId: json['categoria_id'] as int,
      descricao: json['descricao'] as String,
      banco: Banco.values.byName(json['banco'] as String),
      data: DateTime.parse(json['data'] as String),
      tipo: TransactionType.values.byName(json['tipo'] as String),
      valor: (json['valor'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoria_id': categoriaId,
      'descricao': descricao,
      'banco': banco.name,
      'data': data.toIso8601String(),
      'tipo': tipo.name,
      'valor': valor,
    };
  }

  Transacao copyWith({
    int? id,
    int? categoriaId,
    String? descricao,
    Banco? banco,
    DateTime? data,
    TransactionType? tipo,
    double? valor,
  }) {
    return Transacao(
      id: id ?? this.id,
      categoriaId: categoriaId ?? this.categoriaId,
      descricao: descricao ?? this.descricao,
      banco: banco ?? this.banco,
      data: data ?? this.data,
      tipo: tipo ?? this.tipo,
      valor: valor ?? this.valor,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transacao &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          valor == other.valor &&
          data == other.data;

  @override
  int get hashCode => id.hashCode ^ valor.hashCode ^ data.hashCode;
}