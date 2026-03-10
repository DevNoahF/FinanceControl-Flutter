class Admin{
  final int id;
  final String email;
  final String senha;



  const Admin({
    required this.id,
    required this.email,
    required this.senha,
  });

  factory Admin.fromJson(Map<String, dynamic> json){
    return Admin(
      id: json['id'] as int,
      email: json["email"] as String,
      senha: json["senha"] as String,
    );
  }

  Map<String, dynamic> toJson(){
    return{
      "id": id,
      "email":email,
      "senha":senha,
    };
  }


  Admin copyWith({
    int? id,
    String? email,
    String? senha,
  }){
    return Admin(
      id:this.id,
      email: email ?? this.email,
      senha: senha ?? this.senha,
    );
  }
}