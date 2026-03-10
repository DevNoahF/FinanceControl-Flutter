class Usuario{
  final int id;
  final String nome;
  final String sobrenome;
  final String email;
  final String senha;
  final String profissao;
  final int idade;
  final DateTime created_at;
  final DateTime? updated_at;

  const Usuario({
    required this.id,
    required this.nome,
    required this.sobrenome,
    required this.email,
    required this.senha,
    required this.profissao,
    required this.idade,
    required this.created_at,
    this.updated_at
  });

  factory Usuario.fromJson(Map<String, dynamic> json){
    return Usuario(
      id: json['id'] as int,
      nome: json['nome'] as String,
      sobrenome: json['sobrenome'] as String,
      email: json["email"] as String,
      senha: json["senha"] as String,
      profissao: json["profissao"] as String,
      idade: json["idade"] as int,
      created_at: DateTime.parse(json["created_at"]),
      updated_at: json["updated_at"] as DateTime?,
    );
  }

  Map<String, dynamic> toJson(){
    return{
      "id": id,
      "nome": nome,
      "sobrenome": sobrenome,
      "email":email,
      "senha":senha,
      "profissao":profissao,
      "idade":idade,
      "created_at":created_at,
      if(updated_at !=null) "updated_at":updated_at,
      "updated_at":updated_at,
    };
  }


  Usuario copyWith({
    int? id,
    String? nome,
    String? sobrenome,
    String? email,
    String? senha,
    String? profissao,
    int? idade,
    DateTime? updated_at,
  }){
    return Usuario(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      sobrenome: sobrenome ?? this.sobrenome,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      profissao: profissao ?? this.profissao,
      idade: idade ?? this.idade,
      created_at: this.created_at,
      updated_at: updated_at ?? this.updated_at
    );
  }
}