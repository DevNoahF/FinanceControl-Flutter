import 'dart:convert';

import 'package:crypto/crypto.dart';

class Usuario {
  final int id;
  final String nome;
  final String sobrenome;
  final String email;
  final String senha;
  final String profissao;
  final int idade;
  final String role;
  final DateTime created_at;
  final DateTime? updated_at;

  const Usuario({
    required this.id,
    required this.nome,
    required this.sobrenome,
    required this.email,
    required String senha,
    this.profissao = '',
    required this.idade,
    this.role = 'user',
    required this.created_at,
    this.updated_at,
  }) : senha = senha;

  static String hashSenha(String senha) {
    return sha256.convert(utf8.encode(senha.trim())).toString();
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'] as int? ?? 0,
      nome: map['nome'] as String,
      sobrenome: map['sobrenome'] as String,
      email: map['email'] as String,
      senha: map['senha_hash'] as String? ?? map['senha'] as String? ?? '',
      profissao: map['profissao'] as String? ?? '',
      idade: map['idade'] as int? ?? 0,
      role: map['role'] as String? ?? 'user',
      created_at: _parseDate(map['created_at']) ?? DateTime.now(),
      updated_at: _parseDate(map['updated_at']),
    );
  }

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario.fromMap(json);

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'sobrenome': sobrenome,
      'email': email,
      'senha_hash': senha,
      'profissao': profissao,
      'idade': idade,
      'role': role,
      'created_at': created_at.toIso8601String(),
      if (updated_at != null) 'updated_at': updated_at!.toIso8601String(),
    };
  }

  Map<String, dynamic> toJson() => toMap();

  Usuario copyWith({
    int? id,
    String? nome,
    String? sobrenome,
    String? email,
    String? senha,
    String? profissao,
    int? idade,
    String? role,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return Usuario(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      sobrenome: sobrenome ?? this.sobrenome,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      profissao: profissao ?? this.profissao,
      idade: idade ?? this.idade,
      role: role ?? this.role,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.parse(value as String);
  }
}
