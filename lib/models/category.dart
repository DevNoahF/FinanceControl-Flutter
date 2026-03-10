import 'enums.dart';

const _undefined = Object();

class Category {
  final String id;
  final String nome;
  final CategoryType tipo;
  final String? descricao;

  const Category({
    required this.id,
    required this.nome,
    required this.tipo,
    this.descricao,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      nome: json['nome'] as String,
      tipo: CategoryType.values.firstWhere(
        (e) => e.name == json['tipo'],
      ),
      descricao: json['descricao'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'tipo': tipo.name,
      if (descricao != null) 'descricao': descricao,
    };
  }

  Category copyWith({
    String? id,
    String? nome,
    CategoryType? tipo,
    Object? descricao = _undefined,
  }) {
    return Category(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      tipo: tipo ?? this.tipo,
      descricao: identical(descricao, _undefined)
          ? this.descricao
          : descricao as String?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Category(id: $id, nome: $nome, tipo: $tipo, descricao: $descricao)';
  }
}