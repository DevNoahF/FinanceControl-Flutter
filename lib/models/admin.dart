class Admin{
  final String email;
  final String senha;



  const Admin({
    required this.email,
    required this.senha,
  });

  factory Admin.fromJson(Map<String, dynamic> json){
    return Admin(
      email: json["email"] as String,
      senha: json["senha"] as String,
    );
  }

  Map<String, dynamic> toJson(){
    return{
      "email":email,
      "senha":senha,
    };
  }


  Admin copyWith({
    String? email,
    String? senha,
  }){
    return Admin(
      email: email ?? this.email,
      senha: senha ?? this.senha,
    );
  }
}