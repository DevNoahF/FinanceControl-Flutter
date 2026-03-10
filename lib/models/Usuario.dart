class Usuario{
  final int Id;
  final String Nome;
  final String Sobrenome;
  final String Email;
  final String Senha;
  final String Profissao;
  final int Idade;
  final DateTime Created_at;
  final DateTime Updated_at;

  const Usuario({
    required this.Id,
    required this.Nome,
    required this.Sobrenome,
    required this.Email,
    required this.Senha,
    required this.Profissao,
    required this.Idade,
    required this.Created_at,
    required this.Updated_at
  });

}