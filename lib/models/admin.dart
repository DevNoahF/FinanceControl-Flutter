import 'dart:convert';

import 'package:crypto/crypto.dart';

class Admin {
  final String email;
  final String senha;
  final String role;

  const Admin({
    required this.email,
    required String senha,
    this.role = 'adm',
  }) : senha = senha;

  static String hashSenha(String senha) {
    return sha256.convert(utf8.encode(senha.trim())).toString();
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      email: map['email'] as String,
      senha: map['senha_hash'] as String? ?? map['senha'] as String? ?? '',
      role: map['role'] as String? ?? 'adm',
    );
  }

  factory Admin.fromJson(Map<String, dynamic> json) => Admin.fromMap(json);

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'senha_hash': senha,
      'role': role,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  Admin copyWith({
    String? email,
    String? senha,
    String? role,
  }) {
    return Admin(
      email: email ?? this.email,
      senha: senha ?? this.senha,
      role: role ?? this.role,
    );
  }
}