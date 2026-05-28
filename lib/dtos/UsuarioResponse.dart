
class Usuarioresponse {
  final int id;
  final String nome;
  final String email;
  final String idade;

  const Usuarioresponse({
    required this.id,
    required this.nome,
    required this.email,
    required this.idade,
  });

  factory Usuarioresponse.fromJson(Map<String, dynamic> json) {
    return Usuarioresponse(
      id: json['id'] as int,
      nome: json['nome'] as String,
      email: json['email'] as String,
      idade: json['idade'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nome': nome, 'email': email, 'idade': idade};
  }
}
